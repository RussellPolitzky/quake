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

#' @title Create an HTML pop-up label showing location, magnitude and total_deaths
#'
#' @description \code{eq_create_label} takes a NOAA \code{data.frame} with columns
#'     \code{clean_location}, \code{EQ_PRIMARY} and \code{TOTAL_DEATHS} and produces
#'     a vector of \code{string}s with HTML encoded labels showing the location,
#'     magnitude and total, associated deaths caused the each quake.
#'
#' @param data is a \code{data.frame} with \code{clean_location}, \code{EQ_PRIMARY}
#'     and \code{TOTAL_DEATHS} columns.  The data in these columns is used to generate
#'     the HTML encoded label strings.
#'
#' @return a vector of HTML encoded, label \code{string}s.
#'
#' @importFrom data.table as.data.table
#'
#' @example examples/example_mapping_functions.R
#'
#' @export
eq_create_label <- function(data) {

  html_label <- function(location, magnitude, total_deaths) {
    paste0(
      "<b>Location:</b> "    , location    , "<br>",
      "<b>Magnitude:</b> "   , magnitude   , "<br>",
      "<b>Total deaths:</b> ", total_deaths
    )
  }

  # If reader and dplyr are used then this won't be a
  # data.table, hence the need to convert it.
  data <- data.table::as.data.table(data)

  data[,
    html_label(
      get("clean_location"), get("EQ_PRIMARY"), get("TOTAL_DEATHS")
    )
  ]
}
