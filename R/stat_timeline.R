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
#' # Example 1
#' lcd = eq_location_clean(earthquakes, countries = "ALASKA")
#' ggplot2::ggplot(lcd, ggplot2::aes(x = DATE)) +
#' stat_timeline()
#'
#' # Example 2
#' lcd = eq_location_clean(earthquakes, 2000, 2020, c("CHINA","TURKEY"))
#' ggplot2::ggplot(
#'   lcd,
#'   ggplot2::aes(x = DATE, y = COUNTRY, colour = Deaths, size = Mag)) +
#'   stat_timeline()
#'
#' # Example 3
#' df = data.frame(
#' DATE = c(1,2,3,1,2),
#' COUNTRY = c("C","A","C","B","B")
#' )
#'
#' ggplot2::ggplot(df, ggplot2::aes(x = DATE, y = COUNTRY)) +
#'  stat_timeline(xMin = 2,xMax = 5)
#'
#' # Example 4
#' data = babygrowth
#' ggplot2::ggplot(data, ggplot2::aes(x = DATE, y = 1, colour = height,
#'                                   size = weight)) +
#'  stat_timeline(alpha = .5)
#'
#' # Example 5
#' data = babygrowth
#' ggplot2::ggplot(data, ggplot2::aes(x = DATE, y = AGE, colour = height,
#'                                   size = weight)) +
#'  stat_timeline()
#'
#' # Example 6
#' data = my_EQ_clean
#' ggplot2::ggplot(data, ggplot2::aes(x = DATE, y = COUNTRY, colour = Deaths,
#'                                    size = Mag)) +
#'  stat_timeline()
#'
#' # Example 7
#' data = my_EQ_clean
#' ggplot2::ggplot(data, ggplot2::aes(x = DATE, colour = Deaths, size = Mag)) +
#'   stat_timeline()
#
#'
#' @export
stat_timeline <- function(
    mapping = NULL,
    data = NULL,
    geom = "timeline",
    position = "identity",
    show.legend = NA,
    inherit.aes = TRUE,
    na.rm = FALSE,
    xMin = as.Date("0001-01-01"),
    xMax = as.Date("2050-12-31"),...) {

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
#' @importFrom ggplot2 ggproto Stat aes
StatTimeline <- ggplot2::ggproto(

  "StatTimeline", ggplot2::Stat,

  required_aes = c("x"),

  compute_group = function(data,
                           scales,
                           params,
                           xMin = as.Date("0001-01-01"),
                           xMax = as.Date("2050-12-31"), ...) {

    ## Select EQs in specified time range
    data[data$x >= xMin & data$x <= xMax, ]
  })
