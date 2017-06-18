library(data.table)
library(magrittr)
library(quake)

data_file_name <- system.file("extdata", "earthquakes.tsv", package = "quake")
clean_data     <- fread(data_file_name) %>% eq_clean_data
clean_data
