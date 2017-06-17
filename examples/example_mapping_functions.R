# Example with dplyr
library(quake)
library(readr)
library(dplyr)
library(lubridate)

read_delim("examples/earthquakes.tsv.gz", delim = "\t") %>%
  eq_clean_data()                                       %>%
  filter(COUNTRY == "MEXICO" & year(date) >= 2000)      %>%
  mutate(popup_text = eq_create_label(.))               %>%
  eq_map(annot_col = "popup_text")
