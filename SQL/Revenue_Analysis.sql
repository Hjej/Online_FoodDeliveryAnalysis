select * from onlinefooddelivery_cleaned;
select distinct city from onlinefooddelivery_cleaned;
-- 1. Identify Top-Spending customers
select * from onlinefooddelivery_cleaned;

select customer_id,
	   count(order_id) as total_orders,
	   round(sum(final_amount)::numeric,2) as total_spent from onlinefooddelivery_cleaned
group by customer_id
order by total_spent desc;

--2. Analyze age group vs order value

select * from onlinefooddelivery_cleaned;

select customer_age,
	   count(order_id) as total_order,
	   round(avg(order_value::numeric),2) as order_value
from onlinefooddelivery_cleaned
group by customer_age
order by order_value desc;

--3. Weekend vs weekday order patterns

select * from onlinefooddelivery_cleaned;

select order_day,final_amount from onlinefooddelivery_cleaned;

select order_day_type,
	   count(order_id) as total_order,
	   round(sum(final_amount::numeric),2) as total_spent
from onlinefooddelivery_cleaned
group by order_day_type 
order by total_spent desc;

--Revenue & Profit Analysis
--4. Monthly revenue trends

select * from onlinefooddelivery_cleaned;

select order_month,
       round(sum(final_amount::numeric),2) as total_revenue
from onlinefooddelivery_cleaned
group by order_month
order by order_month;

select order_month,
       round(sum(final_amount::numeric),2) as total_revenue
from onlinefooddelivery_cleaned
group by order_month
order by case order_month
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
select * from onlinefooddelivery_cleaned

select discount_applied,final_amount,profit_margin_percentage from onlinefooddelivery_cleaned;

select discount_applied,
       count(order_id) as total_orders,
	   round(avg(profit_margin_percentage)::numeric,2) as avg_profitmargin
from onlinefooddelivery_cleaned
group by discount_applied
order by discount_applied;

--6. High-revenue cities and cuisines

select * from onlinefooddelivery_cleaned
select city,cuisine_type,final_amount from onlinefooddelivery_cleaned

select city,round(sum(final_amount)::numeric,2) as total_revenue
from onlinefooddelivery_cleaned
group by city
order by total_revenue desc;

select city,cuisine_type, round(sum(final_amount)::numeric,2) as total_revenue
from onlinefooddelivery_cleaned
group by city,cuisine_type
order by total_revenue desc;

--Delivery Performance
--7. Average delivery time by city
select * from onlinefooddelivery_cleaned
select city,round(avg(delivery_time_min)::numeric,2) as avg_delivery_time
from onlinefooddelivery_cleaned
group by city
order by avg_delivery_time desc;
--8. Distance vs delivery delay analysis
select * from onlinefooddelivery_cleaned
select distance_km,round(avg(delivery_time_min::numeric),2) as avg_delivery_time
from onlinefooddelivery_cleaned
group by distance_km
order by distance_km

--9. Delivery rating vs delivery time

select * from onlinefooddelivery_cleaned

select delivery_rating,
	   count(order_id) as total_orders,
	   round(avg(delivery_time_min::numeric),2) as avg_delivery_time
from onlinefooddelivery_cleaned
group by delivery_rating
order by avg_delivery_time desc

--Restaurant Performance
--10.Top-rated restaurants
select * from onlinefooddelivery_cleaned

select restaurant_name,
	   count(order_id) as total_orders,
	   round(avg(restaurant_rating::numeric),2) as avg_rating 
from onlinefooddelivery_cleaned
group by restaurant_name
order by avg_rating desc

-- 11. Cancellation rate by restaurant
select * from onlinefooddelivery_cleaned
'''select restaurant_name,
	   count(order_id) as total_orders,
	   cancellation_reason
from onlinefooddelivery_cleaned
group by restaurant_name,cancellation_reason
order by cancellation_reason'''

select distinct order_status from onlinefooddelivery_cleaned
--cancellation_rate=(cacelled_orders/total_orders)*100
select restaurant_name,
	   count(*) filter (where order_status='cancelled') As cancelled_orders,
	   round(count(*) filter (where order_status='cancelled')*100.0 /count(order_id),2) as cancellation_rate  
from onlinefooddelivery_cleaned
group by restaurant_name
order by cancellation_rate desc;
 
--12. Cuisine-wise performance
select * from onlinefooddelivery_cleaned

select cuisine_type,count(order_id) as total_order
from onlinefooddelivery_cleaned
group by cuisine_type

select cuisine_type,
	   count(order_id) as total_orders,
	   round(sum(final_amount::numeric),2) as total_revenue,
	   round(avg(restaurant_rating::numeric),2) as avg_rating
from onlinefooddelivery_cleaned
group by cuisine_type
order by total_revenue desc;

--Operational Insights
-- 13. Peak hour demand analysis
select * from onlinefooddelivery_cleaned
--order_month,order_weekday,order_month
--We can't do peak hour analysis because the dataset doesn't include the order time or hour.


--14. Payment mode preferences
select * from onlinefooddelivery_cleaned
--payment_mode,order_id

select payment_mode,count(order_id) as total_orders
from onlinefooddelivery_cleaned
group by payment_mode
order by total_orders desc



--15. Cancellation reason analysis
select * from onlinefooddelivery_cleaned



