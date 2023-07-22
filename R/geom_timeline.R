#' Create Time Series Plots Of Earthquakes
#'
#' Layer function for ggproto GeomTimeline class
#' This function plots time series by adding a layer of
#' a point on horizontal line for each row in the plot
#' data supplied.
#'
#' @param data data to be displayed in this layer
#' @param mapping set of aesthetics
#' @param stat statistical transformation to use on data
#' @param position position function to use
#' @param show.legend logical or NA.
#' @param inherit.aes logical to indicate if this geom function
#'        should inherit aesthetics from the call to ggplot
#'        or any other top geom.
#' @param na.rm logical to indicate how NAs should be removed:
#'        with or without warning
#' @param ... other parameters to be passed to layer()
#'
#' @return list or map
#'
#' @importFrom ggplot2 layer
#'
#' @examples
#' \dontrun{
#' # Example 1
#' lcd = eq_location_clean(earthquakes, countries = "ALASKA")
#' ggplot2::ggplot(lcd, ggplot2::aes(x = DATE)) +
#' geom_timeline()
#'
#' # Example 2
#' lcd = eq_location_clean(earthquakes, 2000, 2020,
#' c("CHINA","TURKEY"))
#' ggplot2::ggplot(
#'  lcd,
#'  ggplot2::aes(x = DATE, y = COUNTRY, colour = Deaths,
#'               size = Mag, group = 1:nrow(lcd))) +
#'  geom_timeline() + theme_timeline()
#'
#' # Example 3
#' df = data.frame(
#' DATE = c(1,2,3,1,2),
#' COUNTRY = c("C","A","C","B","B")
#' )
#'
#' ggplot2::ggplot(df, ggplot2::aes(x = DATE, y = COUNTRY)) +
#'  geom_timeline(xMin=1,xMax=3)
#'
#' # Example 4
#' dat = data.frame(
#' DATE = as.Date(c("2010-10-23", "2010-12-24", "2010-5-13",
#'                 "2010-5-27","2010-01-13","2010-7-18",
#'                 "2010-03-16","2010-01-13","2010-7-18",
#                 "2010-03-16","2010-10-23", "2010-12-24")),
#' age = c(1,2,2,1,3,3,2,3,1,4,4,3),
#' height = c(1,2,3,1,3,3,4,3,4,5,7,5),
#' weight = c(2,1,3,2,2,3,4,2,3,6,6,5)
#' )
#'
#' ggplot2::ggplot(dat, ggplot2::aes(x = DATE, y = 1, colour = height,
#'                                  size = weight, group = 1:nrow(dat))) +
#'  geom_timeline(alpha = .5) + theme_timeline()
#' }
#'
#' @export
geom_timeline <- function(data = NULL,
                          mapping = NULL,
                          stat = "timeline",
                          position = "identity",
                          show.legend = NA,
                          inherit.aes = TRUE,
                          na.rm = FALSE, ...) {
  ggplot2::layer(
    data = data,
    mapping = mapping,
    geom = GeomTimeline,
    stat = stat,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}

#' GeomTimeline
#' ggproto object of class Geom. Builds grobs for the layer function
#' geom_timeline()
#' @format NULL
#' @usage NULL
#' @keywords internal
#' @importFrom ggplot2 Geom ggproto draw_key_point aes
#' @importFrom grid pointsGrob segmentsGrob gpar gTree gList
#' @export
#' @param x required aesthetic to map dates of occurrence of earthquakes
#' @param y string, required aesthetic to map countries of occurrence of earthquakes
#' @param color, default aesthetic to map number of deaths caused by earthquakes
#' @param alpha, default aesthetic for transparency
#' @param size default aesthetic to define size of points
#' @param shape default aesthetic for shape of points used.
#' @param linewidth, default aesthetic for horizontal lines
#' @param line_col, default aesthetic for color of horizontal lines
GeomTimeline <- ggplot2::ggproto(
  "GeomTimeline", ggplot2::Geom,
  required_aes = c("x", "y", "xMin", "xMax"),
  default_aes = ggplot2::aes(
    shape = 19,
    colour = "black",
    size = 2,
    fill = NA,
    alpha = .3,
    stroke = NA,
    line_col = "grey",
    line_alpha = .7,
    linetype = 1,
    linewidth = 1
  ),
  draw_key = ggplot2::draw_key_point,
  draw_panel = function(data, panel_params, coord, ...) {

    # Transform the data
    coords <- coord$transform(data, panel_params)
    EQ <- grid::pointsGrob(
      x = coords$x,
      y = coords$y,
      pch = coords$shape,
      gp = grid::gpar(col = coords$colour,
                      cex = .25 * coords$size,
                      fill = coords$fill,
                      alpha = coords$alpha,
                      stroke = coords$stroke))

    DateLine <- grid::segmentsGrob(
      x0 = coords$xMin - coords$xMax,
      y0 = coords$y,
      x1 = coords$xMax - coords$xMin,
      y1 = coords$y,
      gp = grid::gpar(col = coords$line_col,
                      lwd = coords$linewidth,
                      lty = coords$linetype,
                      alpha = coords$line_alpha))

    # Return all grobs
    grid::gList(DateLine, EQ)
  }
)
