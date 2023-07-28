## code to prepare `babygrowth` dataset goes here

babygrowth <- data.frame(
  DATE = as.Date(c("2010-10-23", "2010-12-24", "2010-5-13",
                   "2010-5-27","2010-01-13","2010-7-18",
                   "2010-03-16","2010-01-13","2010-7-18",
                   "2010-03-16","2010-10-23", "2010-12-24")),
  AGE = c(1,2,2,1,3,3,2,3,1,4,4,3),
  height = c(1,2,3,1,3,3,4,3,4,5,7,5),
  weight = c(2,1,3,2,2,3,4,2,3,6,6,5)
)

usethis::use_data(babygrowth, overwrite = TRUE)
