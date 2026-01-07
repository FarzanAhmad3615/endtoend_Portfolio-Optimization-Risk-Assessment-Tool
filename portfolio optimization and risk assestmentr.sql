use Portfolio;
#1. Find the Minimum Volatility Portfolio
#This query identifies the "safest" portfolio configuration among all your simulations.
SELECT * FROM portfolio_optimization_results 
ORDER BY Volatility ASC 
LIMIT 1;
#2. Find the Optimal (Tangency) Portfolio
#This finds the portfolio with the best return for every unit of risk taken.
SELECT * FROM portfolio_optimization_results 
ORDER BY Sharpe_Ratio DESC 
LIMIT 1;
#3. Data Integrity Check
#It’s a good habit to ensure your optimizer worked correctly. This query checks if the sum of weights for each portfolio equals 1 (100%).
SELECT *, 
(Weight_AAPL + Weight_MSFT + Weight_GOOGL + Weight_AMZN + Weight_TSLA) AS Total_Weight
FROM portfolio_optimization_results
HAVING Total_Weight NOT BETWEEN 0.999 AND 1.001;
-- Find the best risk-adjusted portfolio for today
SELECT * FROM portfolio_optimization_results 
WHERE DATE(run_date) = CURDATE()
ORDER BY Sharpe_Ratio DESC 
LIMIT 1;

WITH DailyBest AS (
    SELECT 
        DATE(run_date) as report_date,
        MAX(Sharpe_Ratio) as best_sharpe,
        AVG(Expected_Return) as avg_return
    FROM portfolio_optimization_results
    GROUP BY DATE(run_date)
)
SELECT 
    t.report_date AS Today,
    t.best_sharpe AS Today_Sharpe,
    y.best_sharpe AS Yesterday_Sharpe,
    (t.best_sharpe - y.best_sharpe) AS Sharpe_Change
FROM DailyBest t
LEFT JOIN DailyBest y 
    ON y.report_date = DATE_SUB(t.report_date, INTERVAL 1 DAY)
WHERE t.report_date = CURDATE();
CREATE OR REPLACE VIEW v_daily_portfolio_comparison AS
WITH DailyBest AS (
    SELECT 
        DATE(run_date) as report_date,
        MAX(Sharpe_Ratio) as best_sharpe,
        AVG(Expected_Return) as avg_return
    FROM portfolio_optimization_results
    GROUP BY DATE(run_date)
)
SELECT 
    t.report_date AS Today,
    t.best_sharpe AS Today_Sharpe,
    y.best_sharpe AS Yesterday_Sharpe,
    (t.best_sharpe - y.best_sharpe) AS Sharpe_Change
FROM DailyBest t
LEFT JOIN DailyBest y 
    ON y.report_date = DATE_SUB(t.report_date, INTERVAL 1 DAY);
SELECT *,
    CASE 
        WHEN Volatility < 0.20 THEN 'Conservative'
        WHEN Volatility BETWEEN 0.20 AND 0.30 THEN 'Moderate'
        ELSE 'Aggressive'
    END AS Risk_Category
FROM portfolio_optimization_results
WHERE DATE(run_date) = CURDATE()
ORDER BY Sharpe_Ratio DESC;