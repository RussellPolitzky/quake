rm(list=ls())

source('GeomTimeLine.R'     )
source('ThemeTimeline.R'    )
source('GeomTimelineLabel.R')

library(magrittr)

n         <- 100
countries <- c("USA", "China", "India", "South Africa")

# Sample data
dt <- data.table::data.table(
  date      = as.Date('2017-01-01') + seq(1, 365, 365/n),
  country   = factor(sample(countries, replace = T, size = n)),
  intensity = runif(n)*10, 
  deaths    = runif(n)*12
)

dt %>% 
  ggplot2::ggplot() +
  geom_timeline_label( 
    ggplot2::aes(
      label = as.character(country),
      x     = date     ,
      y     = country  ,
      size  = intensity
    ),
    n_max = 3
  ) +
  geom_timeline(ggplot2::aes(x = date, y = country, size = intensity, col = deaths), alpha = 0.8) + 
  ggplot2::labs(x = "DATE")                                     +
  ggplot2::scale_size_continuous (name = "Richter scale value") + 
  ggplot2::scale_color_continuous(name = "# deaths"           ) +
  ggplot2::theme_classic()                                      + 
  theme_timeline_with_y_axis_text                                            


