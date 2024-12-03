P8105 Final Project
================
2024-11-04

Authors: Jasmin Martinez (jrm2319), Samiha Reza (sr4081), Kamiah Brown
(kab2310), Erynne Jackson (ej2520), Elliot Kim (ek3376)

## **Tentative Project Title: To Be Read or Not To Be Read**

### **The motivation for this project**:

For this project, we would like to better understand reader’s genre and
author preferences in the United States. By identifying which genres and
authors are most and less read, as well as frequently kept/unkept, we
can gain insights into trends of literary engagement. This information
could provide publishers, authors, and libraries insight into tailoring
their offerings to meet reader’s demand and promoting less-read genres.
Understanding popular genres and authors can also help explore cultural
trends that resonate with the general public while identifying
lesser-read genres to create opportunities for re-engagement.

### **The intended final products**:

Website with the following tabs: About Analysis Dashboard Report –
Hypothesis Testing Results Recommendations page

**The tentative project Title**: To Be Read or Not To Be Read

**The motivation for this project**: For this project, we would like to
better understand reader’s genre and author preferences in the United
States. By identifying which genres and authors are most and less read,
as well as frequently kept/unkept, we can gain insights into trends of
literary engagement. This information could provide publishers, authors,
and libraries insight into tailoring their offerings to meet reader’s
demand and promoting less-read genres. Understanding popular genres and
authors can also help explore cultural trends that resonate with the
general public while identifying lesser-read genres to create
opportunities for re-engagement.

**The intended final products**:

A Website with:

- About

- Analysis

- Dashboard

- Report – Hypothesis Testing Results

- Recommendations page

### **The anticipated data sources**:

We plan to use open source data from GoodReads:
(<https://github.com/zygmuntz/goodbooks-10k>)

### **The planned analyses/visualizations/ coding challenges**:

Planned analyses include finding the most read/least read/most
to-be-read genres, and statistics on the top ten users. Planned
visualization on types of books, timelines for reading and adding books,
book ratings, and top ten users. We will use analyses and visualizations
to create a data-based recommendation list.

### **Planned Timeline**:

**Nov. 4**: Initial Planning Meeting  
**Nov. 8, 1:00pm**: Submit Proposal  
**Nov 11-18**: Project Review Meeting  
**(Tentative) Nov 18**: Group Check-In \#1  
**(Tentative) Nov 25**: Group Check-In \#2  
**(Tentative) Dec 2**: Group Check-In \#3: Project Draft Due
(Internal)  
**Dec 2-7**: Edit and Finalize Project  
**Dec 7, 11:59pm**: Submit Report  
**Dec 7, 11:59pm**: Webpage and screencast due  
**Dec 7, 11:59pm**: Peer Assessment due  
**Dec 12**:In-Class Discussion of Projects

Set Up (KB):

``` r
library(readr)
library(dplyr)
```

Import data (JM):

``` r
book_data = read_csv("Books.csv")
```

    ## Rows: 10000 Columns: 23
    ## ── Column specification ────────────────────────────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (7): isbn, authors, original_title, title, language_code, image_url, small_image_url
    ## dbl (16): book_id, goodreads_book_id, best_book_id, work_id, books_count, isbn13, original_publicati...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
head(book_data)
```

    ## # A tibble: 6 × 23
    ##   book_id goodreads_book_id best_book_id  work_id books_count isbn             isbn13 authors           
    ##     <dbl>             <dbl>        <dbl>    <dbl>       <dbl> <chr>             <dbl> <chr>             
    ## 1       1           2767052      2767052  2792775         272 439023483 9780439023480 Suzanne Collins   
    ## 2       2                 3            3  4640799         491 439554934 9780439554930 J.K. Rowling, Mar…
    ## 3       3             41865        41865  3212258         226 316015849 9780316015840 Stephenie Meyer   
    ## 4       4              2657         2657  3275794         487 61120081  9780061120080 Harper Lee        
    ## 5       5              4671         4671   245494        1356 743273567 9780743273560 F. Scott Fitzgera…
    ## 6       6          11870085     11870085 16827462         226 525478817 9780525478810 John Green        
    ## # ℹ 15 more variables: original_publication_year <dbl>, original_title <chr>, title <chr>,
    ## #   language_code <chr>, average_rating <dbl>, ratings_count <dbl>, work_ratings_count <dbl>,
    ## #   work_text_reviews_count <dbl>, ratings_1 <dbl>, ratings_2 <dbl>, ratings_3 <dbl>, ratings_4 <dbl>,
    ## #   ratings_5 <dbl>, image_url <chr>, small_image_url <chr>

Remove unnecessary variables (JM):

``` r
book_data = book_data %>%
  select(
    goodreads_book_id,  
    isbn,                
    authors,             
    title,               
    average_rating,      
    ratings_count,       
    work_ratings_count,  
    work_text_reviews_count, 
    ratings_1,           
    ratings_2,           
    ratings_3,           
    ratings_4,           
    ratings_5            
  )
```

Check for missing (JM):

``` r
missing_summary = book_data %>%
  summarise(across(everything(), ~ sum(is.na(.)), .names = "{.col}"))

print(missing_summary)
```

    ## # A tibble: 1 × 13
    ##   goodreads_book_id  isbn authors title average_rating ratings_count work_ratings_count
    ##               <int> <int>   <int> <int>          <int>         <int>              <int>
    ## 1                 0   700       0     0              0             0                  0
    ## # ℹ 6 more variables: work_text_reviews_count <int>, ratings_1 <int>, ratings_2 <int>, ratings_3 <int>,
    ## #   ratings_4 <int>, ratings_5 <int>

There are 700 entries missing from the ‘missing_isbn’ variable.

Removing missing values (JM):

``` r
book_data_complete = book_data %>%
  filter(!is.na(isbn))
```

Creating new csv file for use (JM):

``` r
write.csv(book_data_complete, "book_data_complete.csv", row.names = FALSE)
```
