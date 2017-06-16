#' @md
#' @title Clean earthquake data
#'
#' @description \code{eq_clean_data} takes a NOAA data frame and returns a cleaned
#' \code{data.table data.frame}.  The clean \code{data.table data.frame} has
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
#' @importFrom lubridate ymd_hms
#' @importFrom lubridate years
#' @importFrom gtools na.replace
#'
#' @example examples/example_clean_data.R
#'
#' @export
eq_clean_data <- function(raw_data) {
  # Dates parsing requires special attention due to the fact
  # that BC dates are present in the dataset.
  parse_dates <- function(yrs, mths, dys, hrs, mins, secs) {
    leap_year    <- 2016 # Any year with all days present, ie. any leap year
    date_strings <- paste(
      paste(leap_year, mths, dys , sep = '-'),
      paste(hrs      , mins, secs, sep = ":")
    )
    lubridate::ymd_hms(date_strings) + lubridate::years(yrs - leap_year)
  }

  raw_data["LATITUDE" ] <- as.numeric(        raw_data[, "LATITUDE" ]) # Not needed with fread
  raw_data["LONGITUDE"] <- as.numeric(        raw_data[, "LONGITUDE"]) # Not needed with fread
  raw_data[ "SECOND"  ] <- gtools::na.replace(raw_data[, "SECOND"   ], 0)
  raw_data[ "MINUTE"  ] <- gtools::na.replace(raw_data[, "MINUTE"   ], 0)
  raw_data[ "HOUR"    ] <- gtools::na.replace(raw_data[, "HOUR"     ], 0)
  raw_data[ "DAY"     ] <- gtools::na.replace(raw_data[, "DAY"      ], 1)
  raw_data[ "MONTH"   ] <- gtools::na.replace(raw_data[, "MONTH"    ], 1)
  raw_data[ "date"    ] <- parse_dates(
    raw_data[, "YEAR" ], raw_data[, "MONTH" ], raw_data[, "DAY"   ],
    raw_data[, "HOUR" ], raw_data[, "MINUTE"], raw_data[, "SECOND"]
  )
  raw_data["clean_location"] <- eq_location_clean(raw_data[, "LOCATION_NAME"])
  raw_data
}
