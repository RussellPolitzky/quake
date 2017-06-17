#-------------------------------------------------------
# Produce a map showing earthquake location with marker
# size indicating intensity. The maps also include
# pop-ups showing location name, magnitude and number
# of deaths for each quake
#-------------------------------------------------------

# Example with dplyr
library(quake)
library(readr)
library(dplyr)
library(lubridate)

read_delim("examples/earthquakes.tsv.gz", delim = "\t") %>%
  eq_clean_data()  %>% View

read_delim("examples/earthquakes.tsv.gz", delim = "\t") %>%
  eq_clean_data()                                       %>%
  filter(COUNTRY == "MEXICO" & year(date) >= 2000)      %>%
  mutate(popup_text = eq_create_label(.))               %>%
  eq_map(annot_col = "popup_text")


# Data.table without piping.
library(quake)
library(readr)
library(data.table)
library(lubridate)

dt <- (fread("examples/earthquakes.tsv") %>% eq_clean_data)[
  COUNTRY    == "MEXICO" &
    year(date) >= 2000
  ]
dt[, "popup_text" := eq_create_label(dt)]
eq_map(dt, "popup_text")


# Or data.table with piping using data.table
library(quake)
library(readr)
library(data.table)
library(lubridate)

(eq_clean_data((fread("examples/earthquakes.tsv")))[
  COUNTRY    == "MEXICO" & # filter
    year(date) >= 2000
  ][,
    "popup_text" := eq_create_label(.SD) # add new column
    ]) %>%
  eq_map("popup_text")


# Or with nesting using data.table
library(quake)
library(readr)
library(data.table)
library(lubridate)

eq_map(
  data = eq_clean_data(
    raw_data = fread("examples/earthquakes.tsv")
  )[
      COUNTRY    == "MEXICO" & # filter
        year(date) >= 2000,
      ][,
      "popup_text" := eq_create_label(.SD) # add a new column
  ],
  annot_col = "popup_text"
)



