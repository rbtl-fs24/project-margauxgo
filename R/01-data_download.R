# Download data from Google Sheet
install.packages("googlesheets4")
library(googlesheets4)
plastic_waste_raw <- read_sheet("https://docs.google.com/spreadsheets/d/1unErovxz2TgzWGw7_nPwqFrMucrkYiELpdD_1jh2cJw/edit?resourcekey#gid=1523802305")

# Export data
library(readr)
library(here)
write_csv(plastic_waste_raw, here::here("data", "raw", "plastic_waste_raw.csv"))
         