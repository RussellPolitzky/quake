library(quake     )
library(magrittr  )
library(data.table)
library(ggplot2   )

# Create dummy data
n         <- 100
countries <- c("USA", "China", "India", "South Africa")

dt <- data.table(
  date      = as.Date('2017-01-01') + seq(1, 365, 365/n),
  country   = factor(sample(countries, replace = T, size = n)),
  intensity = runif(n)*10, # mag is somewhere beteen 0 and 10
  deaths    = runif(n)*12
)

head(dt)

dt %>%
  ggplot() +
  geom_timeline_label(
    aes(
      label = as.character(country),
      x     = date     ,
      y     = country  ,
      size  = intensity
    ),
    n_max = 3 # show only the three largest magnitude quakes
  ) +
  geom_timeline(
    aes(
      x    = date     ,
      y    = country  ,
      size = intensity,
      col  = deaths
    ),
    alpha = 0.8
  ) +
  labs(x = "DATE")                                     +
  scale_size_continuous (name = "Richter scale value") +
  scale_color_continuous(name = "# deaths"           ) +
  theme_classic()                                      +
  theme_timeline_with_y_axis_text
