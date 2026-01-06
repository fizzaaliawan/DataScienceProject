# DATA DICTIONARY - Remote Work and Urban Traffic Reduction  

 # Purpose:
 Complete documentation of all variables in processed datasets  

## REMOTE WORKER PRODUCTIVITY DATASET
**File**: `data/processed/remote_worker_cleaned.csv`  
**Source**: Kaggle – Remote Worker Productivity Dataset (https://www.kaggle.com/datasets/ziya07/remote-worker-productivity-dataset)
**Time Period**: 2022-2025  
**Total Records**: ~XX,XXX survey responses (after cleaning)  

### Variable Definitions:

| Variable | Data Type | Description | Example Values | Notes |
|----------|-----------|-------------|----------------|-------|
| `worker_id` | character | Unique worker identifier | "RW_00123" | Primary key |
| `location_type` | character | Type of location (home/office/hybrid) | "Home" | Used for analysis of remote work adoption |
| `industry_sector` | character | Industry of worker | "IT", "Finance" | Standardized industry categories |
| `age` | integer | Age of worker | 29 | Years |
| `experience_years` | numeric | Years of professional experience | 5 | Years |
| `average_daily_work_hours` | numeric | Average hours worked per day | 7.8 | Hours/day |
| `break_frequency_per_day` | numeric | Average number of breaks per day | 2 | Count/day |
| `task_completion_rate` | numeric | Percentage of tasks completed | 85 | % |
| `late_task_ratio` | numeric | Ratio of tasks completed late | 0.1 | Fraction |
| `calendar_scheduled_usage` | numeric | Hours spent on calendar scheduling tools | 1.5 | Hours/day |
| `focus_time_minutes` | numeric | Average focused work time per day | 210 | Minutes/day |
| `tool_usage_frequency` | numeric | Frequency of productivity tool usage | 4 | Times/day |
| `automated_task_count` | integer | Number of automated tasks handled | 3 | Count |
| `AI_assisted_planning` | numeric | Use of AI-assisted planning tools | 1 | Boolean: 1 = Yes, 0 = No |
| `real_time_feedback_score` | numeric | Worker’s score on real-time feedback system | 8.5 | Scale 0–10 |
| `productivity_label` | factor | Productivity category | Low, Moderate, High, Very High | Derived from productivity_score |
| `productivity_score` | numeric | Composite productivity metric | 72 | Calculated from task completion, focus time, breaks |

---

## URBAN TRAFFIC DATASET
**File**: `data/processed/traffic_cleaned.csv`  
**Source**: Kaggle – Urban Traffic Congestion Dataset (https://www.kaggle.com/datasets/chanchal27/urban-traffic-congestion-data  )
**Time Period**: 2022-2025  
**Total Records**: ~XX,XXX city-level traffic observations (after cleaning)  

### Variable Definitions:

| Variable | Data Type | Description | Example Values | Notes |
|----------|-----------|-------------|----------------|-------|
| `Timestamp` | datetime | Observation timestamp | 2024-01-15 08:30:00 | YYYY-MM-DD HH:MM:SS |
| `IR Presence (Lane 1-4)` | numeric | Infrared presence detection per lane | 1,0,1,1 | 1=vehicle detected, 0=empty |
| `Vehicle Count` | integer | Number of vehicles recorded | 1240 | Count per observation period |
| `Avg Speed (km/h)` | numeric | Average speed of all vehicles | 32.5 | km/h |
| `Vehicle Types Detected` | character | Types of vehicles detected | "Car,Bus,Truck" | Comma-separated |
| `Vehicle Density (%)` | numeric | Percentage of road occupancy | 70 | % |
| `Saturation Flow Rate(veh/hr/lane)` | numeric | Maximum flow rate per lane | 1800 | Vehicles/hour/lane |
| `Volume to Saturation Lane Traffic ratio(%)` | numeric | Ratio of observed volume to saturation flow | 65 | % |
| `FreeFlowSpeed (km/h)` | numeric | Speed under free-flow conditions | 50 | km/h |
| `TSR` | numeric | Time-space ratio | 0.85 | Analytical metric |
| `VLSR` | numeric | Vehicle lane saturation ratio | 0.7 | Fraction |
| `Speed Factor` | numeric | Factor comparing actual vs free flow speed | 0.65 | Fraction |
| `CI` | numeric | Congestion index | 0.72 | Computed metric |
| `Congestion Level` | factor | Congestion category | Low, Medium | Derived from vehicle count, speed, and CI |

---

## MERGED CITY-LEVEL ANALYTICAL DATASET
**File**: `data/processed/merged_remote_traffic.csv`  
**Description**: Combines remote worker productivity and urban traffic datasets for city-level analysis  

### Key Columns:

| Column | Description | Notes |
|--------|-------------|-------|
| `remote_worker_id` | Unique worker identifier | Key to merge with traffic dataset |
| `location` | Worker city/location | Standardized city name |
| `industry` | Industry sector | Standardized categories |
| `age` | Worker age | Years |
| `experience_years` | Professional experience | Years |
| `average_daily_work_hours` | Daily work hours | Hours/day |
| `break_frequency_per_day` | Daily breaks | Count/day |
| `task_completion_rate` | % tasks completed | 0–100 |
| `late_task_ratio` | Ratio of late tasks | Fraction |
| `calendar_scheduled_usage` | Hours on calendar tools | Hours/day |
| `focus_time_minutes` | Focused work time | Minutes/day |
| `tool_usage_frequency` | Productivity tool usage | Times/day |
| `automated_task_count` | Automated tasks handled | Count |
| `AI_assisted_planning` | AI planning usage | 1=Yes, 0=No |
| `real_time_feedback_score` | Real-time feedback score | 0–10 |
| `productivity_label` | Productivity category | Low, Moderate, High, Very High |
| `productivity_score` | Composite productivity metric | 0–100 |
| `congestionStatus` | Congestion category | Low, Medium |
| `avg_vehicle_count` | Average vehicle count | Count |
| `avg_speed` | Average speed of vehicles | km/h |
| `avg_traffic_reduction` | Average traffic reduction % | % |

---

## CATEGORIES & THRESHOLDS

### Congestion Levels:
- **Low:** avg_vehicle_count < 1000 and avg_speed > 25 km/h  
- **Medium:** avg_vehicle_count ≥ 1000 or avg_speed ≤ 25 km/h  

### Productivity Labels:
- **Low:** productivity_score < 50  
- **Moderate:** 50 ≤ productivity_score < 70  
- **High:** 70 ≤ productivity_score < 85  
- **Very High:** productivity_score ≥ 85  

---




