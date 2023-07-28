#' Modify rows or columns in earthquakes data frame
#'
#' @description `eq_clean_data()` clean data frame with specific
#' columns as in earthquakes data from NOAA by uniting columns:
#' Year, Mo and Dy to create a date class column DATE. It coerces
#' columns: Longitude and Latitude to numeric class columns:
#' LONGITUDE, LATITUDE. Needless to say, your data should contain
#' columns named: Year, Mo, Dy, Longitude and Latitude. The same
#' tasks can be performed by `eq_location_clean()`. In addition,
#' it splits Location Name column into LOCATION_NAME(title case)
#' and COUNTRY(upper case). It can be used to filter the data for
#' some range of years and for some countries supplied as vector.
#'
#' @param x data frame with columns : Year, Mo, Dy, Longitude,
#'                 Latitude, Location Name ...
#'
#' @return data frame with columns:
#'         DATE, COUNTRY, LONGITUDE, LATITUDE, ...
#'
#' @importFrom dplyr mutate
#' @importFrom magrittr %>%
#'
#' @examples
#' # Clean earthquakes data
#' eq_clean_data(earthquakes)
#'
#' # Clean my df
#' df = data.frame(
#'   Year = 2001:2005, Mo = 1:5, Dy = 11:15,
#'   Longitude = 21:25, Latitude = 31:35
#' )
#'
#' eq_clean_data(df)
#'
#' # Clean earthquakes data frame
#' eq_location_clean(earthquakes)
#'
#' # Clean earthquakes data and filter data for specific countries
#' eq_location_clean(earthquakes, countries = "ALASKA")
#' eq_location_clean(earthquakes, countries = c("PERU", "FRANCE", "ITALY"))
#'
#' # Clean earthquakes data and filter data for a minimum or maximum year
#' eq_location_clean(earthquakes, year_min = 1970)
#' eq_location_clean(earthquakes, year_max = 1975)
#' eq_location_clean(earthquakes, year_min = 1970, year_max = 2000)
#'
#' # Clean earthquakes data and filter data for specific countries
#' # and years range
#' eq_location_clean(earthquakes, 1970, 2000, c("PERU", "FRANCE", "ITALY"))
#'
#'
#' @export
eq_clean_data <- function(x) {

  # Remove rows with NAs in date components
  cd = x[(x$Year > 0) & !(is.na(x$Year) |
                            is.na(x$Mo) | is.na(x$Dy)), ] %>%

    # Create DATE column, coerce Long, Lat to numeric
    dplyr::mutate(
      DATE = paste(Year, Mo, Dy, sep = "-") %>% as.Date,
      LONGITUDE = as.numeric(Longitude),
      LATITUDE = as.numeric(Latitude),
      Longitude = NULL, Latitude = NULL, Year = NULL,
      Mo = NULL, Dy = NULL, `Search Parameters` = NULL
    )

  cd
}
