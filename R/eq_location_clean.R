#' @title Clean earthuqake locations
#'
#' @description \code{eq_location_clean} cleans the strings in the \code{LOCATION_NAME} column
#'    of the supplied NOAA \code{data.frame}. \code{eq_location_clean} strippsout the country
#'    name (including the colon) and converts names to title case (as opposed to all caps).
#'
#' @param locations is a \code{character} vector of locations.  Each vector element
#'     is in the "GREECE:  THERA ISLAND (SANTORINI)" form.
#'
#' @return a \code{character} of cleaned names with country removed and in title case.
#'
#' @importFrom magrittr "%>%"
#' @importFrom stringr str_match
#' @importFrom stringr str_trim
#'
#' @example examples/example_clean_data.R
#'
#' @export
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
