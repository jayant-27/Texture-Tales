create database cs4;
use cs4;

-- Q1
select sum(qty) AS 'Total Quantity', product_name 
From Sales 
inner join product_details on product_id=sales.prod_id 
group by product_name
 order by sum(qty) desc;
 
-- Q2
SELECT sum(qty * sales.price) as 'Revenue'
FROM sales;

-- Q3
select sum(discount) as 'total discount amt'
From sales; 

-- Q4
SELECT count(distinct txn_id) From sales;   

-- Q5
SELECT AVG(unique_products) AS avg_unique_products
FROM (
    SELECT 
        txn_id,
        COUNT(DISTINCT prod_id) AS unique_products
    FROM sales
    GROUP BY txn_id
) t;

-- Q6
WITH cte_transaction_discounts AS (
	SELECT
		txn_id,
		SUM(price * qty * discount)/100 AS total_discount
	FROM sales
	GROUP BY txn_id
)
SELECT
	ROUND(AVG(total_discount)) AS avg_unique_products
FROM cte_transaction_discounts;

-- Q7
WITH cte_member_transaction as(
	SELECT member,txn_id,sum(price*qty) as revenue
    FROM sales
    GROUP BY txn_id,member
    )
SELECT member,round(avg(revenue),2) as avg_revenue
FROM cte_member_transaction
group by member;
 
-- Q8
SELECT product_details.product_name,sum(sales.price * sales.qty) as no_dis_revenue
FROM sales
inner join product_details on product_id=sales.prod_id
GROUP BY product_details.product_name
ORDER BY no_dis_revenue DESC
LIMIT 3
;

-- Q9
SELECT 
	details.segment_id,
	details.segment_name,
	SUM(sales.qty) AS total_quantity,
	SUM(sales.qty * sales.price) AS total_revenue,
	SUM(sales.qty * sales.price * sales.discount)/100 AS total_discount
FROM sales AS sales
INNER JOIN product_details AS details
	ON sales.prod_id = details.product_id
GROUP BY 
	details.segment_id,
	details.segment_name
ORDER BY total_revenue DESC;


-- Q10 
SELECT
	details.segment_id,
	details.segment_name,
	details.product_id,
	details.product_name,
	SUM(sales.qty) AS product_quantity
FROM sales AS sales
INNER JOIN product_details AS details
	ON sales.prod_id = details.product_id
GROUP BY
	details.segment_id,
	details.segment_name,
	details.product_id,
	details.product_name
ORDER BY product_quantity DESC
LIMIT 5;


-- Q11
SELECT 
	details.category_id,
	details.category_name,
	SUM(sales.qty) AS total_quantity,
	SUM(sales.qty * sales.price) AS total_revenue,
	SUM(sales.qty * sales.price * sales.discount)/100 AS total_discount
FROM sales AS sales
INNER JOIN product_details AS details
	ON sales.prod_id = details.product_id
GROUP BY 
	details.category_id,
	details.category_name
ORDER BY total_revenue DESC;


-- Q12
SELECT 
  details.category_id,
  details.category_name,
  details.product_id,
  details.product_name,
  SUM(sales.qty) AS product_quantity
FROM sales AS sales
INNER JOIN product_details AS details
ON sales.prod_id = details.product_id
GROUP BY details.product_id
ORDER BY product_quantity DESC
LIMIT 5;
