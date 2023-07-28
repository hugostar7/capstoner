## code to prepare `my_EQ` dataset goes here

my_EQ <- data.frame(
  Year = 2001:2005, Mo = 1:5, Dy = 11:15,
  Longitude = 21:25, Latitude = 31:35,
  `Location Name` = paste(
    c("AAAA", "BBBB", "CCCC", "DDDD", "EEEE"),
    c("AAAA", "BBBB", "CCCC", "DDDD", "EEEE"), sep = ":"),
  Mag = 3, Deaths = 0,
  check.names = FALSE
)

usethis::use_data(my_EQ, overwrite = TRUE)
