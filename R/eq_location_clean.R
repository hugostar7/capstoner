#' Modify rows or columns in a data frame
#'
#' @description Create COUNTRY and Location_NAME column in a
#' data frame with a Location Name column as in NOAA's earthquakes
#' data frame. Clean Location Name column by splitting it
#' into COUNTRY and LOCATION_NAME columns where COUNTRY
#' contains countries names in upper case and LOCATION_NAME
#' contains locations names in title case. It also trims out
#' white space from the new names. The optional arguments:
#' year_min, year_max, countries can be used to filter the cleaned
#' for some range of years and some countries.
#'
#' @param x data frame with `Location Name` column to be cleaned.
#' @param year_min numeric to set minimum for years in DATE column
#'                 Optional argument with default value 1.
#' @param year_max numeric to set maximum for years in DATE column
#'                 Optional argument with default value 2050.
#' @param countries character vector containing a list of countries
#'                  used to filter the output. Optional argument
#'                  with default value NULL.
#'
#' @return data frame with cleaned COUNTRY and LOCATION_NAME columns
#'
#' @importFrom stringr str_split str_to_title str_squish
#' @importFrom lubridate year
#' @importFrom dplyr mutate between
#' @importFrom magrittr %>%
#'
#' @examples
#' library(magrittr)
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
#' @export
eq_location_clean <- function(x,
                              year_min = 1,
                              year_max = 2050,
                              countries = NULL) {
  cd = eq_clean_data(x)
  cd = cd[dplyr::between(lubridate::year(cd$DATE),
                         year_min, year_max), ]

  CtryLoc = vapply(cd$`Location Name`, function(loc) {
    cl = stringr::str_split(
      loc, ":", n = 2, simplify = FALSE
    )
    c(cl[[1]][1], cl[[1]][2])  %>%
      stringr::str_squish()
  }, FUN.VALUE = c("char", "char"), USE.NAMES = FALSE) %>%
    data.frame %>% t
  row.names(CtryLoc) = NULL
  CtryLoc = data.frame(
    COUNTRY = CtryLoc[ , 1],        # Remove factor( ... )
    LOCATION_NAME = stringr::str_to_title(CtryLoc[ , 2])
  )

  lcd = dplyr::mutate(
    cd,
    COUNTRY = CtryLoc[ , 1],  # Use the tibble itself
    LOCATION_NAME = CtryLoc[ , 2],  # Not its columns
    `Location Name` = NULL)

  if(!is.null(countries)) {
    lcd = lcd[lcd$COUNTRY %in% countries, ]
  }
  lcd
}
