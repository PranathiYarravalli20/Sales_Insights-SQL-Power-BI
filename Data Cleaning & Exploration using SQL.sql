### Data Cleaning & Exploration Using SQL

SELECT 
    *
FROM
    sales.customers;
    
--------------------------------------------------------------------------------------------------    
    
SELECT 
    COUNT(*)
FROM
    sales.customers;

--------------------------------------------------------------------------------------------------

SELECT 
    *
FROM
    sales.transactions
WHERE
    market_code = 'Mark001';

--------------------------------------------------------------------------------------------------

SELECT DISTINCT
    product_code
FROM
    sales.transactions
WHERE
    market_code = 'Mark001';

--------------------------------------------------------------------------------------------------

SELECT 
    *
FROM
    sales.transactions
WHERE
    currency = 'USD';

SELECT 
    sales.transactions.*, sales.date.*
FROM
    sales.transactions
        INNER JOIN
    sales.date ON transactions.order_date = date.date
WHERE
    date.year = 2020;

SELECT 
    SUM(transactions.sales_amount)
FROM
    sales.transactions
        INNER JOIN
    sales.date ON transactions.order_date = date.date
WHERE
    date.year = 2020
        AND transactions.currency = 'INR'
        OR transactions.currency = 'USD';
	
SELECT 
    SUM(transactions.sales_amount)
FROM
    sales.transactions
        INNER JOIN
    sales.date ON transactions.order_date = date.date
WHERE
    date.year = 2020
        AND date.month_name = 'January'
        AND (transactions.currency = 'INR'
        OR transactions.currency = 'USD');

SELECT 
    SUM(transactions.sales_amount)
FROM
    sales.transactions
        INNER JOIN
    sales.date ON transactions.order_date = date.date
WHERE
    date.year = 2020
        AND transactions.market_code = 'Mark001';


