require(data.table)

data_file  <- 'NOAA_Data.txt'
clean_data <- fread(data_file) %>% eq_clean_data
clean_data
