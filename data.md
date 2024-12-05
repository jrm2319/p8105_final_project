DATA
================
Erynne Jackson
2024-12-01

``` r
library(readxl)
library(tidyverse)
library(readr)
```

Cleaning the Books file.

``` r
url = "https://raw.githubusercontent.com/zygmuntz/goodbooks-10k/refs/heads/master/books.csv"
books = read_csv(url)
```

    ## Rows: 10000 Columns: 23
    ## ── Column specification ───────────────────────────────────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (7): isbn, authors, original_title, title, language_code, image_url, sm...
    ## dbl (16): book_id, goodreads_book_id, best_book_id, work_id, books_count, is...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
view(books)
```

Cleaning the Ratings file.

``` r
url2 = "https://raw.githubusercontent.com/zygmuntz/goodbooks-10k/refs/heads/master/ratings.csv"
ratings = read_csv(url2)
```

    ## Rows: 5976479 Columns: 3
    ## ── Column specification ───────────────────────────────────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl (3): user_id, book_id, rating
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
view(ratings)
```

Cleaning the Book Tags file.

``` r
url3 = "https://raw.githubusercontent.com/zygmuntz/goodbooks-10k/refs/heads/master/book_tags.csv"
book_tag = read_csv(url3)
```

    ## Rows: 999912 Columns: 3
    ## ── Column specification ───────────────────────────────────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl (3): goodreads_book_id, tag_id, count
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
view(book_tag)
```

Cleaning the Tags file.

``` r
url4 = "https://raw.githubusercontent.com/zygmuntz/goodbooks-10k/refs/heads/master/tags.csv"
tags = read_csv(url4)
```

    ## Rows: 34252 Columns: 2
    ## ── Column specification ───────────────────────────────────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (1): tag_name
    ## dbl (1): tag_id
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

Cleaning the To Read file.

``` r
url5 = "https://raw.githubusercontent.com/zygmuntz/goodbooks-10k/refs/heads/master/to_read.csv"
to_read = read_csv(url5)
```

    ## Rows: 912705 Columns: 2
    ## ── Column specification ───────────────────────────────────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl (2): user_id, book_id
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
view(to_read)
```

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
    ## ── Column specification ───────────────────────────────────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (7): isbn, authors, original_title, title, language_code, image_url, sm...
    ## dbl (16): book_id, goodreads_book_id, best_book_id, work_id, books_count, is...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
head(book_data)
```

    ## # A tibble: 6 × 23
    ##   book_id goodreads_book_id best_book_id  work_id books_count isbn        isbn13
    ##     <dbl>             <dbl>        <dbl>    <dbl>       <dbl> <chr>        <dbl>
    ## 1       1           2767052      2767052  2792775         272 439023483  9.78e12
    ## 2       2                 3            3  4640799         491 439554934  9.78e12
    ## 3       3             41865        41865  3212258         226 316015849  9.78e12
    ## 4       4              2657         2657  3275794         487 61120081   9.78e12
    ## 5       5              4671         4671   245494        1356 743273567  9.78e12
    ## 6       6          11870085     11870085 16827462         226 525478817  9.78e12
    ## # ℹ 16 more variables: authors <chr>, original_publication_year <dbl>,
    ## #   original_title <chr>, title <chr>, language_code <chr>,
    ## #   average_rating <dbl>, ratings_count <dbl>, work_ratings_count <dbl>,
    ## #   work_text_reviews_count <dbl>, ratings_1 <dbl>, ratings_2 <dbl>,
    ## #   ratings_3 <dbl>, ratings_4 <dbl>, ratings_5 <dbl>, image_url <chr>,
    ## #   small_image_url <chr>

Remove unnecessary variables (JM):

``` r
book_data = book_data %>%
  select(
    book_id,
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

    ## # A tibble: 1 × 14
    ##   book_id goodreads_book_id  isbn authors title average_rating ratings_count
    ##     <int>             <int> <int>   <int> <int>          <int>         <int>
    ## 1       0                 0   700       0     0              0             0
    ## # ℹ 7 more variables: work_ratings_count <int>, work_text_reviews_count <int>,
    ## #   ratings_1 <int>, ratings_2 <int>, ratings_3 <int>, ratings_4 <int>,
    ## #   ratings_5 <int>

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

Creating merged tag file (SR)

``` r
merged_tags = 
  left_join(book_tag, tags, by = c("tag_id")) %>%
  group_by(goodreads_book_id) %>%
  arrange(desc(count)) %>%
  slice_head(n = 5) %>%
  ungroup()
  

pivoted_data <- merged_tags %>%
  mutate(rank = row_number(), .by = goodreads_book_id) %>% # Add rank for top tags
  pivot_wider(
    id_cols = goodreads_book_id, 
    names_from = rank, 
    values_from = c(tag_name), 
    names_prefix = "top_"
  )


books_with_tags <- left_join(book_data_complete, pivoted_data, by = c("goodreads_book_id"))
```
