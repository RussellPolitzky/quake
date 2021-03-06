% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/eq_clean_data.R
\name{eq_clean_data}
\alias{eq_clean_data}
\title{Clean earthquake data}
\usage{
eq_clean_data(raw_data)
}
\arguments{
\item{raw_data}{is a NOAA \code{data.frame} in the format supplied by
NOAA (see \url{https://www.ngdc.noaa.gov/nndc/struts/form?t=101650&s=1&d=1})
The \code{data.frame} should contain the following columns
\itemize{
\item "LATITUDE"
\item "LONGITUDE"
\item "SECOND"
\item "MINUTE"
\item "HOUR"
\item "DAY"
\item "MONTH"
}}
}
\value{
a \code{data.frame} containing the cleaned data.
}
\description{
\code{eq_clean_data} takes a NOAA data frame and returns a cleaned
\code{data.frame}.  The clean \code{data.frame} contains
a date column, of type \code{Date}, created by uniting the year, month and
day columns from the given, raw data.  The \code{LATITUDE} and \code{LONGITUDE}
are converted to \code{numeric} types.
}
\examples{
library(data.table)
library(magrittr)
library(quake)

data_file_name <- system.file("extdata", "earthquakes.tsv", package = "quake")
clean_data     <- fread(data_file_name) \%>\% eq_clean_data
clean_data
}
