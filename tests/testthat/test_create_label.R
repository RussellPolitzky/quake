context('mapping')
#
# suppressPackageStartupMessages({
#   library(dplyr)
#   library(lubridate)
#   library(quake)
#   library(readr)
# })

test_that('labels are correctly created', {

  dt <- data.frame(
    "clean_location" = "A location",
    "EQ_PRIMARY"     = 7.0,
    "TOTAL_DEATHS"   = 1
  )

  expect_equal(
    eq_create_label(dt),
    "<b>Location:</b> A location<br><b>Magnitude:</b> 7<br><b>Total deaths:</b> 1"
  )

})
