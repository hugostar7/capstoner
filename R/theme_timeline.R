#'Theme Timeline
#'
#'Modify theme_classic() by removing the y_axis, its thicks
#'and title. It also sets the legend position at "bottom"
#'
#' @param ... any arguments to be passed to theme_classic
#'
#' @importFrom ggplot2 %+replace% theme theme_classic
#' @importFrom ggplot2 element_blank
#'
#' @return `theme element`.
#'
#' @examples
#' library(ggplot2)
#' lcd = eq_location_clean(
#' earthquakes, countries = c("PERU", "CHILE")
#' )
#' ggplot2::ggplot(lcd, ggplot2::aes(x = DATE, y = COUNTRY)) +
#' stat_timeline() +
#' theme_timeline()
#'
#' @export
theme_timeline <- function(...) {
  ggplot2::theme_classic(...) %+replace%
    ggplot2::theme(
      axis.line.y = ggplot2::element_blank(),
      axis.title.y = ggplot2::element_blank(),
      axis.ticks.y = ggplot2::element_blank(),
      legend.position = "bottom",
      complete = TRUE
    )
}
