test_that("eq_location_clean_works_when_reqired_columns_are_supplied", {
  expect_equal(
    eq_location_clean(
      data.frame(
        `Location Name` = "TURKEY:  ANTAKYA (ANTIOCH)",
        Year = 37, Mo = 4, Dy = 9,
        Longitude = 36.1, Latitude = 36.1,
        check.names = FALSE
      )
    ),
    data.frame(
      DATE = as.Date("37-04-09"),
      LONGITUDE = 36.1, LATITUDE = 36.1,
      COUNTRY = "TURKEY", LOCATION_NAME = "Antakya (Antioch)"
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

  my_loc_clean_df = data.frame(
    Mag = my_df$Mag, Deaths = my_df$Deaths,
    DATE = as.Date(
      paste(my_df$Year, my_df$Mo, my_df$Dy, sep = "-")),
    LONGITUDE = my_df$Longitude,
    LATITUDE = my_df$Latitude,
    COUNTRY = c("AAAA", "BBBB", "CCCC", "DDDD", "EEEE"),
    LOCATION_NAME = c("Aaaa", "Bbbb", "Cccc", "Dddd", "Eeee"),
    check.names = FALSE
  )

  expect_equal(eq_location_clean(my_df), my_loc_clean_df)
})

test_that("error_when_required_column_missing", {
  expect_error(
    eq_location_clean(
      data.frame(
        Year = 37, Mo = 4, Dy = 9,
        Longitude = 36.1, Latitude = 36.1
      )
    )
  )


  expect_error(
    eq_clean_data(
      data.frame(
        `Location Name` = "TURKEY:  ANTAKYA (ANTIOCH)",
        Mo = 4, Dy = 9,
        Longitude = 36.1, Latitude = 36.1
      )
    )
  )

  expect_error(
    eq_clean_data(
      data.frame(
        `Location Name` = "TURKEY:  ANTAKYA (ANTIOCH)",
        Year = 37, Dy = 9,
        Longitude = 36.1, Latitude = 36.1
      )
    )
  )

  expect_error(
    eq_clean_data(
      data.frame(
        `Location Name` = "TURKEY:  ANTAKYA (ANTIOCH)",
        Year = 37, Mo = 4,
        Longitude = 36.1, Latitude = 36.1
      )
    )
  )

  expect_error(
    eq_clean_data(
      data.frame(
        `Location Name` = "TURKEY:  ANTAKYA (ANTIOCH)",
        Year = 37, Mo = 4, Dy = 9,
        Latitude = 36.1
      )
    )
  )

  expect_error(
    eq_clean_data(
      data.frame(
        `Location Name` = "TURKEY:  ANTAKYA (ANTIOCH)",
        Year = 37, Mo = 4, Dy = 9,
        Longitude = 36.1
      )
    )
  )
})
