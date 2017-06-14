#------------------------------------------------------------------------------
# This module is fairly straightforward and involves obtaining/downloading the
# dataset and writing functions to clean up some of the variables. The dataset
# is in tab-delimited format and can be read in using the read_delim() function
# in the readr package.
# 
# After downloading and reading in the dataset, the overall task for this module
# is to write a function named eq_clean_data() that takes raw NOAA data frame and
# returns a clean data frame. The clean data frame should have the following:
# 
# 1.) A date column created by uniting the year, month, day and 
# converting it to the Date class 
#
# 2.) LATITUDE and LONGITUDE columns converted to numeric class 
#
# 3.) In addition, write a function eq_location_clean() that cleans the LOCATION_NAME
#     column by stripping out the country name (including the colon) and converts
#     names to title case (as opposed to all caps). 
#
# This will be needed later for annotating visualizations. This function should 
# be applied to the raw data to produce a cleaned up version of the LOCATION_NAME column.
#------------------------------------------------------------------------------


library(magrittr)

eq_location_clean <- function(locations) {

  # see: https://stackoverflow.com/questions/6364783/capitalize-the-first-letter-of-both-words-in-a-two-word-string
  to_title_case <- function(words) gsub("(^|[[:space:]])([[:alpha:]])", "\\1\\U\\2", words, perl=TRUE)
  
  location <- stringr::str_match(locations, "[^:]*$")[,1] %>% 
    stringr::str_trim (side = "left") %>% 
    to_title_case
  
  country <- stringr::str_match(locations, "^[^:]*")[,1] %>% 
    to_title_case
  
  list("location" = location, "country" = country)
}


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
  
  raw_data <- data.table::as.data.table(raw_data) # required if using readr

  raw_data[, "LATITUDE"  := as.numeric(get("LATITUDE" ))         ] # Not needed with fread
  raw_data[, "LONGITUDE" := as.numeric(get("LONGITUDE"))         ] # Not needed with fread
  raw_data[, "SECOND"    := gtools::na.replace(get("SECOND"), 0) ]
  raw_data[, "MINUTE"    := gtools::na.replace(get("MINUTE"), 0) ]
  raw_data[, "HOUR"      := gtools::na.replace(get("HOUR"  ), 0) ]
  raw_data[, "DAY"       := gtools::na.replace(get("DAY"   ), 1) ]
  raw_data[, "MONTH"     := gtools::na.replace(get("MONTH" ), 1) ]
  raw_data[, "date" := parse_dates(
      get("YEAR"), get("MONTH" ), get("DAY"   ), 
      get("HOUR"), get("MINUTE"), get("SECOND") )] 
  raw_data[, "clean_location" := eq_location_clean(get("LOCATION_NAME"))["location"] ]
  raw_data
}

# data_file  <- 'NOAA_Data.txt'
# clean_data <- data.table::fread(data_file) %>% eq_clean_data
# clean_data



