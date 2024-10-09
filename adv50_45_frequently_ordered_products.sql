-- Question: Find the Frequently Ordered Products for each customer

-- English Video: 
-- Tamil Video: 

Create table If Not Exists Customers (customer_id int, name varchar(10));
Truncate table Customers;
insert into Customers (customer_id, name) values 
 (1, 'Alice')
,(2, 'Bob')
,(3, 'Tom')
,(4, 'Jerry')
,(5, 'John');

Create table If Not Exists Orders (order_id int, 
                                   order_date date, 
                                   customer_id int, 
                                   product_id int);
Truncate table Orders;
insert into Orders (order_id, order_date, customer_id, product_id) values 
 ( 1, '2020-07-31', 1, 1)
,( 2, '2020-07-30', 2, 2)
,( 3, '2020-08-29', 3, 3)
,( 4, '2020-07-29', 4, 1)
,( 5, '2020-06-10', 1, 2)
,( 6, '2020-08-01', 2, 1)
,( 7, '2020-08-01', 3, 3)
,( 8, '2020-08-03', 1, 2)
,( 9, '2020-08-07', 2, 3)
,(10, '2020-07-15', 1, 2);


Create table If Not Exists Products (product_id int, 
                                     product_name varchar(20), 
                                     price int);
Truncate table Products;
insert into Products (product_id, product_name, price) values 
 (1, 'keyboard' , 120)
,(2, 'mouse'    ,  80)
,(3, 'screen'   , 600)
,(4, 'hard disk', 450);

/*
+-------------+------------+--------------+
| customer_id | product_id | product_name |
+-------------+------------+--------------+
| 1           | 2          | mouse        |
| 2           | 1          | keyboard     |
| 2           | 2          | mouse        |
| 2           | 3          | screen       |
| 3           | 3          | screen       |
| 4           | 1          | keyboard     |
+-------------+------------+--------------+
*/

-- Approach 1: CTE logic 
with overall_purchase as (
select distinct customer_id, product_id, 
       count(*) as cnt
       from Orders o 
   group by 1, 2)
,max_purchase as (
select customer_id, max(cnt) as max_cnt 
       from overall_purchase
   group by 1 )
select o.customer_id, o.product_id,
       p.product_name
       from overall_purchase o 
 inner join max_purchase m 
         on m.customer_id = o.customer_id
        and m.max_cnt = o.cnt 
 inner join Products p 
         on p.product_id = o.product_id
   order by 1,2;


-- Approach 2: Concat subquery 
with overall_purchase as (
select distinct customer_id, product_id, 
       count(*) as cnt
       from Orders o 
   group by 1, 2)
select o.customer_id, o.product_id, p.product_name
       from overall_purchase o 
 inner join Products p
         on p.product_id = o.product_id 
      where (customer_id, cnt) in (select customer_id, max(cnt) as cnt from overall_purchase group by 1);

-- Approach 3: Correlated Subquery 
with overall_purchase as (
select distinct customer_id, product_id, 
       count(*) as cnt
       from Orders o 
   group by 1, 2)
select o.customer_id, o.product_id, p.product_name
       from overall_purchase o 
 inner join Products p
         on p.product_id = o.product_id
         and o.cnt = (select max(oo.cnt) as cnt 
                             from overall_purchase oo 
                             where oo.customer_id = o.customer_id)
      order by 1,2 ;

-- Approach 4: Using Windows Function 
with overall_purchase as (
select distinct customer_id, product_id, 
       count(*) over(partition by customer_id, product_id) as cnt
       from Orders o )
,filter_data as (
select customer_id, product_id, cnt,
       dense_rank() over(partition by customer_id order by cnt desc) as chk
       from overall_purchase)
select f.customer_id, f.product_id, p.product_name
       from filter_data f 
 inner join Products p
         on p.product_id = f.product_id
      where chk = 1 ;
