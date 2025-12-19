-- File: data_validation_checks.sql
-- Purpose: Demonstrate data quality checks for reporting tables

-- 1. Row Count Check: Ensure expected number of rows per day
SELECT order_date, COUNT(*) AS row_count
FROM orders
GROUP BY order_date
ORDER BY order_date;

-- 2. Date Range Check: Confirm data covers the correct period
SELECT MIN(order_date) AS start_date, MAX(order_date) AS end_date
FROM orders;

-- 3. Negative Revenue Check: Ensure no negative revenue values exist
SELECT *
FROM orders
WHERE order_amount < 0;

-- 4. Duplicate Order Check: Identify duplicate order IDs
SELECT order_id, COUNT(*) AS occurrence
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- 5. Null Customer Check: Identify orders missing customer IDs
SELECT *
FROM orders
WHERE customer_id IS NULL;



