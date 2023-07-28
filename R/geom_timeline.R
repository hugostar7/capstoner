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
#' library(ggplot2)
#'
#' # Example 1
#' lcd = eq_location_clean(earthquakes, countries = "ALASKA")
#' ggplot2::ggplot(lcd, ggplot2::aes(x = DATE)) +
#' geom_timeline()
#'
#' # Example 2
#' lcd = eq_location_clean(earthquakes, 2000, 2020, c("CHINA","TURKEY"))
#' ggplot2::ggplot(
#'   lcd,
#'   ggplot2::aes(x = DATE, y = COUNTRY, colour = Deaths, size = Mag)) +
#'   geom_timeline()
#'
#' # Example 3
#' df = data.frame(
#' DATE = c(1,2,3,1,2),
#' COUNTRY = c("C","A","C","B","B")
#' )
#'
#' ggplot2::ggplot(df, ggplot2::aes(x = DATE, y = COUNTRY)) +
#'  geom_timeline(xMin = 2,xMax = 5)
#'
#' # Example 4
#' data = babygrowth
#' ggplot2::ggplot(data, ggplot2::aes(x = DATE, y = 1, colour = height,
#'                                   size = weight)) +
#'  geom_timeline(alpha = .5)
#'
#' # Example 5
#' data = babygrowth
#' ggplot2::ggplot(data, ggplot2::aes(x = DATE, y = AGE, colour = height,
#'                                   size = weight)) +
#'  geom_timeline()
#'
#' # Example 6
#' data = my_EQ_clean
#' ggplot2::ggplot(data, ggplot2::aes(x = DATE, y = COUNTRY, colour = Deaths,
#'                                    size = Mag)) +
#'  geom_timeline()
#'
#' # Example 7
#' data = my_EQ_clean
#' ggplot2::ggplot(data, ggplot2::aes(x = DATE, colour = Deaths, size = Mag)) +
#'   geom_timeline()
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
#' @param colour, default aesthetic to map number of deaths caused by earthquakes
#' @param alpha, default aesthetic for transparency
#' @param size default aesthetic to define size of points
#' @param shape default aesthetic for shape of points used.
#' @param linetype default aesthetic for type of line
#' @param linewidth, default aesthetic for line with
#' @param line_col, default aesthetic for line colour
#' @param linealpha default aesthetic for line alpha channel
GeomTimeline <- ggplot2::ggproto(
  "GeomTimeline", ggplot2::Geom,

  # Required aesthetics
  required_aes = c("x"),

  # Default aesthetics
  default_aes = ggplot2::aes(y = .1,
                             shape = 19,
                             size = 1.5,
                             colour = "black",
                             alpha = 0.3,
                             stroke = .5,
                             fill = NA,
                             linetype = 1,
                             linewidth = 3,
                             linecolour = "grey",
                             linealpha =.8),

  # Legend key
  draw_key = ggplot2::draw_key_point,

  # Draw panel function
  draw_panel = function(data, panel_params, coord, ...) {

    # Define constants point and stroke sizes
    ptsz = 2.845276; strksz = 1.889764

    # Transform data
    coords <- coord$transform(data, panel_params, ...)

    # Compute stroke_size
    stroke_size = ifelse(
      !is.na(coords$stroke), coords$stroke, 0
    )
    # Compute alpha for lines
    line_alpha = ifelse(
      !is.na(coords$linealpha) &
        coords$linealpha >= 0 & coords$linealpha <= 1,
      coords$linealpha,
      1
    )

    # Create all grobs
    DateLines <- grid::polylineGrob(
      x = grid::unit(
        rep(c(0, 1), length(coords$y)), "npc"
      ),
      y = rep(coords$y, each = 2),
      id.length = rep(2,length(coords$y)),
      gp = grid::gpar(col = coords$linecolour,
                      lwd = coords$linewidth,
                      lty = coords$linetype,
                      alpha = coords$linealpha)
    )

    EQs <- grid::pointsGrob(
      x = coords$x,
      y = coords$y,
      pch = coords$shape,
      gp = grid::gpar(
        col = ggplot2::alpha(coords$colour, coords$alpha),
        fill = ggplot2::alpha(coords$fill, coords$alpha),
        lwd = coords$stroke * strksz,
        fontsize = coords$size * ptsz + coords$stroke * strksz
      )
    )

    # Return all grobs
    grid::gTree(children = grid::gList(
      DateLines, EQs
    ))
  }
)
