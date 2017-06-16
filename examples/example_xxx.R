library(data.table)
library(quake)

raw_data <- fread("examples/earthquakes.tsv")
dt       <- quake::eq_clean_data(raw_data)
labels   <- eq_create_label(dt)
labels
