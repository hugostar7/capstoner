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
#' \dontrun{
#' library(ggplot2)
#' lcd = eq_location_clean(earthquakes, 2000, 2020, "ALASKA")
#'
#' ggplot2::ggplot(
#'     lcd,
#'     ggplot2::aes(x = DATE, y = COUNTRY)) +
#'     geom_timeline() +
#'     stat_timeline_label(
#'     lcd, ggplot2::aes(x = DATE, y = COUNTRY,
#'                  label = LOCATION_NAME, by = Mag),
#'     colour = "black", size = 3, alpha = NA
#' )
#' }
#'
#' @export
stat_timeline_label <- function(
    mapping = NULL,
    data = NULL,
    geom = "timeline_label",
    position = "identity",
    n_max = NA,
    sgm_len = .25,
    show.legend = FALSE,
    inherit.aes = TRUE,
    na.rm = FALSE,...) {
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
  optional_aes = ggplot2::aes(y = 1, by = 1),
  compute_group = function(data,
                           scales,
                           params,
                           n_max = NA,
                           sgm_len = .25) {
    if(is.null(data$y)) {data$y <- 1}

    if(is.na(n_max)) {
      top = data
    } else {
      stopifnot(!is.null(data$by))
      LEVELS = data$y %>% factor %>% levels
      top = lapply(LEVELS,
                   function(lvl) {
                     data[data$y == lvl, ] %>%
                       dplyr::arrange(., dplyr::desc(.$by)) %>%
                       .[1:n_max, ]
                   }) %>% purrr::reduce(rbind)
    }

    ## Create a numeric columns to use as coordinates
    top$y = factor(top$y)
    levels(top$y) <- 1:length(levels(top$y))
    top$y <- as.numeric(top$y)

    x = top$x
    y = top$y
    xend = top$x
    yend = top$y + sgm_len
    label = top$label
    by = top$by
    data.frame(x = x, y = y, xend = xend, yend = yend,
               label = label, by = by)
  })
