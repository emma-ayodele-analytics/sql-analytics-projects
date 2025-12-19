-- Purpose: Core reporting metrics used for executive and operational dashboards
-- Author: Emma Ayodele
-- Notes: Logic aligns with definitions in REPORTING_METRICS.md

-- Business Question:
-- How much revenue was generated from completed orders?

-- Assumptions:
-- - Only completed orders are included
-- - Refunds and cancellations are excluded

SELECT
  SUM(order_amount) AS total_revenue
FROM orders
WHERE order_status = 'completed';

-- Business Question:
-- How many unique customers placed at least one completed order each month?

SELECT
  DATE_TRUNC('month', order_date) AS month,
  COUNT(DISTINCT customer_id) AS monthly_active_customers
FROM orders
WHERE order_status = 'completed'
GROUP BY 1
ORDER BY 1;


-- Business Question:
-- What is the month-over-month revenue growth rate?

WITH monthly_revenue AS (
  SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(order_amount) AS revenue
  FROM orders
  WHERE order_status = 'completed'
  GROUP BY 1
)
SELECT
  month,
  revenue,
  (revenue - LAG(revenue) OVER (ORDER BY month))
    / LAG(revenue) OVER (ORDER BY month) AS revenue_growth_rate
FROM monthly_revenue;
