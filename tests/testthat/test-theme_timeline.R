test_that("no error when added to a plot", {
  lcd = eq_location_clean(earthquakes, 2000, 2020, "JAPAN")
  expect_no_error(
    ggplot2::ggplot(
      lcd,
      ggplot2::aes(x = DATE, y = COUNTRY, size = Mag,
                   colour = Deaths, group = 1:nrow(lcd))) +
      geom_timeline() +
      theme_timeline()
    )

  expect_no_error(
    ggplot2::ggplot(
      lcd,
      ggplot2::aes(x = DATE)) +
      geom_timeline() +
      theme_timeline()
  )
})
