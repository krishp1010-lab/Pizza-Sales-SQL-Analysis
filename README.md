# 🍕 The Pizza Project: SQL Business Analytics Case Study

## 📋 Project Overview
This project is a deep dive into the operations of a pizza store using a dataset of **21,350 orders** and **49,574 pizzas sold**. The goal was to move beyond basic data extraction and provide actionable insights for marketing and inventory management.

## 🛠️ Technical Workflow
1. **Database Design:** Created a relational schema involving 4 interconnected tables (Orders, Order_Details, Pizzas, and Pizza_Types).
2. **Data ETL:** Cleaned and loaded CSV data into MySQL Workbench.
3. **Advanced SQL Analysis:** - Utilized **Window Functions** for cumulative revenue tracking.
   - Applied **JOINS and Subqueries** for category-level performance metrics.
   - Used **Date/Time Functions** to identify peak operational hours.

## 📊 Key Business Insights (KPIs)
- **Total Revenue:** $817,860.05
- **Average Order Value (AOV):** $38.31
- **Peak Performance:** Friday is the highest revenue day ($136k), while Sunday is the lowest ($99k).
- **Top Product:** The **Thai Chicken Pizza** is the #1 revenue generator (~$43k).

## 💡 Marketing & Growth Strategy
- **Sunday Family Bundles:** Proposed a promotional strategy to bridge the 27% revenue gap on Sundays.
- **Menu Optimization:** Identified that "Large" pizzas account for nearly 46% of sales, suggesting a focus on L-size combo deals.
- **AOV Boost:** Recommended upselling "Premium" pizzas (Thai/BBQ Chicken) to customers ordering "Classic" staples.

## 📂 Repository Structure
- `Dataset/`: Contains the 4 raw CSV files.
- `SQL_Scripts/`: SQL files for Table Creation and Analysis Queries.
- `Presentation/`: The final project PDF with full visualizations.
