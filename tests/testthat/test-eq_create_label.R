test_that("HTML label works when at leat one of the columns
          used for computation is in the data", {
            expect_equal(
              eq_create_label(
                data.frame(
                  LOCATION_NAME = "New York (Bronx)",
                  `Total Deaths` = NA,
                  Mag = 3, check.names = FALSE
                )
              ),
              lapply(" <b> Location :</b> New York (Bronx) <br/> <b> Magnitude :</b> 3 <br/>",
                     htmltools::HTML)
            )

            expect_equal(
              eq_create_label(
                data.frame(
                  `Total Deaths` = NA, check.names = FALSE
                )
              ),
              lapply("", htmltools::HTML)
            )

            expect_equal(
              eq_create_label(
                data.frame(
                  Mag = 3, check.names = FALSE
                )
              ),
              lapply(" <b> Magnitude :</b> 3 <br/>", htmltools::HTML)
            )


            expect_error(
              eq_create_label(NULL)
            )
          })
