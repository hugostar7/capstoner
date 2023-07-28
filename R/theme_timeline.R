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
#' # Example 1
#' data = babygrowth
#' ggplot2::ggplot(data, ggplot2::aes(x = DATE, y = AGE, colour = height,
#'                                   size = weight)) +
#'  geom_timeline() + theme_timeline()
#'
#' # Example 2
#' data = my_EQ_clean
#' ggplot2::ggplot(data, ggplot2::aes(x = DATE, y = COUNTRY, colour = Deaths,
#'                                    size = Mag)) +
#'  geom_timeline() + theme_timeline()
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
