# 📊 E-Commerce Revenue & Promotion Analytics

## 📌 Project Overview
This project diagnoses a significant revenue decline for an online retail business and provides data-backed, strategic recommendations to stabilize the customer base and protect profit margins. 

The primary business objective was to determine if the current promotional strategy is profitable and to identify which customer segments should be prioritized for retention versus acquisition spend[cite: 1]. The analysis moves from foundational data cleaning in Python to advanced RFM/Cohort modeling in SQL, culminating in a dynamic, 6-page Power BI presentation layer.

## 🛠️ Tech Stack & Architecture
* **Python (Pandas, SciPy, NumPy):** Data ingestion, Exploratory Data Analysis (EDA), multi-dimensional logic synthesis, and statistical hypothesis testing (Welch's t-test & Pearson Correlation)[cite: 1, 3].
* **MySQL:** Advanced window functions, aggregations, and date math for Customer Segmentation (RFM) and Cohort Retention tracking.
* **Power BI:** Live database connection, DAX measure creation, and interactive visual storytelling utilizing custom KPI cards and conditional formatting.

## 📁 Repository Structure
The project is organized into three main analytical engines:

### 1. Python Notebooks (`/notebooks`)
* `01_data_cleaning.ipynb`: Standardized data types, isolated cancelled orders for return-rate tracking, and established a clean "single source of truth"[cite: 1].
* `02_exploratory_data_analysis.ipynb`: Visualized the monthly revenue trend, market concentration, and top products by revenue and quantity[cite: 2].
* `03_statistical_testing.ipynb`: Conducted independent samples t-tests and Pearson correlation to measure the true impact of discount depth on sales volume[cite: 3].
* `04_promo_effectiveness.ipynb`: Synthesized RFM scores with time-series promotional flags to determine exactly which customer segments consumed the discounts[cite: 4].

### 2. SQL Scripts (`/sql`)
* `01_monthly_revenue_trend.sql` - `04_promo_flag_detection.sql`: Time-series extraction and baseline metric building.
* `05_rfm_scoring.sql`: Customer segmentation using `NTILE()` window functions.
* `06_cohort_retention.sql`: Complex date math to build a descending customer retention matrix.

### 3. Dashboard (`/dashboard`)
* `retail_analytics.pbix`: A 6-page interactive Power BI dashboard featuring an Executive Overview, Regional Trends, RFM Segment Distribution, a Cohort Retention Heatmap, and a custom UI-designed Business Recommendations closing page.

## 💡 Core Business Insights
1. **The Loyalty Subsidy:** Synthesis of promotional flags and RFM tiers revealed that **67.2% of promotional revenue was consumed by "Champions"**[cite: 4]. The business is heavily subsidizing loyal customers rather than reactivating dormant ones[cite: 4].
2. **Margin Erosion:** Hypothesis testing ($p < 0.05$) proved that revenue during promotional periods (£129.90 average) was statistically significantly lower than non-promotional periods (£299.22 average)[cite: 3]. Deep discounts are failing to drive compensatory volume[cite: 3].
3. **Diminishing Returns:** Pearson correlation ($r = -0.0342$) confirmed a statistically significant negative correlation between discount depth and volume sold[cite: 3]. 

## 🚀 Strategic Recommendations
* **Reallocate Promotional Spend:** Divert blanket discount budgets toward personalized activation campaigns for "At Risk" and "Lost" customer segments.
* **Optimize Discount Strategy:** Implement shallower discount ceilings to protect baseline margins, as current deep discounts actively erode profitability.
* **Strengthen Customer Retention:** Launch automated, time-bound retention sequences precisely before historical cohort churn cliffs to stabilize the active user base.
