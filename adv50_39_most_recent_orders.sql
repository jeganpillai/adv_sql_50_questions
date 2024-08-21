-- Question: Find the most recent order(s) of each product

-- English Video: https://www.youtube.com/watch?v=NnB2FwdMLhM
-- Tamil Video: https://www.youtube.com/watch?v=CN53cH2GEKQ

Create table Customers (customer_id int, 
                        name varchar(10));
Truncate table Customers;
insert into Customers (customer_id, name) values 
 (1, 'Winston'  )
,(2, 'Jonathan' )
,(3, 'Annabelle')
,(4, 'Marwan'   )
,(5, 'Khaled'   );

Create table Orders (order_id int, 
                     order_date date, 
                     customer_id int, 
                     product_id int);
Truncate table Orders;
insert into Orders (order_id, order_date, customer_id, product_id) values
 ( 1, '2024-07-31', 1, 1)
,( 2, '2024-07-30', 2, 2)
,( 3, '2024-08-29', 3, 3)
,( 4, '2024-07-29', 4, 1)
,( 5, '2024-06-10', 1, 2)
,( 6, '2024-08-01', 2, 1)
,( 7, '2024-08-01', 3, 1)
,( 8, '2024-08-03', 1, 2)
,( 9, '2024-08-07', 2, 3)
,(10, '2024-07-15', 1, 2);

Create table Products (product_id int, 
                       product_name varchar(20), 
                       price int);
Truncate table Products;
insert into Products (product_id, product_name, price) values 
 (1, 'keyboard' , 120)
,(2, 'mouse'    ,  80)
,(3, 'screen'   , 600)
,(4, 'hard disk', 450);

/*
+--------------+------------+----------+------------+
| product_name | product_id | order_id | order_date |
+--------------+------------+----------+------------+
| keyboard     | 1          | 6        | 2020-08-01 |
| keyboard     | 1          | 7        | 2020-08-01 |
| mouse        | 2          | 8        | 2020-08-03 |
| screen       | 3          | 3        | 2020-08-29 |
+--------------+------------+----------+------------+
*/

-- Approach 1: Using CTE table 
with raw_data as (
select product_id, max(order_date) as order_date 
       from Orders group by 1)
select p.product_name,
       o.product_id,
       o.order_id,
       o.order_date
       from Orders o 
 inner join raw_data r 
         on r.product_id = o.product_id 
        and r.order_date = o.order_date 
 inner join Products p 
         on p.product_id = o.product_id 
   order by 1,2,3;

-- Approach 2: Using Subquery Table
select p.product_name,
       o.product_id,
       o.order_id,
       o.order_date
       from Orders o 
 inner join (select product_id, max(order_date) as order_date 
                    from Orders group by 1) r 
         on r.product_id = o.product_id 
        and r.order_date = o.order_date 
 inner join Products p 
         on p.product_id = o.product_id 
   order by 1,2,3;

-- Approach 3: Using Correlated Qubquery table
select p.product_name,
       o.product_id,
       o.order_id,
       o.order_date
       from Orders o 
 inner join Products p 
         on p.product_id = o.product_id 
        and o.order_date  = (select max(order_date) as order_date 
                                    from Orders oo 
                                   where oo.product_id = o.product_id )
   order by 1,2,3;

-- Approach 4: Using concatenated values
select p.product_name,
       o.product_id,
       o.order_id,
       o.order_date
       from Orders o 
 inner join Products p 
         on p.product_id = o.product_id 
        and (o.product_id, o.order_date) in  (select oo.product_id, 
                                                     max(order_date) as order_date 
                                                     from Orders oo 
                                                 group by 1)
   order by 1,2,3;

-- Approach 5: Using WINDOWS function
with raw_data as (
select p.product_name,
       o.product_id,
       o.order_id,
       o.order_date,
       rank() over(partition by o.product_id order by order_date desc) as rnum
       from Orders o 
 inner join Products p 
         on p.product_id = o.product_id )
select o.product_name,
       o.product_id,
       o.order_id,
       o.order_date
       from raw_data o
      where rnum = 1 
   order by 1,2,3;
