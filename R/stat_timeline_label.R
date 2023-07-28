#' Add annotation layer
#'
#' This geom function add annotation layer to a plot.
#' It constructs a segment line and add text annotation
#' from specified  column in the data
#'
#' @param mapping set of aesthetics.
#' @param data to be displayed in this layer
#' @param geom other layer to use with this funcion
#' @param position position function
#' @param n_max numeric to set how many points to annotate
#' @param sgm_len numeric to set length of segment
#' @param show.legend logical or NA. TRUE will always display
#'                    a legend. FALSE will not. NA will display
#'                    legend only when it is supplied.
#' @param inherit.aes Logical to indicate if this geom should
#'                    inherit aesthetics from the call to
#'                    ggplot or any other top geom
#' @param na.rm Logical to indicate how NAs should be removed.
#'              with warning or not.
#' @param ... other arguments to be passed onto layer
#'
#' @importFrom ggplot2 layer
#'
#' @examples
#' library(ggplot2)
#' library(leaflet)
#' library(raster)
#' library(terra)
#'
#' data = babygrowth
#' ggplot2::ggplot(
#'  data, ggplot2::aes(x = DATE, y = AGE, colour = height,
#'                    size = weight)
#' ) +
#' ggplot2::geom_point() +
#' stat_timeline_label(
#' ggplot2::aes(x = DATE, y = AGE, label = DATE))
#'
#' @export
stat_timeline_label <- function(
    mapping = NULL,
    data = NULL,
    geom = "timeline_label",
    position = "identity",
    show.legend = FALSE,
    inherit.aes = FALSE,
    n_max = NA,
    sgm_len = .1,
    na.rm = FALSE, ...) {
  ggplot2::layer(stat = StatTimelineLabel,
                 geom = geom,
                 mapping = mapping,
                 data = data,
                 position = position,
                 show.legend = show.legend,
                 inherit.aes = inherit.aes,
                 params = list(n_max = n_max,
                               sgm_len = sgm_len,
                               na.rm = na.rm, ...))
}

#' StatTimelineLabel
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
#' @param label string used for annotation
#'        required aesthetic.
#' @param by numeric optional aesthetic used to arrange data
#' @param data data frame to use in statistical transformation
#' @param n_max numeric to subset data before annotation
#' @param sgm_len numeric parameter to set length of segment
#'                used in annotation
#'
#' @importFrom ggplot2 ggproto Stat aes
#' @importFrom purrr reduce
#' @importFrom dplyr arrange desc
#' @importFrom magrittr %>%
StatTimelineLabel <- ggplot2::ggproto(
  "StatTimelineLabel", ggplot2::Stat,
  required_aes = c("x", "label"),
  default_aes = ggplot2::aes(y = .1, orderBy = 1),
  compute_group = function(data,
                           scales,
                           params,
                           n_max = NA,
                           sgm_len = .1) {

    data$sgm_len <- sgm_len

    if(!is.na(n_max)) {
      data = lapply(
        data$y %>% factor %>% levels %>% as.character,
        function(CNTRY) {
          data[data$y == CNTRY, ] %>%
            dplyr::arrange(., dplyr::desc(.$orderBy)) %>%
            .[1:n_max, ]
        }
      ) %>% purrr::reduce(rbind)
    }
    data
  })
