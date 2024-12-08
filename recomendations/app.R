# Load necessary libraries
library(tidyverse)
library(shiny)
library(bslib)
library(dplyr)
library(rmarkdown)
setwd("../")
# Load the data
books <- read_csv("books_with_tags.csv")

# Clean the data
books_clean <- books |> 
  select(-isbn, -ratings_count, -work_ratings_count, -work_text_reviews_count)

# Prepare the data for analysis
books_rate <- books_clean |>
  mutate(average_rating = round(average_rating*2)/2)

# Extract authors
authors <- unique(books_rate$authors)

# Define the UI for the app
ui <- fluidPage(
  
  selectInput("search_by", 
              label = "Search by:", 
              choices = c("Select", "Author", "Genre")),
  
  conditionalPanel(
    condition = "input.search_by == 'Author'",
    selectizeInput("authors", 
                   label = "Start typing an author's name:", 
                   choices = authors, 
                   options = list(
                     placeholder = 'Select an author...',
                     create = FALSE, 
                     maxItems = 1,
                     highlight = TRUE))
  ),
  
  conditionalPanel(
    condition = "input.search_by == 'Genre'",
    selectInput("search_genre", 
                label = "Choose Genre(s):", 
                choices = unique(c(books_rate$top_1, books_rate$top_2, books_rate$top_3, books_rate$top_4, books_rate$top_5)), 
                multiple = TRUE)  
  ),
  
  conditionalPanel( 
    condition = "input.search_by == 'Genre' || input.search_by == 'Author'",
    selectInput("average_rating", 
                label = "Choose Rating:", 
                choices = unique(books_rate$average_rating), 
                selected = NULL)
  ),
  
  actionButton("recommend", "Get Recommendations"),
  
  h3("Your Recommended Books:"),
  uiOutput("book_list")
)

# Define the server logic
server <- function(input, output, session) {
  
  # Create a reactive expression to filter books based on user input
  filtered_books <- reactive({
    booktok <- books_rate
    
    # Filter by genre if selected
    if (length(input$search_genre) > 0) {
      booktok <- booktok %>%
        filter(
          top_1 %in% input$search_genre | 
            top_2 %in% input$search_genre | 
            top_3 %in% input$search_genre | 
            top_4 %in% input$search_genre | 
            top_5 %in% input$search_genre
        )
    }
    
    # Filter by author if selected
    if (input$search_by == "Author" && input$authors != "") {
      booktok <- booktok %>% filter(authors == input$authors)
    }
    
    # Filter by average rating if selected
    if (!is.null(input$average_rating) && input$average_rating != "") {
      booktok <- booktok %>% filter(average_rating == as.numeric(input$average_rating))
    }
    
    booktok %>% distinct(title, .keep_all = TRUE)
  })
  
  # Event listener for the "Get Recommendations" button
  observeEvent(input$recommend, {
    output$book_list <- renderUI({
      booktok <- filtered_books()
      
      # If less than 5 books are found, get books with a lower rating
      if (nrow(booktok) < 5 && !is.null(input$average_rating)) { 
        selected_rating <- as.numeric(input$average_rating)
        
        lower_rating_books <- books_rate %>% 
          filter(average_rating == (selected_rating - 1)) %>% 
          distinct(title, .keep_all = TRUE)
        
        # Only bind rows if there are books with a lower rating
        if (nrow(lower_rating_books) > 0) {
          booktok <- bind_rows(booktok, lower_rating_books)
        }
      }
      
      # Limit to 5 books to show
      books_to_show <- head(booktok, 5)
      
      # Render the UI elements for the recommended books
      if (nrow(books_to_show) > 0) {
        tagList(
          lapply(1:nrow(books_to_show), function(i) {
            lower_rated <- books_to_show$average_rating[i] < as.numeric(input$average_rating)
            
            div(
              img(src = books_to_show$image_url[i], width = "250px", height = "300px"),  
              strong(books_to_show$title[i]), 
              if (lower_rated) {
                span(style = "color: brown; font-weight: bold;", "(Rated Below Your Selection)")
              },
              p(paste("Rating:", books_to_show$average_rating[i]))
            )
          })
        )
      } else {
        p("No books found based on your selection.")
      }
    })
  })
}

shinyApp(ui = ui, server = server)
runApp()
