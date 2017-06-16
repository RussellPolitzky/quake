#' @title Show Eqarthquoakes on a map with annotations
#'
#' @description \code{eq_map} takes a \code{data.frame} and with NOAA
#'     earthquake data and plots those on an interactive map, along with
#'     annotations.  In addition to NOAA data, \code{eq_map} also takes a
#'     parameter indicating which \code{data.frame} column to use for
#'     marker, pop-up annotations.
#'
#'     \code{eq_map} expects to find epicenter lattiude, longitude and earthquake
#'     magnitude in the \code{LATTITUDE}, \code{LONGITUDE} and \code{EQ_PRIMARY}
#'     columns, respectively.
#'
#' @param data is a filtered \code{data.frame} containing earthquake data
#'     filtered to show quakes in an area of interest.
#' @param annot_col is a \code{string} which is column name carrying
#'     annotations for marker pop-ups.  The annotation can be plain
#'     text or HTML.
#'
#' @return \code{eq_map} returns a \code{leaflet} map object,
#'
#' @import magrittr
#' @importFrom leaflet leaflet
#' @importFrom leaflet addTiles
#' @importFrom leaflet addCircleMarkers
#'
#' @example examples/example_mapping_functions.R
#'
#' @seealso \link{\code{leaflet}}
#' @export
eq_map <- function(data, annot_col) {
  leaflet::leaflet() %>%
    leaflet::addTiles() %>%
    leaflet::addCircleMarkers(
      data   = data,
      lng    = ~ LONGITUDE,
      lat    = ~ LATITUDE,
      weight = 1,
      radius = ~ EQ_PRIMARY,
      popup  = as.formula(paste( "~", annot_col)) # Note ,as.formula allows dynamic formula creation.
    )
}
