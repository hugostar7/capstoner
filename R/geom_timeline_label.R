#' Add annotation to time series plots
#'
#' This function bulds annotation layer by adding segment
#' and text label for each row of the plot data
#'
#' @param data data frame to display in this layer
#' @param mapping set of aesthetics
#' @param stat statistical transformation to perform on data
#' @param position position function
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
#' @importFrom ggplot2  layer
#'
#' @examples
#' library(ggplot2)
#' lcd = eq_location_clean(earthquakes, 2000, 2020, "ALASKA")
#'
#' ggplot2::ggplot(
#'     lcd,
#'     ggplot2::aes(x = DATE, y = COUNTRY, size = Mag,
#'                  colour = Deaths, group = 1:nrow(lcd))) +
#'     geom_timeline() +
#'     geom_timeline_label(
#'     lcd, ggplot2::aes(x = DATE, y = COUNTRY,
#'                  label = LOCATION_NAME, by = Mag),
#'     colour = "black", size = 3, alpha = NA
#' )
#'
#' @export
geom_timeline_label <- function(data = NULL,
                                mapping = NULL,
                                stat = "timeline_label",
                                position = "identity",
                                inherit.aes = FALSE,
                                show.legend = FALSE,
                                na.rm = TRUE, ...) {
  ggplot2::layer(
    data = data,
    mapping = mapping,
    geom = GeomTimelineLabel,
    stat = stat,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}

#' GeomTimelineLabel
#'
#' ggproto object of class Geom. Builds annotation grobs
#' for the layer function geom_timeline_label()
#'
#' @format NULL
#' @usage NULL
#' @keywords internal
#' @importFrom ggplot2 Geom ggproto aes
#' @importFrom grid textGrob segmentsGrob gTree gList
#' @export
#' @param x required aesthetic to map dates of occurrence of earthquakes
#' @param y string, required aesthetic to map countries of
#'          occurrence of earthquakes
#' @param xend description
#' @param yend description
#' @param label description
#' @param by description
#' @param colour default aesthetic to map number of deaths
#'              caused by earthquakes
#' @param angle description
#' @param alpha, default aesthetic for transparency
#' @param size default aesthetic to define size of points
#' @param hjust default aesthetic for shape of points used.
#' @param vjust description
#' @param linewidth, default aesthetic for horizontal lines
#' @param linetype description
#' @param lineheight default aesthetic for color of horizontal lines
#' @param group description
#' @param family description
GeomTimelineLabel <- ggplot2::ggproto(
  "GeomTimelineLabel", ggplot2::Geom,

  required_aes = c("x", "y", "xend","yend", "label", "by"),
  default_aes = ggplot2::aes(
    colour = "black", linewidth = 1, linetype = 1,
    lineheight = 1, fontface = 1, size = 3, alpha = 1,
    hjust = 0, vjust = 0.5, just = .5, angle = 45
  ),

  draw_panel = function(data, panel_params, coord, ...) {
    # Transform the data
    #coords <- coord$transform(data, panel_params, ...)
    SEGMENTS = transform(data)
    LABELS = transform(data, x = x, y = yend, label = label)

    # Construct the grobs
    grid::gList(
      ggplot2::GeomSegment$draw_panel(
        SEGMENTS, panel_params, coord, ...
      ),
      ggplot2::GeomText$draw_panel(
        LABELS, panel_params, coord, ...
      )
    )
  }
)
