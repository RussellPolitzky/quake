% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/eq_location_clean.R
\name{eq_location_clean}
\alias{eq_location_clean}
\title{Clean earthquake locations}
\usage{
eq_location_clean(locations)
}
\arguments{
\item{locations}{is a \code{character} vector of locations.  Each vector element
should have the "GREECE:  THERA ISLAND (SANTORINI)" format.}
}
\value{
a \code{character} vector of cleaned names with country removed and in title case.
}
\description{
\code{eq_location_clean} cleans the strings in the \code{LOCATION_NAME} column
of the supplied NOAA \code{data.frame}. \code{eq_location_clean} stripps out the country
name, including the colon, and converts names to title case, as opposed to all caps.
}
\examples{
library(data.table)
library(magrittr)
library(quake)

data_file_name <- system.file("extdata", "earthquakes.tsv", package = "quake")
clean_data     <- fread(data_file_name) \%>\% eq_clean_data
clean_data
}
