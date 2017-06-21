context("clean data")

test_that('can clean location names', {
  expect_equal(
    eq_location_clean("TURKEY:  IZMIR,ALASEHIR,DENIZLI,AYDIN"),
    "IZMIR,ALASEHIR,DENIZLI,AYDIN"
  )
})
