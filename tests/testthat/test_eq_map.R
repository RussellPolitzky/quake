context('mapping')

suppressPackageStartupMessages({
  library(dplyr)
  library(lubridate)
  library(quake)
  library(readr)
})


test_that('should be able to create a map', {

  data_file_name <- system.file("extdata", "earthquakes.tsv.gz", package = "quake")

  suppressMessages({
    map <- read_delim(data_file_name, delim = "\t")    %>% # read tsv, NOAA data
      eq_clean_data()                                  %>% # clean data
      filter(COUNTRY == "MEXICO" & year(date) >= 2000) %>% # filter to show Mexico
      mutate(popup_text = eq_create_label(.))          %>% # add col with HTML popups
      eq_map(annot_col = "popup_text")
  })

  expect_equal(
    class(map),
    c("leaflet", "htmlwidget")
  )

})

