# Remote Work and Urban Traffic Reduction - Group 20

**Group Members**: Fizza Ali (SP23-BCS-043)  , Laiba Ajmal (SP23-BCS-060), Amina Kainat (SP23-BCS-018)  
**Course**: Data Science (IDS Project)  

---

## Project Overview

This project investigates the impact of remote work on urban traffic congestion and worker productivity. We analyze city-level traffic data and remote work survey data to quantify traffic reduction, productivity changes, and their relationships using statistical analysis and machine learning.

**Objectives:**
1. Assess how remote work adoption reduces traffic congestion.
2. Explore correlations between productivity metrics and traffic reduction.
3. Build predictive models to forecast traffic reduction and classify congestion levels.

**Dataset Sources:**
1. [Urban Traffic Congestion](https://www.kaggle.com/datasets/chanchal27/urban-traffic-congestion-data)  
2. [Remote Worker Productivity](https://www.kaggle.com/datasets/ziya07/remote-worker-productivity-dataset)  

---

## Project Phases

### Phase 1: Data Importing, Cleaning & Transformation
- Imported traffic and remote work datasets.
- Cleaned numeric columns, handled missing values, removed duplicates.
- Calculated derived metrics:
  - `traffic_reduction_pct` = traffic reduction percentage
  - `productivity_ratio` = remote work share × avg commute time saved
- Merged datasets for city-level analysis.

**Outputs:**  
`cleaned_traffic_data.csv`, `cleaned_remote_worker_productivity.csv`, `merged_remote_traffic.csv`

---

### Phase 2: Exploratory Data Analysis (EDA)
- Conducted univariate, bivariate, and multivariate analyses.
- Created visualizations:
  - Productivity score distribution
  - Traffic reduction distribution
  - Productivity vs work hours/breaks
  - Productivity by location & industry
  - Traffic reduction vs avg vehicle count
  - Correlation heatmaps and pairwise plots

**Outputs:**  
Histogram plots, scatter plots, correlation matrices

---

### Phase 3: Predictive Modeling
- **Regression Target:** `avg_traffic_reduction`  
- **Classification Target:** `congestionStatus`  
- Models developed:
  - Linear Regression
  - Random Forest Regression
  - Random Forest Classification
- Performance metrics:
  - RMSE, R² for regression
  - Accuracy, confusion matrix for classification

**Outputs:**  
Model performance summary, feature importance, confusion matrix

---

