-- Question: Find the most recent three orders of each user

-- English Video: 
-- Tamil Video:

Create table Customers (customer_id int, name varchar(10));
Truncate table Customers;
insert into Customers (customer_id, name) values 
 (1, 'Winston'  )
,(2, 'Jonathan' )
,(3, 'Annabelle')
,(4, 'Marwan'   )
,(5, 'Khaled'   );

Create table Orders (order_id int, order_date date, customer_id int, cost int);
Truncate table Orders;
insert into Orders (order_id, order_date, customer_id, cost) values 
 ( 1, '2020-07-31', 1,   30)
,( 2, '2020-07-30', 2,   40)
,( 3, '2020-07-31', 3,   70)
,( 4, '2020-07-29', 4,  100)
,( 5, '2020-06-10', 1, 1010)
,( 6, '2020-08-01', 2,  102)
,( 7, '2020-08-01', 3,  111)
,( 8, '2020-08-03', 1,   99)
,( 9, '2020-08-07', 2,   32)
,(10, '2020-07-15', 1,    2);

/*
+---------------+-------------+----------+------------+
| customer_name | customer_id | order_id | order_date |
+---------------+-------------+----------+------------+
| Annabelle     | 3           | 7        | 2020-08-01 |
| Annabelle     | 3           | 3        | 2020-07-31 |
| Jonathan      | 2           | 9        | 2020-08-07 |
| Jonathan      | 2           | 6        | 2020-08-01 |
| Jonathan      | 2           | 2        | 2020-07-30 |
| Marwan        | 4           | 4        | 2020-07-29 |
| Winston       | 1           | 8        | 2020-08-03 |
| Winston       | 1           | 1        | 2020-07-31 |
| Winston       | 1           | 10       | 2020-07-15 |
+---------------+-------------+----------+------------+
*/

-- Approach 1: Using Correlated Subquery
select c.name as customer_name, 
       o.customer_id, 
       o.order_id, 
       o.order_date
       from Orders o
 inner join Customers c 
         on c.customer_id = o.customer_id 
      where 3 >= (select count(*) 
                         from Orders oo 
                        where oo.customer_id = o.customer_id 
                          and oo.order_date >= o.order_date)
order by 1,2,4 desc;

-- Approach 2: Using WINDOWS function 
with raw_data as (
select o.customer_id, 
       o.order_id, 
       o.order_date,
       rank() over(partition by o.customer_id 
                   order by o.order_date desc) as rnk
       from Orders o )
select c.name as customer_name, r.customer_id, r.order_id, r.order_date
       from raw_data r 
 inner join Customers c 
         on c.customer_id = r.customer_id 
      where rnk <= 3;
