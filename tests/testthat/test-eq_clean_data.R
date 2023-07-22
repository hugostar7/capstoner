test_that("eq_clean_data_works_when_reqired_columns_are_supplied", {
  expect_equal(
    eq_clean_data(
      data.frame(
        Year = 2000, Mo = 1, Dy = 1,
        Longitude = 0, Latitude = 0
      )
    ),
    data.frame(
      DATE = as.Date("2000-01-01"),
      LONGITUDE = 0,
      LATITUDE = 0
    )
  )
})


test_that("error_when_required_column_missing", {
  expect_error(
    eq_clean_data(
      data.frame(
        Mo = 1, Dy = 1,
        Longitude = 0, Latitude = 0
      )
    )
  )

  expect_error(
    eq_clean_data(
      data.frame(
        Year = 2000, Dy = 1,
        Longitude = 0, Latitude = 0
      )
    )
  )

  expect_error(
    eq_clean_data(
      data.frame(
        Year = 2000, Mo = 1,
        Longitude = 0, Latitude = 0
      )
    )
  )

  expect_error(
    eq_clean_data(
      data.frame(
        Year = 2000, Mo = 1, Dy = 1,
        Latitude = 0
      )
    )
  )

  expect_error(
    eq_clean_data(
      data.frame(
        Year = 2000, Mo = 1, Dy = 1,
        Longitude = 0
      )
    )
  )
})
