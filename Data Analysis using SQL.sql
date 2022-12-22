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
    t.market_code, SUM(t.sales_amount) as Total_sales_amount
FROM
    sales.markets m
        JOIN
    sales.transactions t ON m.markets_code = t.market_code
GROUP BY t.market_code;

---------------------------------------------------------------------------------------------------

SELECT 
    m.markets_name,
    t.market_code,
    t.product_code,
    t.order_date,
    SUM(t.sales_qty) as Sales_Quantity
FROM
    sales.markets m
        JOIN
    sales.transactions t ON m.markets_code = t.market_code
        JOIN
    sales.products p ON p.product_code = t.product_code
GROUP BY t.order_date;

--------------------------------------------------------------------------------------------------

SELECT 
    m.markets_name,
    t.market_code,
    t.order_date,
    SUM(t.sales_qty) as Sales_Quantity
FROM
    sales.markets m
        JOIN
    sales.transactions t ON m.markets_code = t.market_code
        JOIN
    sales.products p ON p.product_code = t.product_code
GROUP BY t.market_code,t.order_date
order by t.market_code;

--------------------------------------------------------------------------------------------------

SELECT 
    YEAR(order_date) AS year,
    SUM(t.sales_amount) AS Total_sales_amt,
    SUM(t.cost_price) AS Total_cost_pr
FROM
    sales.transactions t
GROUP BY YEAR(t.order_date);

--------------------------------------------------------------------------------------------------

SELECT 
    product_code,product_type,ordered_year,
    product_sales,
    CASE
        WHEN
            (prod.product_sales > 300
                AND prod.product_sales < 50)
        THEN
            ' Minimum Orders'
        WHEN
            (prod.product_sales > 300
                AND prod.product_sales < 1500)
        THEN
            'Average Orders'
        WHEN prod.product_sales > 1500 THEN 'Top Orders'
        ELSE 'Low Orders'
    END AS Orders
FROM
    (SELECT 
        t.product_code,p.product_type,
            YEAR(t.order_date) as ordered_year,
            SUM(t.sales_qty) AS product_sales
    FROM
        sales.transactions t
        join sales.products p 
        on t.product_code = p.product_code
    GROUP BY t.product_code , ordered_year) AS prod;

--------------------------------------------------------------------------------------------------

SELECT 
    m.markets_name, revenue_contribution_percentage
FROM
    sales.markets m
        JOIN
    (SELECT 
        t.market_code,
            SUM(t.profit_margin) AS profit_margin,
            SUM(t.sales_amount) AS Revenue,
            ((SUM(t.profit_margin) / SUM(t.sales_amount)) * 100) AS revenue_contribution_percentage
    FROM
        sales.transactions t
    GROUP BY t.market_code) AS temp ON m.markets_code = temp.market_code;

--------------------------------------------------------------------------------------------------

with tab1 AS (SELECT m.markets_name as market_name,SUM(t.sales_amount) Sales_made
				  FROM sales.transactions t 
				  JOIN sales.markets m
	              ON t.market_code=m.markets_code
	              JOIN sales.products p
	              ON t.product_code=p.product_code
	              group by m.markets_name),
	 
	 tab2 AS (SELECT Max(tab1.Sales_made) Max_sales
	  		FROM  tab1)

	SELECT tab1.market_name,tab2.Max_sales
	FROM tab1
	JOIN tab2
	ON tab1.Sales_made = tab2.Max_sales;
    
