-- Question: Find the Customers with Maximum Order

-- English Video: https://www.youtube.com/watch?v=r_Bl22m0lP8
-- Tamil Video: https://www.youtube.com/watch?v=oYGUjtHgsNw

Create table orders (order_number int, 
                     customer_number int);
                     
Truncate table orders;
insert into orders (order_number, customer_number) values 
( 5,  1),
( 9,  2),
(12,  3),
(14,  3),
( 7,  4),
(10,  4),
( 3,  5),
( 6,  5),
(13,  5),
( 8,  6),
(11, 16),
(15, 16);

/*
+-----------------+
| customer_number |
+-----------------+
| 5               |
+-----------------+
*/

-- Approach 0: Basic SQL with limitation 
select customer_number
       from orders 
   group by customer_number 
   order by count(customer_number) desc 
      limit 1;

-- Approach 1: Basic SQL with subquery
with all_data as (
select customer_number, count(*) as cnt 
       from Orders o 
   group by 1)
select customer_number 
       from all_data 
      where cnt = (select max(cnt) from all_data);

-- Approach 2: Using Windows Function 
with all_data as (
select customer_number,
       count(*) over(partition by customer_number) as cnt 
       from Orders o )
select distinct customer_number 
       from all_data 
      where cnt = (select max(cnt) from all_data);

-- Approach 3: Using Windows Function with Distinct option 
with all_data as (
select distinct customer_number,
       count(*) over(partition by customer_number) as cnt
       from orders )
select customer_number 
       from all_data 
      where cnt = (select max(cnt) from all_data);

-- Approach 4: Automate using Windows Function 
with all_data as (
select distinct customer_number,
       count(*) over(partition by customer_number) as cnt
       from orders )
,top_customers as (
select customer_number,
       row_number() over(order by cnt desc) as rnk 
       from all_data )
select customer_number 
       from top_customers
      where rnk = 1;
