source('LoadData.R')

# Build a function called eq_map() that takes an argument data containing the
# filtered data frame with earthquakes to visualize. The function maps the
# epicenters (LATITUDE/LONGITUDE) and annotates each point with in pop up window
# containing annotation data stored in a column of the data frame. The user
# should be able to choose which column is used for the annotation in the pop-up
# with a function argument named annot_col. Each earthquake should be shown with
# a circle, and the radius of the circle should be proportional to the
# earthquake's magnitude (EQ_PRIMARY). Your code, assuming you have the
# earthquake data saved in your working directory as "earthquakes.tsv.gz",
# should be able to be used in the following way:

#' @param data is a filtered \code{data.frame} containing earthquake data 
#' filtered to show quakes in the area to visualize.
#' 
eq_map <- function(data, annot_col) {
  leaflet::leaflet() %>%
    leaflet::addTiles() %>%
    leaflet::addCircleMarkers(
      data   = data, 
      lng    = ~ LONGITUDE, 
      lat    = ~ LATITUDE,
      weight = 1,
      radius = ~ EQ_PRIMARY,
      popup  = as.formula(paste( "~", annot_col)) # note as.formula allows dynamic formula creation.
    )
}


eq_create_label <- function(data) {

  html_label <- function(location, magnitude, total_deaths) {
    paste0(
      "<b>Location:</b> "    , location    , "<br>",
      "<b>Magnitude:</b> "   , magnitude   , "<br>",
      "<b>Total deaths:</b> ", total_deaths
    )
  }
  
  # If reader and dplyr are used then this won't be a 
  # data.table, hence the need to convert it.
  data <- data.table::as.data.table(data)

  data[, 
    html_label(
      get("clean_location"), get("EQ_PRIMARY"), get("TOTAL_DEATHS")
    )
  ]
}



# Example with dplyr
readr::read_delim("earthquakes.tsv.gz", delim = "\t")                %>% 
  eq_clean_data()                                                    %>% 
  dplyr::filter(COUNTRY == "MEXICO" & lubridate::year(date) >= 2000) %>% 
  dplyr::mutate(popup_text = eq_create_label(.))                     %>% 
  eq_map(annot_col = "popup_text")


# Data.table without piping.
dt <- (data.table::fread("earthquakes.tsv") %>% eq_clean_data)[
        COUNTRY == "MEXICO" &
        lubridate::year(date) >= 2000
      ]
dt[, "popup_text" := eq_create_label(dt)]
eq_map(dt, "popup_text")


# Or data.table with piping using data.table
(eq_clean_data((data.table::fread("earthquakes.tsv")))[
  COUNTRY               == "MEXICO" &
  lubridate::year(date) >= 2000
][, 
  "popup_text" := eq_create_label(.SD)
]) %>% eq_map("popup_text")
  

# Or with nesting using data.table
eq_map(
  data = eq_clean_data(
           raw_data = data.table::fread("earthquakes.tsv")
         )[
            COUNTRY               == "MEXICO" & # filter
            lubridate::year(date) >= 2000,
         ][, 
            "popup_text" := eq_create_label(.SD) # add a new column
         ],
  annot_col = "popup_text"
)