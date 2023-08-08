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
#' data = babygrowth
#'
#' ggplot2::ggplot(
#'  data, ggplot2::aes(x = DATE, y = AGE, colour = height,
#'                    size = weight)
#' ) +
#' ggplot2::geom_point() +
#' geom_timeline_label(
#' data, ggplot2::aes(x = DATE, y = AGE, label = DATE))
#'
#' @export
geom_timeline_label <- function(data = NULL,
                                mapping = NULL,
                                stat = "timeline_label",
                                position = "identity",
                                inherit.aes = FALSE,
                                show.legend = FALSE,
                                na.rm = FALSE, ...) {
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
#' @param linewidth, default aesthetic for vertical segments.
#' @param linetype description.
#' @param linecolour default aesthetic for color of horizontal lines.
#' @param lineaplha colours alpha channel for vertical segments.
GeomTimelineLabel <- ggplot2::ggproto(
  "GeomTimelineLabel", ggplot2::Geom,

  # Required aesthetics
  required_aes = c("x", "label"),

  # Default aesthetics
  default_aes = ggplot2::aes(
    y = .1, orderBy = 1,
    colour = "black", alpha = NA,
    linewidth = 1, linetype = 1,
    angle = 45, fontsize = 8,
    hjust = 0, vjust = 0, just = 0
  ),

  # Draw panel function
  draw_panel = function(data,
                        panel_params,
                        coord,
                        n_max = 5,
                        sgm_len = .1, ...) {

    # Transform data
    coords <- coord$transform(data, panel_params, ...)

    # Construct the grobs
    ## The segments
    SEGMENTS <- grid::segmentsGrob(
      x0 = coords$x,
      y0 = coords$y,
      x1 = coords$x,
      y1 = grid::unit(coords$y + coords$sgm_len, "npc"),
      default.units = "npc",
      gp = grid::gpar(col = coords$colour,
                      lwd = coords$linewidth,
                      lty = coords$linetype)
    )

    ## The labels
    LABELS <- grid::textGrob(
      label = coords$label,
      x = coords$x,
      y = grid::unit(coords$y + coords$sgm_len, "npc"),
      rot = coords$angle,
      hjust = coords$hjust,
      vjust = coords$vjust,
      just = coords$just,
      gp = grid::gpar(fontsize = coords$fontsize,
                      col = coords$colour)
    )

    # Return all grobs
    grid::gTree(
      children = grid::gList(SEGMENTS, LABELS)
    )
  }
)
