test_that("annotation stat requires x", {

  lcd = eq_location_clean(earthquakes, 2000, 2020, "ALASKA")
  plot <-
    ggplot2::ggplot(
      lcd,
      ggplot2::aes(x = DATE, y = COUNTRY, size = Mag,
                   colour = Deaths, group = grp_aes)) +
    geom_timeline() + ggplot2::theme_classic() +
    ggplot2::theme(axis.line.y = ggplot2::element_blank(),
                   axis.title.y = ggplot2::element_blank(),
                   axis.ticks.y = ggplot2::element_blank(),
                   legend.position = "bottom") +
    ggplot2::scale_size_continuous(name = "Richter scale value",
                                   breaks = c(2, 4, 6, 8, 10)) +
    ggplot2::scale_color_continuous(name = "# Deaths")


  expect_error(
    plot +
      stat_timeline_label(
        lcd, ggplot2::aes(y = COUNTRY,
                          label = LOCATION_NAME, by = Mag),
        colour = "black", size = 3, alpha = NA, n_max = 5
      )
  )
})

test_that("annotation stat requires label", {

  lcd = eq_location_clean(earthquakes, 2000, 2020, "ALASKA")
  plot <-
    ggplot2::ggplot(
      lcd,
      ggplot2::aes(x = DATE, y = COUNTRY, size = Mag,
                   colour = Deaths, group = grp_aes)) +
    geom_timeline() + ggplot2::theme_classic() +
    ggplot2::theme(axis.line.y = ggplot2::element_blank(),
                   axis.title.y = ggplot2::element_blank(),
                   axis.ticks.y = ggplot2::element_blank(),
                   legend.position = "bottom") +
    ggplot2::scale_size_continuous(name = "Richter scale value",
                                   breaks = c(2, 4, 6, 8, 10)) +
    ggplot2::scale_color_continuous(name = "# Deaths")


  expect_error(
    plot +
      stat_timeline_label(
        lcd, ggplot2::aes(x = DATE, y = COUNTRY, by = Mag),
        colour = "black", size = 3, alpha = NA, n_max = 5
      )
  )
})
