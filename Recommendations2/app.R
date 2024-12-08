
library(shiny)
library(tidyverse)
library(bslib)
library(dplyr)
library(readr)
library(rsconnect)

books_rate <- read_csv("books_rate.csv")

authors <- unique(books_rate$authors)


ui <- fluidPage(
  
  titlePanel("Welcome to Our Recommendations Page!"), 
  
  p("Looking for a new romance book? Want to get into some classics? Looking to read another book by your favorite author? Fear not! You can find book recommendations right here. Search by your favorite author or genre and your preferred rating.
         
         
         Have fun reading!"
  ),
  
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

server <- function(input, output, session) {
  
  filtered_books <- reactive({
    booktok <- books_rate
    
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
    
    if (input$search_by == "Author" && input$authors != "") {
      booktok <- booktok %>% filter(authors == input$authors)
    }
    
    
    if (!is.null(input$average_rating) && input$average_rating != "") {
      booktok <- booktok %>% filter(average_rating == as.numeric(input$average_rating))
    }
    
    booktok %>% distinct(title, .keep_all = TRUE)
  })
  
  observeEvent(input$recommend, {
    output$book_list <- renderUI({
      booktok <- filtered_books()
      
      if (nrow(booktok) < 5 && !is.null(input$average_rating)) { 
        selected_rating <- as.numeric(input$average_rating)
        
        lower_rating_books <- books_rate %>% 
          filter(average_rating == (selected_rating - 1)) %>% 
          distinct(title, .keep_all = TRUE)
        
        # Only bind rows if there are books with lower rating
        if (nrow(lower_rating_books) > 0) {
          booktok <- bind_rows(booktok, lower_rating_books)
        }
      }
      
      books_to_show <- head(booktok, 5)
      
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

