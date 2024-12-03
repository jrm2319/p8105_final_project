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
    ## ── Column specification ────────────────────────────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (7): isbn, authors, original_title, title, language_code, image_url, small_image_url
    ## dbl (16): book_id, goodreads_book_id, best_book_id, work_id, books_count, isbn13, original_publicati...
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
    ## ── Column specification ────────────────────────────────────────────────────────────────────────────────
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
    ## ── Column specification ────────────────────────────────────────────────────────────────────────────────
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
    ## ── Column specification ────────────────────────────────────────────────────────────────────────────────
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
    ## ── Column specification ────────────────────────────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## dbl (2): user_id, book_id
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
view(to_read)
```
