### Data Analysis using SQL

SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_ROWS  
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'sales';

--------------------------------------------------------------------------------------------------

SELECT 'First Date', MIn(Order_Date)  
FROM sales.transactions  
UNION  
SELECT 'Last Date', MAX(Order_Date)  
FROM sales.transactions;

--------------------------------------------------------------------------------------------------

SELECT d.year, SUM(Sales_Amount)
FROM sales.transactions as t
JOIN sales.date as d
ON t.Order_Date = d.date
WHERE d.year = '2019'
UNION
SELECT d.year, SUM(Sales_Amount)
FROM sales.transactions as t
JOIN sales.date as d
ON t.Order_Date = d.date
WHERE d.year = '2020';



SELECT currency, COUNT(currency)
FROM sales.transactions
GROUP BY currency;

--------------------------------------------------------------------------------------------------

SELECT 
    t.market_code, SUM(t.sales_amount)
FROM
    sales.markets m
        JOIN
    sales.transactions t ON m.markets_code = t.market_code
GROUP BY t.market_code;