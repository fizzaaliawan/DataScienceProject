# ============================================================
# Phase 3: Predictive Modeling & Interpretation
# Project: Remote Work and Urban Traffic Reduction
# Group 20
# ============================================================

# --------------------------
# Libraries
# --------------------------
library(dplyr)
library(caret)
library(randomForest)
library(ggplot2)
library(data.table)

# --------------------------
# Folder Setup (Relative Paths)
# --------------------------
phase3_folder <- "PHASE3"
output_folder <- file.path(phase3_folder, "outputs")

dir.create(output_folder, showWarnings = FALSE, recursive = TRUE)

# --------------------------
# Load Merged Dataset
# --------------------------
merged_file <- "PHASE1/outputs/merged_remote_traffic.csv"
data <- fread(merged_file)

# --------------------------
# Data Preparation
# --------------------------
data <- data %>%
  mutate(
    location = as.factor(location),
    industry = as.factor(industry),
    congestionStatus = as.factor(congestionStatus)
  )

model_data <- data %>%
  select(
    productivity_score,
    average_daily_work_hours,
    break_frequency_per_day,
    task_completion_rate,
    focus_time_minutes,
    avg_vehicle_count,
    avg_speed,
    location,
    industry,
    congestionStatus,
    avg_traffic_reduction
  )

# --------------------------
# Train-Test Split
# --------------------------
set.seed(123)
train_index <- createDataPartition(model_data$avg_traffic_reduction,
                                   p = 0.8, list = FALSE)

train_data <- model_data[train_index, ]
test_data  <- model_data[-train_index, ]

# ============================================================
# 1. Linear Regression
# ============================================================

lm_model <- lm(
  avg_traffic_reduction ~ productivity_score +
    average_daily_work_hours +
    break_frequency_per_day +
    task_completion_rate +
    avg_vehicle_count +
    avg_speed,
  data = train_data
)

lm_preds <- predict(lm_model, test_data)

lm_rmse <- RMSE(lm_preds, test_data$avg_traffic_reduction)
lm_r2   <- R2(lm_preds, test_data$avg_traffic_reduction)


# Save Linear Regression Predictions
lm_pred_df <- data.frame(
  actual = test_data$avg_traffic_reduction,
  predicted = lm_preds
)

fwrite(lm_pred_df,
       file.path(output_folder, "linear_regression_predictions.csv"))

# ============================================================
# 2. Random Forest Regression
# ============================================================

set.seed(123)
rf_reg_model <- randomForest(
  avg_traffic_reduction ~ productivity_score +
    average_daily_work_hours +
    break_frequency_per_day +
    task_completion_rate +
    avg_vehicle_count +
    avg_speed,
  data = train_data,
  ntree = 300,
  importance = TRUE
)

rf_preds <- predict(rf_reg_model, test_data)

rf_rmse <- RMSE(rf_preds, test_data$avg_traffic_reduction)
rf_r2   <- R2(rf_preds, test_data$avg_traffic_reduction)

# Save RF Predictions
rf_pred_df <- data.frame(
  actual = test_data$avg_traffic_reduction,
  predicted = rf_preds
)

fwrite(rf_pred_df,
       file.path(output_folder, "rf_regression_predictions.csv"))

# Variable Importance Plot
png(file.path(output_folder, "rf_variable_importance.png"),
    width = 800, height = 600)
varImpPlot(rf_reg_model, main = "Random Forest Variable Importance")
dev.off()

# ============================================================
# 3. Classification: Congestion Status
# ============================================================

set.seed(123)
rf_class_model <- randomForest(
  congestionStatus ~ productivity_score +
    average_daily_work_hours +
    break_frequency_per_day +
    task_completion_rate +
    avg_vehicle_count +
    avg_speed,
  data = train_data,
  ntree = 300
)

class_preds <- predict(rf_class_model, test_data)

conf_matrix <- confusionMatrix(class_preds, test_data$congestionStatus)

# Save Confusion Matrix
conf_df <- as.data.frame(conf_matrix$table)
fwrite(conf_df,
       file.path(output_folder, "congestion_confusion_matrix.csv"))

# ============================================================
# 4. Save Overall Model Performance Summary
# ============================================================

performance_summary <- data.frame(
  Model = c("Linear Regression", "Random Forest Regression"),
  RMSE  = c(lm_rmse, rf_rmse),
  R2    = c(lm_r2, rf_r2)
)

fwrite(performance_summary,
       file.path(output_folder, "model_performance_summary.csv"))

# ============================================================
# End of Phase 3
# ============================================================
