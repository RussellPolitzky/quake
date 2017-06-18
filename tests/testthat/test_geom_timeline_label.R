context("geom_timeline_label")

test_that('can create a timeline label geometry', {

  dt <- data.frame(
    date      = ISOdate(2017, 01, 12),
    country   = "South Africa",
    intensity = 6,
    deaths    = 0,
    location  = "A label"
  )

  geom <- geom_timeline_label(
    aes(
      label = location ,
      x     = date     ,
      y     = country  ,
      size  = intensity
    ),
    n_max = 5
  )

  expect_equal(
    class(geom),
    c("LayerInstance", "Layer", "ggproto")
  )

})
