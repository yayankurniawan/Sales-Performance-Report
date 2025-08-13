SELECT
YEAR(order_date) AS years,
product_sub_category,
SUM(sales) AS sales
FROM dqlab_sales_store.sales
WHERE order_status = 'Order Finished'
AND YEAR(order_date) BETWEEN 2011 AND 2012
GROUP BY years, product_sub_category
ORDER BY years, sales DESC;