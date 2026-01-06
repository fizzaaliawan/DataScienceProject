
## Project Overview

**Title**: Remote Work and Urban Traffic Reduction  

**Data Sources**:  
1. [Urban Traffic Congestion Dataset](https://www.kaggle.com/datasets/chanchal27/urban-traffic-congestion-data)  
2. [Remote Worker Productivity Dataset](https://www.kaggle.com/datasets/ziya07/remote-worker-productivity-dataset)  

**Time Period**: 2022-2025 (survey and traffic records)  

**Objectives**:
1. Quantify the effect of remote work on urban traffic congestion.  
2. Explore relationships between worker productivity and traffic reduction.  
3. Develop predictive models for traffic reduction and congestion classification.  

---

## Executive Summary

This project analyzes the impact of remote work on urban traffic congestion and worker productivity. Using city-level traffic data and remote work survey datasets, we perform a complete data science pipeline—from data preparation and exploratory data analysis to predictive modeling. The study quantifies traffic reduction, evaluates productivity changes, and predicts congestion status, providing actionable insights for city planners and organizations implementing remote work policies.

---

## Three-Phase Methodology

### Phase 1: Data Importing, Cleaning & Transformation ✅
**Objective**: Import, clean, and merge traffic and remote work datasets for analysis.  

**Achievements**:
- Imported city-level traffic and remote worker productivity datasets  
- Cleaned numeric columns, handled missing values, removed duplicates  
- Computed key metrics:
  - `traffic_reduction_pct` = traffic reduction percentage  
  - `productivity_ratio` = remote work share × avg commute time saved  
- Merged datasets to create a city-level analytical dataset  

**Outputs**:  
`cleaned_traffic_data.csv`, `cleaned_remote_worker_productivity.csv`, `merged_remote_traffic.csv`

---

### Phase 2: Exploratory Data Analysis (EDA) 
**Objective**: Understand patterns and relationships in traffic and productivity data.  

**Statistical Analysis**:
- Descriptive statistics of traffic reduction and productivity metrics  
- Correlation analysis between productivity, work hours, breaks, and traffic  
- Trend analysis across cities and industries  

**Visualizations Created**:
1. Productivity score distribution  
2. Traffic reduction distribution  
3. Productivity vs average work hours and breaks  
4. Productivity across locations & industries  
5. Traffic reduction vs average vehicle count  
6. Correlation heatmaps and pairwise scatter plots  

**Key Findings**:
- Cities with higher remote work adoption showed significant traffic reduction  
- Productivity metrics vary by industry and location  
- Traffic reduction correlates moderately with productivity ratios  

**Outputs**: Histogram plots, scatter plots, correlation matrices

---

### Phase 3: Predictive Modeling 
**Objective**: Predict traffic reduction and classify congestion levels using machine learning.  

**Models Developed**:

#### 1. Linear Regression (Traffic Reduction Prediction)
- **Target**: `avg_traffic_reduction`  
- **Features**: Productivity score, avg work hours, breaks, task completion rate, avg vehicle count, avg speed  
- **Performance**: RMSE ≈ 0, R² ≈ 1 (due to limited unique response values)  
- **Use Case**: Quick estimation of traffic reduction in cities  

#### 2. Random Forest Regression
- **Target**: `avg_traffic_reduction`  
- **Features**: Same as above  
- **Performance**: RMSE ≈ 0.105, R² ≈ 1  
- **Use Case**: More robust prediction with feature importance insights  

#### 3. Random Forest Classification (Congestion Status)
- **Target**: `congestionStatus` (Low / Medium)  
- **Features**: Same as above  
- **Performance**: Accuracy = 100%  
- **Use Case**: Classify city congestion levels for planning and monitoring  

**Feature Importance**:
1. Productivity score – most predictive of traffic reduction  
2. Average vehicle count – significant for congestion classification  
3. Task completion rate – secondary influence  

**Outputs**: Model performance summary, feature importance plots, confusion matrix

---

## Technical Implementation

**R Packages Used**:
- Data Manipulation: dplyr, data.table, tidyr  
- Machine Learning: caret, randomForest  
- Visualization: ggplot2  


## Practical Applications

1. **City Planning** – Optimize traffic and infrastructure based on predicted congestion
2. **Organizational Strategy** – Assess productivity effects of remote work policies
3. **Policy Making** – Design interventions to reduce traffic congestion while maintaining productivity

---

## Limitations & Future Work

**Limitations**:

* Dataset limited to selected cities and years
* Low variance in some productivity metrics
* External factors (weather, public events) not considered

**Future Enhancements**:

* Expand dataset to more cities and longer time periods
* Integrate real-time traffic APIs
* Explore deep learning models for predictive accuracy
* Build interactive dashboards for city planners

---

**Team Members**:

* Fizza Ali (SP23-BCS-043)
* Laiba Ajmal (SP23-BCS-060)
* Amina Kainat (SP23-BCS-018)
* Zainab Naeem (SP22-BCS-179)

