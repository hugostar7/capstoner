test_that("data is prepared correctly before call to leaflet", {
  data = data.frame(LONGITUDE = 26,
                    LATITUDE = 36,
                    Mag = 4,
                    LOCATION = "New York")
  annot_col = "LOCATION"
  annot_col = as.character(annot_col)
  df = dplyr::rename(data, "annot_col" = paste(annot_col))

  expect_equal(
    df,
    data.frame(LONGITUDE = 26,
               LATITUDE = 36,
               Mag = 4,
               annot_col = "New York")
  )
})

