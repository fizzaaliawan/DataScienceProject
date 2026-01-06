# =========================
# Phase 1: Data Importing, Cleaning & Transformation
# =========================

# Dataset Sources:
# 1. Urban Traffic Congestion: https://www.kaggle.com/datasets/chanchal27/urban-traffic-congestion-data
# 2. Remote Worker Productivity: https://www.kaggle.com/datasets/ziya07/remote-worker-productivity-dataset

library(dplyr)
library(data.table)
library(stringr)
library(tidyr)

# =========================
# Folder Setup
# =========================

project_folder <- "C:/Users/Hp/OneDrive/Desktop/GRP20/PHASE1"
data_folder <- file.path(project_folder, "data")
output_folder <- file.path(project_folder, "outputs")

dir.create(data_folder, showWarnings = FALSE, recursive = TRUE)
dir.create(output_folder, showWarnings = FALSE, recursive = TRUE)

# =========================
# File Paths
# =========================
traffic_file <- file.path(data_folder, "urban-traffic-congestion.csv")
remote_file <- file.path(data_folder, "remote_worker_productivity.csv")

# =========================
# Load Datasets
# =========================
traffic_data <- fread(traffic_file)
remote_data <- fread(remote_file)

# Remove duplicate rows
traffic_data <- distinct(traffic_data)
remote_data <- distinct(remote_data)

# =========================
# Traffic Data Cleaning
# =========================

numeric_cols_traffic <- c(
  "Vehicle Count",
  "Avg Speed (km/h)",
  "Vehicle Density (%)",
  "Saturation Flow Rate(veh/hr/lane)",
  "Volume to\n Saturation Lane Traffic ratio(%)",
  "FreeFlowSpeed (km/h)",
  "TSR",
  "VLSR",
  "Speed Factor",
  "CI"
)

# Clean numeric columns → remove non-numeric and convert
traffic_data <- traffic_data %>%
  mutate(across(all_of(numeric_cols_traffic),
                ~ as.numeric(gsub("[^0-9.]", "", .))))

# Replace missing numeric values with mean
traffic_data <- traffic_data %>%
  mutate(across(all_of(numeric_cols_traffic),
                ~ ifelse(is.na(.), mean(., na.rm = TRUE), .)))

# Traffic reduction % + Congestion status
traffic_data <- traffic_data %>%
  mutate(
    traffic_reduction_pct = round((1 - `Avg Speed (km/h)` / `FreeFlowSpeed (km/h)`) * 100, 2),
    congestionStatus = case_when(
      traffic_reduction_pct <= 30 ~ "Low",
      traffic_reduction_pct <= 60 ~ "Medium",
      TRUE ~ "High"
    )
  )

# =========================
# Remote Worker Productivity Data Cleaning
# =========================

remote_data_clean <- remote_data %>%
  rename(
    remote_worker_id = worker_id,
    location = location_type,
    industry = industry_sector
  ) %>%
  mutate(across(
    c(age, experience_years, average_daily_work_hours, break_frequency_per_day,
      task_completion_rate, late_task_ratio, calendar_scheduled_usage, focus_time_minutes,
      tool_usage_frequency, automated_task_count, AI_assisted_planning,
      real_time_feedback_score, productivity_score),
    as.numeric
  ))

# =========================
# Traffic Aggregation
# =========================

traffic_agg <- traffic_data %>%
  group_by(congestionStatus) %>%
  summarise(
    avg_vehicle_count = mean(`Vehicle Count`, na.rm = TRUE),
    avg_speed = mean(`Avg Speed (km/h)`, na.rm = TRUE),
    avg_traffic_reduction = mean(traffic_reduction_pct, na.rm = TRUE)
  )

# =========================
# Merge Datasets
# =========================
# Since remote_data$location != congestionStatus,
# we randomly assign congestion levels based on availability.

set.seed(123)
remote_data_clean$congestionStatus <- sample(traffic_agg$congestionStatus,
                                             nrow(remote_data_clean),
                                             replace = TRUE)

merged_data <- remote_data_clean %>%
  left_join(traffic_agg, by = "congestionStatus")

# =========================
# Save Cleaned Datasets
# =========================

fwrite(traffic_data, file.path(output_folder, "cleaned_traffic_data.csv"))
fwrite(remote_data_clean, file.path(output_folder, "cleaned_remote_worker_productivity.csv"))
fwrite(merged_data, file.path(output_folder, "merged_remote_traffic.csv"))

# =========================
# End of Phase 1
# =========================
