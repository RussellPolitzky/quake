context("geom_timeline")

test_that('can create a timeline geometry', {

  dt <- data.frame(
    date      = ISOdate(2017, 01, 12),
    country   = "South Africa",
    intensity = 6,
    deaths    = 0
  )

  geom <- geom_timeline(
    data = dt,
    aes(
      x    = date,
      y    = country,
      size = intensity,
      col  = deaths
    ),
    alpha = 0.8
  )

  expect_equal(
    class(geom),
    c("LayerInstance", "Layer", "ggproto")
  )

})
