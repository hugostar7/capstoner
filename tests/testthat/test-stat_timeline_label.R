test_that("annotation stat requires x and label", {

  # Data
  my_data = data.frame(
    Mag = 3, Deaths = 0,
    DATE = as.Date(paste(2001:2005, 1:5, 11:15, sep = "-")),
    LONGITUDE = 21:25,
    LATITUDE = 31:35,
    COUNTRY = c("AAAA", "BBBB", "CCCC", "DDDD", "EEEE"),
    LOCATION_NAME = c("Aaaa", "Bbbb", "Cccc", "Dddd", "Eeee"),
    check.names = FALSE
  )

  # Create a plot
  p <-
    ggplot2::ggplot(my_data,
                    ggplot2::aes(x = DATE, y = COUNTRY, size = Mag, colour = Deaths)) +
    ggplot2::geom_point()

  # Error when x missing
  #expect_error(
  #p +
  #stat_timeline_label(
    #ggplot2::aes(y = COUNTRY, label = LOCATION_NAME, orderBy = Mag),
    #n_max = 5, inherit.aes = FALSE)
  #)

  # Error when label missing
  #expect_error(
  #p +
  #stat_timeline_label(
    #ggplot2::aes(x = DATE, y = COUNTRY, orderBy = Mag),
    #n_max = 5, inherit.aes = FALSE)
  #)

  # No error when x and label are supplied, nothing else added
  expect_no_error(
    p +
      stat_timeline_label(
        ggplot2::aes(x = DATE, label = LOCATION_NAME), inherit.aes = FALSE))

  # No error when x and label are supplied
  expect_no_error(
    p +
      stat_timeline_label(
        ggplot2::aes(x = DATE, y = COUNTRY, label = LOCATION_NAME,
        orderBy = Mag), n_max = 5, inherit.aes = FALSE))

  # No error when x and label are supplied, y missing
  expect_no_error(
    p +
      stat_timeline_label(
        ggplot2::aes(x = DATE, label = LOCATION_NAME,
        orderBy = Mag), n_max = 5, inherit.aes = FALSE))

  # No error when x and label are supplied, orderBy missing
  expect_no_error(
    p +
      stat_timeline_label(
        ggplot2::aes(x = DATE, y = COUNTRY, label = LOCATION_NAME),
        n_max = 5, inherit.aes = FALSE))

  # No error when x and label are supplied, n_max missing
  expect_no_error(
    p +
      stat_timeline_label(
        ggplot2::aes(x = DATE, y = COUNTRY, label = LOCATION_NAME,
        orderBy = Mag), inherit.aes = FALSE)
  )

})
