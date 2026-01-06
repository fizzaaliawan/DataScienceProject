# =========================
# Phase 2: EDA & Visualization on Merged Dataset
# =========================

library(dplyr)
library(ggplot2)
library(GGally)
library(corrplot)
library(data.table)

# -------------------------
# Folder Setup for Phase 2
# -------------------------
phase2_folder <- "C:/Users/Hp/OneDrive/Desktop/GRP20/PHASE2"
output_folder <- file.path(phase2_folder, "outputs")
dir.create(output_folder, showWarnings = FALSE, recursive = TRUE)

# -------------------------

# Load merged dataset from Phase 1
merged_file <- "PHASE1/outputs/merged_remote_traffic.csv"

if (!file.exists(merged_file)) {
  stop("Merged dataset not found. Please run Phase 1 first.")
}

merged_data <- fread(merged_file)


# -------------------------
# Prepare Columns
# -------------------------
merged_data <- merged_data %>%
  mutate(location = as.factor(location),
         industry = as.factor(industry))

# Numeric subset for correlations & scatterplots
numeric_subset <- c("average_daily_work_hours", "break_frequency_per_day", 
                    "task_completion_rate", "productivity_score", 
                    "avg_vehicle_count", "avg_speed", "avg_traffic_reduction")

# Remove rows with all NA in numeric subset
merged_numeric <- merged_data %>%
  select(all_of(numeric_subset)) %>%
  filter(rowSums(is.na(.)) != ncol(.))

# -------------------------
# 1. Univariate Analysis
# -------------------------

# Productivity Score Distribution
p1 <- ggplot(merged_data, aes(x = productivity_score)) +
  geom_histogram(fill = "green", bins = 30, alpha = 0.7) +
  labs(title = "Distribution of Productivity Score", x = "Productivity Score", y = "Frequency") +
  theme_minimal()
print(p1)
ggsave(file.path(output_folder, "productivity_score_hist.png"), p1, width=8, height=5)

# Average Vehicle Count Distribution
p2 <- ggplot(merged_data, aes(x = avg_vehicle_count)) +
  geom_histogram(fill = "orange", bins = 30, alpha = 0.7) +
  labs(title = "Distribution of Average Vehicle Count", x = "Avg Vehicle Count", y = "Frequency") +
  theme_minimal()
print(p2)
ggsave(file.path(output_folder, "avg_vehicle_count_hist.png"), p2, width=8, height=5)

# Traffic Reduction Distribution
p3 <- ggplot(merged_data, aes(x = avg_traffic_reduction)) +
  geom_histogram(fill = "blue", bins = 30, alpha = 0.7) +
  labs(title = "Distribution of Average Traffic Reduction (%)", x = "Traffic Reduction (%)", y = "Frequency") +
  theme_minimal()
print(p3)
ggsave(file.path(output_folder, "traffic_reduction_hist.png"), p3, width=8, height=5)

# -------------------------
# 2. Bivariate Analysis
# -------------------------

# Productivity vs Work Hours
p4 <- ggplot(merged_data, aes(x = average_daily_work_hours, y = productivity_score)) +
  geom_point(alpha = 0.6, color = "purple") +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Productivity vs Average Daily Work Hours", x = "Average Daily Work Hours", y = "Productivity Score") +
  theme_minimal()
print(p4)
ggsave(file.path(output_folder, "prod_vs_work_hours.png"), p4, width=8, height=5)

# Productivity vs Break Frequency
p5 <- ggplot(merged_data, aes(x = break_frequency_per_day, y = productivity_score)) +
  geom_boxplot(fill = "lightgreen", alpha = 0.7) +
  labs(title = "Productivity vs Break Frequency", x = "Breaks per Day", y = "Productivity Score") +
  theme_minimal()
print(p5)
ggsave(file.path(output_folder, "prod_vs_breaks.png"), p5, width=8, height=5)

# Productivity by Location and Industry
p6 <- ggplot(merged_data, aes(x = location, y = productivity_score, fill = location)) + 
  geom_boxplot(alpha = 0.7) +
  facet_wrap(~ industry) +
  labs(title = "Productivity by Location and Industry", x = "Location", y = "Productivity Score") +
  theme_minimal()
print(p6)
ggsave(file.path(output_folder, "prod_by_location_industry.png"), p6, width=10, height=6)

# Traffic Reduction vs Avg Vehicle Count
p7 <- ggplot(merged_data, aes(x = avg_vehicle_count, y = avg_traffic_reduction)) +
  geom_point(alpha = 0.6, color = "darkblue") +
  geom_smooth(method = "lm", color = "black") +
  labs(title = "Traffic Reduction vs Average Vehicle Count", x = "Avg Vehicle Count", y = "Avg Traffic Reduction (%)") +
  theme_minimal()
print(p7)
ggsave(file.path(output_folder, "traffic_reduction_vs_vehicle_count.png"), p7, width=8, height=5)

# -------------------------
# 3. Multivariate Analysis
# -------------------------

# Correlation Heatmap
if(nrow(merged_numeric) > 0){
  merged_corr <- cor(merged_numeric, use = "pairwise.complete.obs")
  png(file.path(output_folder, "correlation_heatmap.png"), width=800, height=600)
  corrplot(merged_corr, method = "color", type = "upper", tl.cex = 0.8, number.cex = 0.7)
  dev.off()
}

# Pairwise Plots
if(nrow(merged_numeric) > 0){
  ggpairs_df <- as.data.frame(merged_numeric)
  p_pairs <- GGally::ggpairs(ggpairs_df)
  print(p_pairs)
  ggsave(file.path(output_folder, "pairwise_plots.png"), p_pairs, width=12, height=10)
}
