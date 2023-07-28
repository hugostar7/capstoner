#' Earthquakes data
#'
#' @source From US NOAA's website
#'  \url{https://www.ngdc.noaa.gov/hazel/view/hazards/earthquake}
#'
#' @format A \code{tibble} with `r {nrow(earthquakes)}`
#'         observations and `r {length(names(earthquakes))}` columns
#' \describe{   # Documenting some columns
#'   \item{Year}{Year when earthquake occurred}
#'   \item{Mo}{Month when earthquake occurred}
#'   \item{Dy}{Day when earthquake occurred}
#'   \item{Mag}{Magnitude of the earthquake}
#'   \item{Longitude}{Longitude of location where the earthquake occurred}
#'   \item{Latitude}{Latitude of location where the earthquake occurred}
#'   }
#'
#' @examples
#' earthquakes
#'
#' head(earthquakes, 10)
#'
"earthquakes"
