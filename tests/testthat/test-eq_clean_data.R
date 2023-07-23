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

  my_df = data.frame(
    Year = 2001:2005, Mo = 1:5, Dy = 11:15,
    Longitude = 21:25, Latitude = 31:35,
    `Location Name` = paste(
      c("AAAA", "BBBB", "CCCC", "DDDD", "EEEE"),
      c("AAAA", "BBBB", "CCCC", "DDDD", "EEEE"), sep = ":"),
    Mag = 3, Deaths = 0,
    check.names = FALSE
  )

  my_clean_df = data.frame(
    `Location Name` = my_df$`Location Name`,
    Mag = my_df$Mag, Deaths = my_df$Deaths,
    DATE = as.Date(
      paste(my_df$Year, my_df$Mo, my_df$Dy, sep = "-")
    ),
    LONGITUDE = my_df$Longitude,
    LATITUDE = my_df$Latitude,
    check.names = FALSE
  )

  expect_equal(eq_clean_data(my_df), my_clean_df)
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
