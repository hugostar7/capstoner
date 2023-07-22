#' Create HTML text for popup annotation
#'
#' Create string to be used for popup annotation on a map.
#' It requires columns: LOCATION_NAME, Total Deaths
#' and Mag from your data frame
#'
#' @param data data frame used to create the string
#'
#' @return character vector or string
#'
#' @importFrom htmltools HTML
#'
#' @examples
#' # Annotation text to use in popup
#' lcd = eq_location_clean(earthquakes, 2000, 2020, "JAPAN")
#' eq_create_label(lcd)
#'
#' @export
eq_create_label <- function(data) {
  lab_els <- c("Location", "Total Deaths", "Magnitude")
  val_ues <- list(
    data$LOCATION_NAME, data$`Total Deaths`, data$Mag
  )
  lapply(
    1:nrow(data),
    function(i) {
      popup_string = ""
      for (j in 1:3) {
        popup_string = ifelse(
          !is.na(val_ues[[j]][i]),
          paste(popup_string, "<b>", lab_els[j], ":</b>",
                val_ues[[j]][i], "<br/>"),
          popup_string
        )
      }
      popup_string
    }
  ) %>%
    lapply(htmltools::HTML)
}
