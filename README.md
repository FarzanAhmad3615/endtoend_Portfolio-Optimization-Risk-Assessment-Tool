# 📈 Multi-Asset Portfolio Optimization Pipeline

A sophisticated end-to-end data engineering and finance project that identifies the **Efficient Frontier** for a high-growth stock portfolio (, , , , ).

## 🎯 Project Overview

The goal of this project is to move beyond "gut-feeling" investing by using **Modern Portfolio Theory**. This pipeline simulates 1,000+ portfolio combinations to find the optimal balance between risk (Volatility) and reward (Expected Return).

### **The STAR Story**

* **Situation:** Managing five major tech stocks without a clear strategy for allocation.
* **Task:** Build an automated system to calculate the Maximum Sharpe Ratio and visualize the Efficient Frontier.
* **Action:** Developed a Python simulation engine, integrated a MySQL database for historical tracking, and built a Power BI dashboard.
* **Result:** Created a functional tool that categorizes portfolios into risk tiers (Conservative, Moderate, Aggressive) for instant decision-making.

---

## 🛠️ Tech Stack

* **Language:** Python (Pandas, NumPy, SQLAlchemy)
* **Database:** MySQL (Relational storage and SQL Views)
* **Visualization:** Power BI (DAX, Interactive Scatter Plots, Slicers)
* **Theory:** Sharpe Ratio, Volatility, Expected Return

---

## 📂 System Architecture

### 1. Simulation Engine (Python)

The Python script generates random weights that always sum to 100%. It calculates the annualized return and volatility for each combination.

```python
# Feature engineering and data cleaning
df_portfolios['run_date'] = datetime.datetime.now()
df_portfolios = df_portfolios.rename(columns={'Return': 'Expected_Return'})

# Data persistence
df_portfolios.to_sql('portfolio_optimization_results', engine, if_exists='append', index=False)

```

### 2. Data Warehouse (MySQL)

Storing results in MySQL allows for historical comparison. I utilized **SQL Views** to automate the logic for Power BI.

```sql
CREATE VIEW v_daily_comparison AS
SELECT 
    DATE(run_date) AS Date,
    MAX(Sharpe_Ratio) AS Best_Sharpe
FROM portfolio_optimization_results
GROUP BY DATE(run_date);

```

### 3. Analytics Dashboard (Power BI)

The dashboard provides a "Stock Recipe" for every point on the frontier.

* **Scatter Chart:** Visualizes the trade-off between Risk and Return.
* **Asset Allocation Tooltips:** Hover over any point to see the exact weights for $AAPL, $MSFT, etc.
* **Risk Tier Slicer:** Quickly filter portfolios by Conservative or Aggressive profiles.

---

## 🚀 Key Results

* **Mathematical Precision:** Identified portfolios with the highest risk-adjusted returns (Max Sharpe Ratio).
* **Interactive Insights:** Users can click on any strategy to see the required stock breakdown instantly.
* **Scalable Architecture:** The system can easily be expanded to include hundreds of assets.

---

## 📈 How to Run

1. Clone the repository.
2. Run the Jupyter Notebook/Python script to generate simulation data.
3. Ensure your MySQL server is running (credentials: `root:12345`).
4. Open the `.pbix` file in Power BI and hit **Refresh**.

---
<img width="861" height="731" alt="py portfolio" src="https://github.com/user-attachments/assets/de763da4-7360-461a-973a-281e0508ecdc" />
<img width="1272" height="710" alt="Screenshot 2026-01-07 174958" src="https://github.com/user-attachments/assets/39dcc540-c985-4694-a0be-bdf8bc7e874d" />

