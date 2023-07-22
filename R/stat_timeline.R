#' Add layer: Time Series Plots
#'
#' Compute layers to be added when mapping variables
#' in data transformed by StatTimeline to aesthetics
#' to create plots
#'
#' @param xMin date parameter used to subset data
#' @param xMax date parameter used to subset data
#' @param mapping, set of aesthetics
#' @param data, data used in statistical transformation
#' @param geom geom layer function to call
#' @param position where to plot each group of graphical element
#' @param na.rm logical parameter to indicate how NAs data should be removed
#' @param show.legend logical or NA. TRUE always display legend,
#'        FALSE does not. NA display legend only if suuplied.
#' @param inherit.aes logical to indicate whether to inherit aes
#'        from ggplot or other top geoms
#' @param ... other arguments to be passed
#'
#' @importFrom ggplot2 layer
#'
#' @examples
#' library(ggplot2)
#' lcd = eq_location_clean(
#' earthquakes, countries = c("PERU", "CHILE")
#' )
#' ggplot2::ggplot(lcd, ggplot2::aes(x = DATE, y = COUNTRY)) +
#' stat_timeline()
#'
#' @export
stat_timeline <- function(
    mapping = NULL,
    data = NULL,
    geom = "timeline",
    position = "identity",
    xMin = as.Date("0001-01-01"),
    xMax = as.Date("2050-12-31"),
    show.legend = NA,
    inherit.aes = TRUE,
    na.rm = FALSE,...) {
  ggplot2::layer(stat = StatTimeline,
                 geom = geom,
                 mapping = mapping,
                 data = data,
                 position = position,
                 show.legend = show.legend,
                 inherit.aes = inherit.aes,
                 params = list(xMin = xMin,
                               xMax = xMax,
                               na.rm = na.rm, ...))
}

#' StatTimeline
#'
#' ggproto object of Stat class to define aesthetics
#' and for statitical transformation
#'
#' @format NULL
#' @usage NULL
#' @keywords internal
#' @param x vector of type date, required aesthetic to
#'        map dates of occurrence of earthquakes
#' @param y string, optional aesthetic
#' @param xMin date parameter used to subset data
#' @param xMax date parameter used to subset data
#' @param alpha transparency chanel for points.
#' @param colour default aesthetic for color points
#' @param size default aesthetic  for size of points
#' @param grp_aes default aesthetic to define grouping
#'                structure in a data frame.
#' @importFrom ggplot2 ggproto Stat aes
StatTimeline <- ggplot2::ggproto(
  "StatTimeline", ggplot2::Stat,
  required_aes = c("x"),
  default_aes = ggplot2::aes(y = 1),
  compute_group = function(data,
                           scales,
                           params,
                           xMin = as.Date("0001-01-01"),
                           xMax = as.Date("2050-12-31")) {
    ## Compute points on the timeline
    out = data[data$x >= xMin & data$x <= xMax, ]
    x = out$x
    y = ifelse(!is.null(out$y), out$y, 1)

    #y = factor(y)
    #levels(y) <- 1:length(levels(y))
    #y <- as.numeric(y)

    ## Return data frame
    data.frame(x = x, y = y, xMin = xMin, xMax = xMax)
  })
