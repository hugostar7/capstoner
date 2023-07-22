test_that("check_required_column", {
  expect_equal(min(ncol(earthquakes), 7), 7)
  expect_true(!is.null(earthquakes$Year))
  expect_true(!is.null(earthquakes$Mo))
  expect_true(!is.null(earthquakes$Dy))
  expect_true(!is.null(earthquakes$Longitude))
  expect_true(!is.null(earthquakes$Longitude))
  expect_true(!is.null(earthquakes$Mag))
  expect_true(!is.null(earthquakes$Deaths))
})

test_that("check_row", {
  expect_equal(min(nrow(earthquakes), 1), 1)
})
