test_that("no error when added to a plot", {

  df = data.frame(
    DATE = c(1,2,3,1,2),
    COUNTRY = c("C","A","C","B","B"),
    Mag = 2:6,
    Deaths = c(0,1,0,1,0)
  )

  expect_no_error(
    ggplot2::ggplot(df, ggplot2::aes(x = DATE)) +
      ggplot2::geom_point() +
      theme_timeline()
  )

  expect_no_error(
    ggplot2::ggplot(df, ggplot2::aes(x = DATE, y = COUNTRY,
                                     size = Mag, colour = Deaths)) +
      ggplot2::geom_point() +
      theme_timeline()
    )
})
