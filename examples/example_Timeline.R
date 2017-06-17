library(magrittr)
library(quake)
library(ggplot2)

n         <- 100
countries <- c("USA", "China", "India", "South Africa")

# Sample data
dt <- data.frame(
  date      = as.Date('2017-01-01') + seq(1, 365, 365/n),
  country   = factor(sample(countries, replace = TRUE, size = n)),
  intensity = runif(n)*10,
  deaths    = runif(n)*12
)

dt %>%
  ggplot() +
  geom_timeline_label(
    aes(
      label = as.character(country),
      x     = date     ,
      y     = country  ,
      size  = intensity
    ),
    n_max = 3
  ) +
  geom_timeline(ggplot2::aes(x = date, y = country, size = intensity, col = deaths), alpha = 0.8) +
  labs(x = "DATE")                                     +
  scale_size_continuous (name = "Richter scale value") +
  scale_color_continuous(name = "# deaths"           ) +
  theme_classic()                                      +
  theme_timeline_with_y_axis_text
