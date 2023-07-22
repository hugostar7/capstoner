## code to prepare `earthquakes` dataset goes here

# Read data into R
earthquakes <- readr::read_delim(
  "~/.My_R_files/.NOAA/data_EQ/earthquakes.tsv",
  show_col_types = FALSE
)

usethis::use_data(earthquakes, overwrite = TRUE)
