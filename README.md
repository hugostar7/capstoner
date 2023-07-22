
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
`eq_maps()`.

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
#cd = eq_clean_data(earthquakes)
#head(cd)[ , 33:37]

# Clean data and create proper COUNTRY and LOCATION_NAME columns
#lcd = eq_location_clean(earthquakes)
#head(lcd)[ , 35:38]
```

You can also create an interactive map for the earthquakes data:

``` r
#earthquakes %>%
  #eq_location_clean() %>% 
  #dplyr::filter(COUNTRY == "MEXICO" & lubridate::year(DATE) >= 2000) %>% 
  #eq_map(annot_col = "DATE")

# You can also use eq_location_clean to filter the data
#eq_location_clean(earthquakes, year_min = 2000, countries = "MEXICO") %>%
  #eq_map(annot_col = "DATE")
```

Let’s customize the popups on the previous map using `eq_create_label`

``` r
#earthquakes %>%
  #eq_location_clean() %>% 
  #dplyr::filter(COUNTRY == "MEXICO" & lubridate::year(DATE) >= 2000) %>% 
  #dplyr::mutate(popup_text = eq_create_label(.)) %>% 
  #eq_map(annot_col = "popup_text")
```
