#' @title Create an HTML pop-up label showing location, magnitude and total deaths
#'
#' @description \code{eq_create_label} takes a NOAA \code{data.frame} with columns
#' \code{clean_location}, \code{EQ_PRIMARY} and \code{TOTAL_DEATHS} and produces
#' a vector of \code{string}s contituting HTML encoded labels showing the location,
#' magnitude and total, associated deaths caused the each quake.
#'
#' @param data is a \code{data.frame} with \code{clean_location}, \code{EQ_PRIMARY}
#' and \code{TOTAL_DEATHS} columns.  The data in these columns is used to generate
#' HTML encoded label strings.
#'
#' @return a vector of HTML encoded, label \code{string}s.
#'
#' @importFrom dplyr pull
#'
#' @example inst/examples/example_mapping_functions.R
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

  html_label(
    location     = dplyr::pull(data, "clean_location"),
    magnitude    = dplyr::pull(data, "EQ_PRIMARY"    ),
    total_deaths = dplyr::pull(data, "TOTAL_DEATHS"  )
  )
}
