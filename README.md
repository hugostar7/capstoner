
<!-- README.md is generated from README.Rmd. Please edit that file -->

# capstoner

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/hugostar7/capstoner.svg?branch=main)](https://travis-ci.com/hugostar7/capstoner)
[![R-CMD-check](https://github.com/hugostar7/capstoner/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/hugostar7/capstoner/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of `capstoner` is to provide means to analyse earthquakes data.
Functions in this package can be used to create data visualization tools
such as time series plots and interactive maps of earthquakes data with
specific columns: `Year`, `Mo` for months, `Dy` for days,
`Location Name`, `Longitude`, `Latitude`. The functions
`eq_clean_data()` and `eq_location_clean()` can be used to clean the
data and create the columns: `DATE`, `COUNTRY`, `LOCATION_NAME`
`LONGITUDE`, `LATITUDE` in a format required for our data analysis. The
function `geom_timeline()` creates time series plots which can be
annotated with `geom_timeline_label()`. The function `eq_create_label()`
helps in customizing popups on interactive maps created using
`eq_map()`.

## Installation

You can install the development version of capstoner from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("hugostar7/capstoner")
```

## Example

This is a basic example which shows you how to clean your data using
`eq_clean_data` and `eq_location_clean`

``` r
library(capstoner)
library(magrittr)

data("earthquakes")

# Clean data and create DATE column
cd = eq_clean_data(earthquakes)
head(cd)[ , 33:36]
#> # A tibble: 6 × 4
#>   `Total Houses Damaged Description` DATE       LONGITUDE LATITUDE
#>                                <dbl> <date>         <dbl>    <dbl>
#> 1                                 NA 0037-04-09      36.1     36.1
#> 2                                 NA 0046-10-23     112.      33  
#> 3                                 NA 0079-08-24      14.4     40.8
#> 4                                 NA 0115-12-13      36.1     36.1
#> 5                                 NA 0128-02-23     105.      34.7
#> 6                                 NA 0138-03-01     104.      35.8

# Clean data and create proper COUNTRY and LOCATION_NAME columns
lcd = eq_location_clean(earthquakes)
head(lcd)[ , 33:37]
#> # A tibble: 6 × 5
#>   DATE       LONGITUDE LATITUDE grp_aes    COUNTRY
#>   <date>         <dbl>    <dbl> <chr>      <chr>  
#> 1 0037-04-09      36.1     36.1 NA:NA      TURKEY 
#> 2 0046-10-23     112.      33   6.5:NA     CHINA  
#> 3 0079-08-24      14.4     40.8 NA:NA      ITALY  
#> 4 0115-12-13      36.1     36.1 7.5:260000 TURKEY 
#> 5 0128-02-23     105.      34.7 6.5:NA     CHINA  
#> 6 0138-03-01     104.      35.8 6.8:NA     CHINA
```

You can also create an interactive map for the earthquakes data:

``` r
#earthquakes %>%
  #eq_location_clean() %>% 
  #dplyr::filter(COUNTRY == "MEXICO" &       #lubridate::year(DATE) >= #2000) %>% 
  #eq_map(annot_col = "DATE")

# You can also use eq_location_clean to filter the data
#eq_location_clean(earthquakes, year_min = 2000, countries #= MEXICO") %>%
  #eq_map(annot_col = "DATE")
```

Let’s customize the popups on the previous map using `eq_create_label`

``` r
#earthquakes %>%
  #eq_location_clean() %>% 
  #dplyr::filter(COUNTRY == "MEXICO" & #lubridate::year(DATE) >= 2000) %>% 
  #dplyr::mutate(popup_text = eq_create_label(.)) %>% 
  #eq_map(annot_col = "popup_text")
```
