-- Question: Find the customers who have spent at least $100 in each month of June and July 2024

-- English Video: https://www.youtube.com/watch?v=UI9j0kbY1lc
-- Tamil Video: https://www.youtube.com/watch?v=1hTqhP4MGY4

Create table If Not Exists Customers 
     (customer_id int, 
      name varchar(30), 
      country varchar(30));
Truncate table Customers;
insert into Customers (customer_id, name, country) values 
 (1, 'Winston', 'USA')
,(2, 'Jonathan', 'Peru')
,(3, 'Moustafa', 'Egypt');

Create table If Not Exists Product 
     (product_id int, 
      description varchar(30), 
      price int);
Truncate table Product;
insert into Product (product_id, description, price) values 
 (10, 'Phone', '300')
,(20, 'GWD T-Shirt', '10')
,(30, 'Book', '45')
,(40, 'GWD Keychain', '2');

Create table If Not Exists Orders 
     (order_id int, 
      customer_id int, 
      product_id int, 
      order_date date, 
      quantity int);
Truncate table Orders;
insert into Orders (order_id, customer_id, product_id, order_date, quantity) values 
 (1, 1, 10, '2024-06-10', 1 )
,(2, 1, 20, '2024-07-01', 1 )
,(3, 1, 30, '2024-07-08', 2 )
,(4, 2, 10, '2024-06-15', 2 )
,(5, 2, 40, '2024-07-01', 10)
,(6, 3, 20, '2024-06-24', 2 )
,(7, 3, 30, '2024-06-25', 2 )
,(9, 3, 30, '2024-05-08', 3 );

/*
+--------------+------------+
| customer_id  | name       |  
+--------------+------------+
| 1            | Winston    |
+--------------+------------+
*/

-- Approach 1: One step Aggregate Approach  
select c.customer_id, c.name 
      from Orders o 
inner join Customers c 
        on c.customer_id = o.customer_id 
inner join Product p 
        on p.product_id = o.product_id
        where o.order_date between '2020-06-01' and '2020-07-31'
        group by 1,2
        having sum(case when extract(month from order_date) = 6 
                 then o.quantity * p.price else 0 end) >= 100 
           and sum(case when extract(month from order_date) = 7 
                 then o.quantity * p.price else 0 end) >= 100;



-- Approach 2: Using CTE Approach 
with raw_data as (
select c.customer_id, c.name 
       ,left(order_date, 7) as mth
       ,sum(o.quantity * p.price) as spent
      from Orders o 
inner join Customers c 
        on c.customer_id = o.customer_id 
inner join Product p 
        on p.product_id = o.product_id
        where o.order_date between '2020-06-01' and '2020-07-31'
        group by 1,2,3
        having spent >= 100)
select customer_id, name 
from raw_data 
group by 1,2 
having count(*) > 1;



-- Approach 3: Using Windows Function 
with raw_data as (
select c.customer_id, c.name 
       ,left(order_date, 7) as mth
       ,sum(o.quantity * p.price) as spent
       ,count(*) over(partition by c.customer_id) as cnt 
      from Orders o 
inner join Customers c 
        on c.customer_id = o.customer_id 
inner join Product p 
        on p.product_id = o.product_id
        where o.order_date between '2020-06-01' and '2020-07-31'
        group by 1,2,3
        having spent >= 100)
select distinct customer_id, name 
from raw_data 
where cnt > 1;
