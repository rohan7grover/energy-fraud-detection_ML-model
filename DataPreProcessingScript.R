# Load required libraries
library(dplyr)
library(tidyr)

# List all CSV files in the current directory
csv_files <- list.files(pattern = "\\.csv$")

# Read each CSV file and store them as a list of data frames
data_list <- lapply(csv_files, read.csv)

# Combine the data frames in the list into a single data frame, adding an ID column "House"
combined_data <- bind_rows(data_list, .id = "Consumer_Number")

# Select specific columns and pivot the data directly
pivoted_data <- combined_data %>%
  select(Consumer_Number, Date.Time, Electricity.Facility..kWh..Hourly.) %>%
  pivot_wider(names_from = Date.Time, values_from = Electricity.Facility..kWh..Hourly.)

# Write the pivoted_data to a new CSV file
write.csv(pivoted_data, "final_data.csv", row.names = FALSE)