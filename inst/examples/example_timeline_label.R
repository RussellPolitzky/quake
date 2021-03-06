library(quake     )
library(magrittr  )
library(data.table)
library(ggplot2   )

# Create dummy data

n         <- 100 # start with 100 data samples
countries <- c("USA", "China", "India", "South Africa")

dt <- data.table(
  date      = as.Date('2017-01-01') + seq(1, 365, 365/n),
  country   = factor(sample(countries, replace = TRUE, size = n)),
  intensity = runif(n)*10, # mag is somewhere beteen 0 and 10
  deaths    = runif(n)*12
)

head(dt) # show dummy data

start_date       <- as.Date('2017-07-01') # only show quakes from July 2017
end_date         <- as.Date('2017-07-30') # only show quakes from July 2017
no_labels_toshow <- 3 # show only three labels from highest intensity quakes

dt %>%
  ggplot() +
  geom_timeline_label(
    aes(
      label = as.character(country),
      x     = date     ,
      y     = country  ,
      size  = intensity
    ),
    n_max = no_labels_toshow,
    xmin  = start_date,
    xmax  = end_date
  ) +
  geom_timeline(
    aes(
      x    = date     ,
      y    = country  ,
      size = intensity,
      col  = deaths
    ),
    xmin  = start_date,
    xmax  = end_date,
    alpha = 0.8
  ) +
  labs(x = "DATE")                                     +
  scale_size_continuous (name = "Richter scale value") +
  scale_color_continuous(name = "# deaths"           ) +
  theme_classic()                                      +
  theme_timeline_with_y_axis_text
