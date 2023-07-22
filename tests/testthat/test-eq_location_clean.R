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