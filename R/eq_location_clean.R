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




#' @import magrittr

eq_location_clean <- function(locations) {
  to_title_case <- function(words) gsub("(^|[[:space:]])([[:alpha:]])", "\\1\\U\\2", words, perl=TRUE) # see: https://stackoverflow.com/questions/6364783/capitalize-the-first-letter-of-both-words-in-a-two-word-string
  location <-
    stringr::str_match(locations, "[^:]*$")[,1] %>%
    stringr::str_trim(side = "left") %>%
    to_title_case
  country <-
    stringr::str_match(locations, "^[^:]*")[,1] %>%
    to_title_case
  list("location" = location, "country" = country)
}


