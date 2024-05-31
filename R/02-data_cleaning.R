# Load required libraries ------------------------------------------------------
library(tidyverse)
library(readxl)
library(janitor)
library(dplyr)

# Access data ------------------------------------------------------------------
data_in <- read_csv("data/raw/plastic_waste_raw.csv")

# Clean data -------------------------------------------------------------------
# Delete columns with lots of NA
data <- data_in |> 
  select(-plastic_prod_kg_year, -red_plastic_consumption,
         -plastic_consumption_how, -no_separation, -confident, 
         -plastic_impact_environment)

# Merge two columns that were separated during the process of converting the 
#questionnaire to a data frame
data_new_1 <- data |> 
  mutate(use_plastic_bags = paste(use_plastic_bags...16, use_plastic_bags...21)) |> 
  select(-use_plastic_bags...16, -use_plastic_bags...21)
data_new_1$use_plastic_bags <- gsub(" NA", "", data_new_1$use_plastic_bags)
data_new_1$use_plastic_bags <- gsub("NA ", "", data_new_1$use_plastic_bags)

# Add two columns for a last minute question
data_new_2 <- data_new_1 |> 
  mutate(plastic_kg_year = NA , confident = NA )
data_new_2$plastic_kg_year[14:21] <- c(65, 95, 25, 65, 65, 65, 95, 95)
data_new_2$confident[14:21] <- c(2, 1, 2, 4, 2, 1, 4, 1)
                               
# Create categories for columns containing open open-ended responses
data_new_2$plastic_impact_health <- c("microplastics", NA, "bad", "microplastics",
                                           "microplastics", "bad", "microplastics", "bad",
                                           "ends up in food and is toxic", "microplastics",
                                           NA, NA, "bad", "affects our immune system", "bad",
                                           "air and water pollution due to microplastics",
                                           "end up in food and is toxic", "air and water pollution due to microplastics",
                                           "end up in food and is toxic", "microplastics end up in our organisms",
                                            "microplastics end up in our organisms")
plastic_waste_processed <- data_new_2

# Save processed data ----------------------------------------------------------
write_csv(plastic_waste_processed, here::here("data", "processed",
                                                  "plastic_waste_processed.csv"))

