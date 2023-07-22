test_that("no error when all aes are provided", {
  lcd = eq_location_clean(earthquakes, 2000, 2020, "JAPAN")
  expect_no_error(
    ggplot2::ggplot(
      lcd,
      ggplot2::aes(x = DATE, y = COUNTRY, size = Mag,
                   colour = Deaths, group = 1:nrow(lcd))) +
      geom_timeline() + ggplot2::theme_classic() +
      ggplot2::theme(axis.line.y = ggplot2::element_blank(),
                     axis.title.y = ggplot2::element_blank(),
                     axis.ticks.y = ggplot2::element_blank(),
                     legend.position = "bottom") +
      ggplot2::scale_size_continuous(name = "Richter scale value",
                                     breaks = c(2, 4, 6, 8, 10)) +
      ggplot2::scale_color_continuous(name = "# Deaths")
  )
})

test_that("no error when optional aes in not provided", {
  lcd = eq_location_clean(earthquakes, 2000, 2020, "JAPAN")
  expect_no_error(
    ggplot2::ggplot(
      lcd,
      ggplot2::aes(x = DATE)) +
      geom_timeline() + ggplot2::theme_classic() +
      ggplot2::theme(axis.line.y = ggplot2::element_blank(),
                     axis.title.y = ggplot2::element_blank(),
                     axis.ticks.y = ggplot2::element_blank(),
                     legend.position = "bottom")
  )
})
