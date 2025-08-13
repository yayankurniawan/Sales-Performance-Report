SELECT
    YEAR(order_date) AS years,                     
    COUNT(DISTINCT customer) AS number_of_customer 
FROM dqlab_sales_store.sales
WHERE order_status = 'Order Finished'             
  AND YEAR(order_date) BETWEEN 2009 AND 2012       
GROUP BY years                                     
ORDER BY years ASC;                              
