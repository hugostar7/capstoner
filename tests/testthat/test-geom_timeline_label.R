test_that("annotation works when all aes are supplied", {

  lcd = eq_location_clean(earthquakes, 2000, 2020, "ALASKA")
  plot <-
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


  expect_no_error(
    plot +
      geom_timeline_label(
        lcd, ggplot2::aes(x = DATE, y = COUNTRY,
                          label = LOCATION_NAME, by = Mag),
        colour = "black", size = 3, alpha = NA, n_max = 5
      )
  )
})

test_that("annotation works parameter n_max being supplied", {

  lcd = eq_location_clean(earthquakes, 2000, 2020, "ALASKA")
  plot <-
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


  expect_no_error(
    plot +
      geom_timeline_label(
        lcd, ggplot2::aes(x = DATE, y = COUNTRY,
                          label = LOCATION_NAME, by = Mag),
        colour = "black", size = 3, alpha = NA
      )
  )
})
