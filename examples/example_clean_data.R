library(data.table)
library(magrittr)
library(quake)

data_file  <- 'examples/earthquakes.tsv'
clean_data <- fread(data_file) %>% (quake::eq_clean_data)
clean_data
