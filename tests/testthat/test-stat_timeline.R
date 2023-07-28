test_that("no error w/o optional aesthetics", {

  df = data.frame(
    DATE = c(1,2,3,1,2),
    COUNTRY = c("C","A","C","B","B"),
    Mag = 2:6,
    Deaths = c(0,1,0,1,0)
  )

  expect_no_error(
    ggplot2::ggplot(df, ggplot2::aes(x = DATE, y = COUNTRY,
                                      size = Mag, colour = Deaths)) +
      stat_timeline()
  )

  expect_no_error(
    ggplot2::ggplot(df, ggplot2::aes(x = DATE)) +
      stat_timeline()
  )
})
