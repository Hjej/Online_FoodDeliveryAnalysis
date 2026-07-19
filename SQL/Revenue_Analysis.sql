SELECT * FROM onlinefooddelivery_cleaned;
-- 1. Identify Top-Spending customers
SELECT customer_id,
	  COUNT(order_id) AS total_orders,
	   round(sum(final_amount)::numeric,2) AS total_spent FROM onlinefooddelivery_cleaned
GROUP BY customer_id
ORDER BY total_spent desc;

--2. Analyze age group vs order value

SELECT customer_age,
	   count(order_id) as total_order,
	   round(avg(order_value::numeric),2) AS order_value
FROM onlinefooddelivery_cleaned
GROUP BY customer_age
ORDER BY order_value desc;

--3. Weekend vs weekday order patterns

SELECT order_day,final_amount FROM onlinefooddelivery_cleaned;

SELECT order_day_type,
	   count(order_id) as total_order,
	   round(sum(final_amount::numeric),2) AS total_spent
FROM onlinefooddelivery_cleaned
GROUP BY order_day_type 
ORDER BY total_spent desc;

--Revenue & Profit Analysis
--4. Monthly revenue trends

SELECT order_month,
       round(sum(final_amount::numeric),2) AS total_revenue
FROM onlinefooddelivery_cleaned
GROUP BY order_month
ORDER BY order_month;

SELECT order_month,
       round(sum(final_amount::numeric),2) AS total_revenue
FROM onlinefooddelivery_cleaned
GROUP BY order_month
ORDER BY case order_month
	  when 'January' Then 1
	  when 'Febrary' Then 2
	  when 'March' Then 3 
	  WHEN 'April' THEN 4
      WHEN 'May' THEN 5
      WHEN 'June' THEN 6
      WHEN 'July' THEN 7
      WHEN 'August' THEN 8
      WHEN 'September' THEN 9
      WHEN 'October' THEN 10
      WHEN 'November' THEN 11
      WHEN 'December' THEN 12
END;


--5. Impact of discounts on profit
SELECT discount_applied,
       count(order_id) AS total_orders,
	   round(avg(profit_margin_percentage)::numeric,2) AS avg_profitmargin
FROM onlinefooddelivery_cleaned
GROUP BY discount_applied
ORDER BY discount_applied;

--6. High-revenue cities and cuisines

SELECT city,cuisine_type, round(sum(final_amount)::numeric,2) as total_revenue
FROM onlinefooddelivery_cleaned
GROUP BY city,cuisine_type
ORDER BY total_revenue desc;

--Delivery Performance
--7. Average delivery time by city

SELECT city,round(avg(delivery_time_min)::numeric,2) as avg_delivery_time
FROM onlinefooddelivery_cleaned
GROUP BY city
ORDER BY avg_delivery_time desc;

--8. Distance vs delivery delay analysis

SELECT distance_km,round(avg(delivery_time_min::numeric),2) as avg_delivery_time
FROM onlinefooddelivery_cleaned
GROUP BY distance_km
ORDER BY distance_km

--9. Delivery rating vs delivery time

SELECT delivery_rating,
	   COUNT(order_id) as total_orders,
	   round(avg(delivery_time_min::numeric),2) as avg_delivery_time
FROM onlinefooddelivery_cleaned
GROUP BY delivery_rating
ORDER BY avg_delivery_time desc

--Restaurant Performance
--10.Top-rated restaurants

SELECT restaurant_name,
	   COUNT(order_id) as total_orders,
	   round(avg(restaurant_rating::numeric),2) as avg_rating 
FROM onlinefooddelivery_cleaned
GROUP BY restaurant_name
ORDER BY avg_rating desc

-- 11. Cancellation rate by restaurant

--cancellation_rate=(cacelled_orders/total_orders)*100
SELECT restaurant_name,
	   COUNT(*) filter (where order_status='cancelled') As cancelled_orders,
	   round(COUNT(*) filter (where order_status='cancelled')*100.0 /COUNT(order_id),2) as cancellation_rate  
FROM onlinefooddelivery_cleaned
GROUP BY restaurant_name
ORDER BY cancellation_rate desc;
 
--12. Cuisine-wise performance

SELECT cuisine_type,
	   COUNT(order_id) AS total_orders,
	   ROUND(sum(final_amount::numeric),2) AS total_revenue,
	   ROUND(avg(restaurant_rating::numeric),2) AS avg_rating
FROM onlinefooddelivery_cleaned
GROUP BY cuisine_type
ORDER BY total_revenue desc;

--Operational Insights
-- 13. Peak hour demand analysis

SELECT * from onlinefooddelivery_cleaned

--We can't do peak hour analysis because the dataset doesn't include the order time or hour.


--14. Payment mode preferences

SELECT payment_mode,COUNT(order_id) as total_orders
FROM onlinefooddelivery_cleaned
GROUP BY payment_mode
ORDER BY total_orders DESC;

--15. Cancellation reason analysis
SELECT
    cancellation_reason,
    COUNT(order_id) AS total_cancellations
FROM onlinefooddelivery_cleaned
WHERE order_status = 'cancelled'
GROUP BY cancellation_reason
ORDER BY total_cancellations DESC;



