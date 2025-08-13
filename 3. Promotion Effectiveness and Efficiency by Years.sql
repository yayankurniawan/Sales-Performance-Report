SELECT
    years,
    sales,
    promotion_value,
    ROUND(
        (promotion_value / sales) * 100, 2 
    ) AS burn_rate_percentage
FROM 
(
SELECT
    EXTRACT(YEAR FROM order_date) AS years,
    SUM(sales) AS sales,
    SUM(discount_value) AS promotion_value
FROM 
    dqlab_sales_store.sales
WHERE 
    order_status = 'Order Finished'
AND 
    EXTRACT(YEAR FROM order_date) 
BETWEEN 
    2009 AND 2012
GROUP BY 
    1
) AS summary_of_year
ORDER BY 
    1;