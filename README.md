# Store_Sales_Analysis
End-to-end Data Analytics project: Retail store sales performance analyzed using Excel (Pivot Tables &amp; dynamic dashboard) and MySQL (KPIs, customer segmentation, window functions).data-analytics, excel-dashboard, mysql, sql, data-cleaning, retail-analytics, pivot-tables, business-intelligence

## 📌 Table of Contents
- [Project Overview](#-project-overview)
- [Tech Stack](#-tech-stack)
- [Repository Structure](#-repository-structure)
- [Data Cleaning & Preparation](#-data-cleaning--preparation)
- [Interactive Excel Dashboard](#-interactive-excel-dashboard)
- [SQL Queries & Business Solutions](#-sql-queries--business-solutions)
- [Key Business Insights](#-key-business-insights)
- [Strategic Recommendations](#-strategic-recommendations)
- [How to Run & Reproduce](#-how-to-run--reproduce)

---

## 📖 Project Overview
This project performs commercial performance and exploratory data analysis on retail store transactional data. Using **Microsoft Excel** for data cleaning, feature engineering, and dynamic dashboarding alongside **MySQL** for structured query execution, window functions, and aggregation, this repository demonstrates how raw business records translate into actionable commercial insights.

---

## 🛠 Tech Stack
- **Microsoft Excel:** Data hygiene, string standardization, calculated fields, Pivot Tables, Pivot Charts, and multi-parameter interactive slicers.
- **MySQL:** Relational schema design, aggregate metrics, grouping, CTEs/subqueries, and window ranking functions (`RANK()`).
- **Documentation:** Structured reporting and query validation in PDF format.

---

## 📂 Repository Structure
```
├── data/
│   ├── RAW_Store_Dataset.xlsx             # Raw, unprocessed dataset
│   └── Cleaned_Dataset.csv                # Standardized, cleaned dataset
├── sql/
│   └── Store_Analysis.sql                 # Complete MySQL scripts
├── excel/
│   └── Taufique Store Data Analysis.xlsx  # Workbook with Pivot Tables & interactive dashboard
├── docs/
│   └── Store Sales Analysis.pdf           # Technical report with query outputs & analysis
├── images/
│   ├── dashboard_preview.png              # Excel dashboard screenshot
│   ├── kpi_metrics.png                    # SQL overall KPIs output
│   ├── sales_by_category.png              # Category revenue query result
│   ├── sales_by_channel.png               # Channel performance query result
│   ├── sales_by_gender.png                # Gender contribution query result
│   ├── sales_by_age.png                   # Age cohort query result
│   ├── monthly_trend.png                  # Monthly revenue trend query result
│   ├── top_states.png                     # Top 5 states query result
│   ├── category_percentage.png            # Category percentage contribution query result
│   └── state_ranking.png                  # State ranking with window functions
└── README.md ```
🧹 Data Cleaning & PreparationThe raw dataset contains over 31,000 transaction rows. The following preparation steps were completed in Excel prior to database ingestion:  Gender Standardization: Unified irregular categorical entries (e.g., m $\rightarrow$ Men, w $\rightarrow$ Women).  Data Type Conversion: Standardized textual quantities (e.g., "one", "two") into proper numeric integers for aggregate mathematical operations.  Cohort Segmentation: Created an Age-Group categorical attribute using logical bins:Teenager: Age $< 30$  Adult: Age $30 - 60$  Senior: Age $> 60$  Time Series Attributes: Extracted Month and chronological Month_Number to evaluate seasonal sales patterns.  Schema Sanitization: Normalized column names containing whitespace or special characters (e.g., Order ID $\rightarrow$ Order_ID) for MySQL syntax compatibility.  📈 Interactive Excel DashboardThe workbook features a dynamic Dashboard tab driven by underlying Pivot Tables and connected slicers (allowing interactive slicing across categories, channels, and regions):Key Metrics & Visualizations:Orders vs. Sales by Month: Dual-axis chart tracking volume velocity against revenue generation.Demographic Split: Bivariate charts displaying revenue distribution across age groups and gender.Omnichannel Distribution: Breakdown of sales contribution across major e-commerce platforms.Top 5 Revenue States: Regional bar chart highlighting key geographical markets.🗄 SQL Queries & Business Solutions1. Overall Commercial KPIsQuestion: What is the store's total revenue, order count, total quantity sold, and average order value (AOV)?  SQLSELECT 
    SUM(Amount) AS Total_Sales,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Qty) AS Total_Quantity,
    ROUND(SUM(Amount) / COUNT(DISTINCT Order_ID), 2) AS Average_Order_Value
FROM cleaned_dataset;
MetricValueTotal Revenue₹ 21,176,377  Total Orders28,471  Total Quantity Sold31,237  Average Order Value (AOV)₹ 743.79  2. Category Share of Total RevenueQuestion: What proportion of gross revenue does each product line represent?  SQLSELECT 
    Category,
    SUM(Amount) AS Total_Sales,
    ROUND(
        SUM(Amount) * 100.0 / (SELECT SUM(Amount) FROM cleaned_dataset),
        2
    ) AS Sales_Percentage
FROM cleaned_dataset
GROUP BY Category
ORDER BY Total_Sales DESC;
3. Omnichannel PerformanceQuestion: Which sales channels generate the highest revenue?  SQLSELECT 
    Channel,
    SUM(Amount) AS Total_Sales
FROM cleaned_dataset
GROUP BY Channel
ORDER BY Total_Sales DESC;
4. Demographic Spending AnalysisQuestion: How does spending behave across gender and age tiers?  SQL-- Spending by Gender
SELECT 
    Gender,
    SUM(Amount) AS Total_Sales
FROM cleaned_dataset
GROUP BY Gender
ORDER BY Total_Sales DESC;

-- Spending by Age Tier
SELECT 
    `Age-Group`,
    SUM(Amount) AS Total_Sales
FROM cleaned_dataset
GROUP BY `Age-Group`
ORDER BY Total_Sales DESC;
5. Geographical Ranking with Window FunctionsQuestion: How do states rank by overall sales performance using analytical window functions?  SQLSELECT 
    `ship-state`,
    Total_Sales,
    RANK() OVER (ORDER BY Total_Sales DESC) AS Sales_Rank
FROM (
    SELECT 
        `ship-state`,
        SUM(Amount) AS Total_Sales
    FROM cleaned_dataset
    GROUP BY `ship-state`
) AS State_Sales;
💡 Key Business InsightsCore Product Engine: Set is the single highest-performing category, bringing in ₹ 10,507,546 (49.62% of total sales), followed by Kurta (₹ 4.96M / 23.42%).  Primary Customer Persona: Adult women (30–60 years old) drive the business:  Female shoppers generated ₹ 13.56M (64%) of revenue.  The Adult age bracket accounted for ₹ 12.19M (57.6%) of total sales.  Platform Dominance: Amazon is the top marketplace contributing ₹ 7.52M (35.5%), with Myntra (₹ 4.94M) and Flipkart (₹ 4.57M) serving as strong secondary channels.  Geographic Concentration: The top 3 states—Maharashtra (₹ 2.99M), Karnataka (₹ 2.65M), and Uttar Pradesh (₹ 2.10M)—generate over ₹ 7.74M in combined sales.  Seasonality Patterns: Revenue peaks in March (₹ 1.93M) and declines to its lowest in November (₹ 1.62M)[cite: 2].

🎯 Strategic RecommendationsFocus Stock on Core Categories: Direct manufacturing and inventory budget primarily into Set and Kurta designs to prevent stockouts during peak ordering cycles[cite: 2].Optimize Ad Spend by Platform: Focus PPC and marketplace campaign spending on Amazon and Myntra, tailoring copy and creative targeting adult women[cite: 2].Supply Chain Alignment: Establish fulfillment hubs or faster dispatch nodes closer to high-volume states (Maharashtra and Karnataka) to minimize delivery turnaround times and shipping fees[cite: 2].Q4 Demand Strategy: Design festival bundles or early-bird promotions in October and November to lift the documented seasonal slump[cite: 2].

🚀 How to Run & Reproduce1. View the Excel DashboardClone the repository:Bashgit clone [https://github.com/](https://github.com/)<YOUR-USERNAME>/<YOUR-REPO-NAME>.git

Open excel/Taufique Store Data Analysis.xlsx.Switch to the Dashboard sheet to interact with the slicers and dynamic charts.2. Run Database QueriesCreate a database in MySQL Workbench:SQLCREATE DATABASE Project;
USE Project;
Import data/Cleaned_Dataset.csv into a table named cleaned_dataset[cite: 1, 2].Open and run sql/Store_Analysis.sql to execute all analytical queries[cite: 1].
