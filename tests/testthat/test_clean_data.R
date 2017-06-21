context("clean data")

library(data.table)

test_that('can clean NOAA data', {
  data_file_name <- system.file("extdata", "earthquakes.tsv", package = "quake")
  clean_data     <- fread(data_file_name) %>% eq_clean_data
  expect_equal(
    nrow(clean_data),
    5945
  )
})
