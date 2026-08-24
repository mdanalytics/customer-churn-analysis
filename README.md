# Customer-Churn-Analysis
End-to-end Customer Churn Analysis using MySQL and Power BI

## 📌 Project Overview

This project analyzes customer churn data to identify the major factors influencing customer attrition, measure churn rates, understand customer behavior, and provide business recommendations to improve customer retention.

## 🎯 Project Objective

The main objectives of this project are:

* Analyze overall customer churn.
* Identify major churn drivers.
* Compare churn across customer segments.
* Analyze contract, payment method, internet service, tenure, and other factors.
* Build a Power BI dashboard to visualize key findings.
* Provide data-driven recommendations to reduce customer churn.

## 🛠️ Tools & Technologies

* **MySQL** — Data cleaning, validation, SQL analysis
* **Power BI** — Data visualization and dashboard
* **SQL** — Aggregation, filtering, CTEs, window functions, CASE statements
* **DAX** — Power BI calculations

## 📊 Dataset

* **Dataset:** Customer Churn Dataset
* **Table:** `customer_data`
* **Columns:** 32
* **Rows:** 6,418
* **Primary Key:** `customer_id`

## 🔄 Project Workflow

```text
Raw Customer Data
       ↓
Data Inspection
       ↓
Data Quality Checks
       ↓
Data Cleaning
       ↓
Cleaned SQL View
       ↓
Exploratory Data Analysis
       ↓
Churn Analysis
       ↓
Power BI Dashboard
       ↓
Business Insights
       ↓
Recommendations
```

## 🧹 Data Cleaning

The project includes:

* NULL and blank value checks
* Duplicate customer ID validation
* Data type validation
* Invalid value checks
* Negative financial value checks
* Revenue consistency validation
* Text standardization using `TRIM()`
* Missing-value handling using `COALESCE()` and `NULLIF()`
* Creation of the `v_clean_customer_data` view

## 📈 Key Analysis

The analysis covers:

* Overall churn rate
* Gender analysis
* Age/Senior Citizen analysis
* Contract analysis
* Internet service analysis
* Phone service analysis
* Multiple lines
* Online security
* Online backup
* Device protection
* Tech support
* Streaming services
* Payment method
* Monthly charges
* Total charges
* Customer tenure
* Customer segments
* Churn reasons
* State-wise churn

## 📌 Key Findings

* Overall customer churn rate was **26.99%**.
* Month-to-month customers showed the highest churn.
* Fiber optic customers showed a relatively high churn rate.
* Early-tenure customers were more vulnerable to churn.
* Payment method was associated with differences in churn.
* Gender showed only a small difference in churn rate.
* Customer churn was particularly concentrated in certain service and contract segments.

## 📊 Power BI Dashboard

The Power BI dashboard presents key KPIs and visual analysis of customer churn.

### Dashboard Preview

![Customer Churn Dashboard](Dashboard/customer_churn_dashboard.png)

## 💡 Business Recommendations

Based on the analysis, the project recommends:

1. Encourage month-to-month customers to move toward longer-term contracts.
2. Improve onboarding and technical support for new Fiber Optic customers.
3. Encourage customers using manual payment methods to adopt automated payments.
4. Introduce loyalty programs during the first 12 months.
5. Focus retention campaigns on high-risk customer segments rather than gender.
6. Improve device upgrade and value-added offers.
7. Monitor pricing and competitor-related churn reasons.
8. Improve customer-support training and satisfaction monitoring.
9. Capture accurate churn reasons during cancellation.
10. Improve data-value and plan offerings for high-data customers.

## 📁 Project Structure

```text
customer-churn-analysis/
│
├── SQL/
│   ├── 00_complete_project.sql
│   ├── 01_data_exploration.sql
│   ├── 02_data_cleaning.sql
│   ├── 03_churn_analysis.sql
│   └── 04_business_insights.sql
│
├── PowerBI/
│   └── Customer_Churn_Analysis.pbix
│
├── Dashboard/
│   └── customer_churn_dashboard.png
│
└── README.md
```

## 👨‍💻 Author

**Mohammed Hassan**

**Role:** Data Analyst

**Project:** Customer Churn Analysis

**Tools:** MySQL | Power BI | SQL | DAX
