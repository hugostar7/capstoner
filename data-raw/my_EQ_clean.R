## code to prepare `my_EQ_clean` dataset goes here

my_EQ_clean = data.frame(
  Mag = 3, Deaths = 0,
  DATE = as.Date(paste(2001:2005, 1:5, 11:15, sep = "-")),
  LONGITUDE = 21:25,
  LATITUDE = 31:35,
  COUNTRY = c("AAAA", "BBBB", "CCCC", "DDDD", "EEEE"),
  LOCATION_NAME = c("Aaaa", "Bbbb", "Cccc", "Dddd", "Eeee"),
  check.names = FALSE
)

usethis::use_data(my_EQ_clean, overwrite = TRUE)
