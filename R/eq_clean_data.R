#' Modify rows or columns in earthquakes data frame
#'
#' @description Clean data frame with specific columns as
#' in earthquakes data frame from NOAA including: `Year` ,
#' `Mo`, `Dy`, `Longitude`, `Latitude`. Unite columns: Year,
#' Mo and Dy to create a date class column DATE. It coerces
#' columns: Longitude and Latitude to numeric class columns:
#' LONGITUDE, LATITUDE. NAs are removed under columns: Year,
#' Mo, Dy used to form the new DATE column. Only Year > 0
#' are considered to ensure compatibility with lubridate package.
#'
#' @param x data frame with columns : Year, Mo, Dy, Longitude,
#' Latitude ...
#'
#' @return data frame
#'
#' @importFrom dplyr mutate
#' @importFrom magrittr %>%
#'
#' @examples
#'
#' @export
eq_clean_data <- function(x) {
  # Remove rows with NAs in date components
  cd = x[(x$Year > 0) & !(is.na(x$Year) |
                            is.na(x$Mo) | is.na(x$Dy)), ] %>%
    # Create requested columns
    dplyr::mutate(
      DATE = paste(Year, Mo, Dy, sep = "-") %>% as.Date,
      LONGITUDE = as.numeric(Longitude),
      LATITUDE = as.numeric(Latitude),
      Longitude = NULL, Latitude = NULL, Year = NULL,
      Mo = NULL, Dy = NULL, `Search Parameters` = NULL
    )
  cd
}
