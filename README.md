
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- * Turn on travis for this repo at https://travis-ci.org/profile -->
<!--  * Add a travis shield to your README.md: -->
<!-- [![Travis-CI Build Status](https://travis-ci.org/.svg?branch=master)](https://travis-ci.org/) -->
The Quake Package
=================

The `quake` package visualizes [NOAA earthquake data](https://ngdc.noaa.gov/nndc/struts/form?t=101650&s=1&d=1). `quake` shows when earthquakes happened on a labelled timeline, and where they happened on an interactive map.

Two custom, `ggplot2` geometries, `geom_timeline` and `geom_timeline_label` make for easy earthquake, timeline plotting and labelling, while function `eq_map` shows earthquake locations.

Installation
------------

`quake` is available from GitHub and is installed using the `devtools` package as follows:

    devtools::install_github("RussellPolitzky/quake")

Cleaning Data
-------------

NOAA data is supplied without a consolidate date column and given locations includes countr, as well as province and city. As such, the `eq_clean_data` function adds a `date` column and one for `clean_location`.

In the example, below, tab separated NOAA data is read using the `data.table`'s `fread` function, and then cleaned using `eq_clean_data` is shown below.

The code below reads a sample file using `data.table's` `fread` function and cleans it using `eq_clean_data`. The sample shows the first three rows and columns 1-5, and 48-49 of the cleaned output.

``` r
library(data.table)
library(magrittr)
library(quake)

data_file_name <- system.file("extdata", "earthquakes.tsv", package = "quake")
clean_data     <- fread(data_file_name) %>% eq_clean_data
clean_data[1:3, c(1:5, 48:49)] # show 1st three rows and cols 1-5 and 48-49
#>   I_D FLAG_TSUNAMI  YEAR MONTH DAY        date       clean_location
#> 1   1              -2150     1   1 -2150-01-01 BAB-A-DARAA,AL-KARAK
#> 2   2          Tsu -2000     1   1 -2000-01-01               UGARIT
#> 3   3              -2000     1   1 -2000-01-01                    W
```

Plotting an Earthquake Timeline
-------------------------------

`quake` has two custom, `ggplot2` geometries to plot earthquake data. `geom_timeline` plots timelines while `geom_timeline_label` add labels to a timeline.

The example code below generates sample data and plots a timeline showing the dates, magnitudes and countries of the quakes.

Generate sample data:

``` r
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
```

Plot the sample data with

-   date on the x axis,
-   country on the y axis,
-   quake magnitude shown using marker size,
-   the number of associated deaths indicated by colour

``` r
dt %>%
  ggplot() +
  geom_timeline(
    aes(
      x    = date, 
      y    = country, 
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
```

![](README-plot_data-1.png) Note `theme_timeline_with_y_axis_text` theme add-on, which is one of two themes provided by the `quake` package.

Adding Labels to A Quake Timeline
---------------------------------

Mapping Quakes
--------------
