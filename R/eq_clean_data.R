#' @md
#' @title Clean earthquake data
#'
#' @description \code{eq_clean_data} takes a NOAA data frame and returns a cleaned
#' \code{data.frame}.  The clean \code{data.frame} has
#' a date column, of type \code{Date}, created by uniting the year, month,
#' day columns from the raw data.  The \code{LATITUDE} and \code{LONGITUDE}
#' are converted to \code{numeric}s.
#'
#' @param raw_data is a NOAA \code{data.frame} in the format supplied by
#' NOAA here: \url{https://www.ngdc.noaa.gov/nndc/struts/form?t=101650&s=1&d=1}
#' The \code{data.frame} should contain the following columns
#' * "LATITUDE"
#' * "LONGITUDE"
#' * "SECOND"
#' * "MINUTE"
#' * "HOUR"
#' * "DAY"
#' * "MONTH"
#'
#' @return a \code{tbl data.frame} containing the cleaned data.
#'
#' @importFrom lubridate ymd_hms
#' @importFrom lubridate years
#' @importFrom gtools na.replace
#' @importFrom dplyr mutate
#'
#' @example inst/examples/example_clean_data.R
#'
#' @export
eq_clean_data <- function(raw_data) {
  # Dates parsing requires special attention due to the fact
  # that BC dates are present in the dataset.
  parse_dates <- function(yrs, mths, dys, hrs, mins, secs) {
    leap_year <- 2016 # Any year with all days present, ie. any leap year
    ctd <- ISOdatetime(leap_year, mths, dys, hrs, mins, secs, tz = "UTC") +
             lubridate::years(yrs - leap_year)
    as.Date(ctd)
  }

  dplyr::mutate_(raw_data,
    "SECOND"    = ~gtools::na.replace(as.integer(trimws(SECOND)), 0),
    "LATITUDE"  = ~as.numeric        (LATITUDE ),
    "LONGITUDE" = ~as.numeric        (LONGITUDE),
    "MINUTE"    = ~gtools::na.replace(MINUTE, 0),
    "HOUR"      = ~gtools::na.replace(HOUR  , 0),
    "DAY"       = ~gtools::na.replace(DAY   , 1),
    "MONTH"     = ~gtools::na.replace(MONTH , 1),
    "date"      = ~parse_dates(
      YEAR, MONTH, DAY,
      HOUR, MINUTE, SECOND
    ),
    "clean_location" = ~eq_location_clean(LOCATION_NAME)
  )
}
