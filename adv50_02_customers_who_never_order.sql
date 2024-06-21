-- Question: Find all customers who never order anything

-- English Video: https://www.youtube.com/watch?v=GxhgVYly0ig
-- Tamil Video: https://www.youtube.com/watch?v=auhfFXVbbcA

Create table Customers (customer_id int, name varchar(255));
Truncate table Customers;
insert into Customers (customer_id, name) values 
 (1, 'Joe')
,(2, 'Henry')
,(3, 'Sam')
,(4, 'Max');

Create table Orders (order_id int, customer_id int);
Truncate table Orders;
insert into Orders (order_id, customer_id) values 
 (1, 3)
,(2, 1);

-- Expected Output 
/*
+-----------+
| Customers |
+-----------+
| Henry     |
| Max       |
+-----------+
*/

-- Using Left Join to find the customers not ordered
select c.name as customers
       from Customers c 
  left join Orders o 
         on o.customer_id = c.customer_id 
      where o.order_id is null 
   order by 1;
