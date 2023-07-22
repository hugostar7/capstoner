#' Create interactive map with popup annotation
#'
#' This function uses functions from `leaflet package`
#' to create an interactive map with popup annotation.
#' The column to be used for annotation should be a
#' vector character or a string supplied through the
#' `annot_col` argument. Each row of the `data` supplied
#' is represented on the map with a `circle`  at LONGITUDE
#' and LATITUDE on that row. The radius of the circle is
#' proportional to the Mag on that row. The annotation is
#' displayed by clicking on the circle.
#'
#' @param data data frame with LONGITUDE, LATITUDE and
#'             Mag columns
#' @param annot_col string used for popup annotation
#'
#' @return list or map
#'
#' @importFrom dplyr rename
#' @importFrom leaflet leaflet addTiles addCircleMarkers
#' @importFrom magrittr %>%
#'
#' @examples
#' lcd = eq_location_clean(earthquakes, 2000, 2020, "ALASKA")
#' eq_map(lcd, annot_col = "DATE")
#'
#' @export
eq_map <- function(data, annot_col) {
  annot_col = as.character(annot_col) # This line is added to
  df = dplyr::rename(data, # avoid warning about external column
                     "annot_col" = paste(annot_col))
  leaflet::leaflet() %>%
    leaflet::addTiles() %>%
    leaflet::addCircleMarkers(
      data = df,
      lng = ~ LONGITUDE,
      lat = ~ LATITUDE,
      radius = ~ Mag,
      popup = ~ annot_col,
      label = ~ annot_col,
      fillOpacity = .4
    )
}
