-- Question: Find Customers who bought Product A and B but not C

-- English Video: https://www.youtube.com/watch?v=WRXN6QUA9hM
-- Tamil Video: https://www.youtube.com/watch?v=cToVFVkr2Fg


Create table Customers (customer_id int, customer_name varchar(30));
Truncate table Customers;
insert into Customers (customer_id, customer_name) values 
 (1, 'Daniel'   )
,(2, 'Diana'    )
,(3, 'Elizabeth')
,(4, 'Jhon'     );

Create table Orders (order_id int, customer_id int, product_name varchar(30));
Truncate table Orders;
insert into Orders (order_id, customer_id, product_name) values 
 (10, 1, 'A')
,(20, 1, 'B')
,(30, 1, 'D')
,(40, 1, 'C')
,(50, 2, 'A')
,(60, 3, 'A')
,(70, 3, 'B')
,(80, 3, 'D')
,(90, 4, 'C');

/* 
Expected Output 

+-------------+---------------+
| customer_id | customer_name |
+-------------+---------------+
| 3           | Elizabeth     |
+-------------+---------------+

*/
-- Approach 1: Using Brute Force Method
select distinct c.customer_id, c.customer_name
      from Customers c
inner join Orders oa 
        on oa.customer_id = c.customer_id and oa.product_name = 'A' 
inner join Orders ob 
        on ob.customer_id = c.customer_id and ob.product_name = 'B'
 left join Orders oc 
        on oc.customer_id = c.customer_id and oc.product_name = 'C'
     where oc.customer_id is null 
  order by 1;

-- Approach 2: Basic filter with Sub Query
select o.customer_id, c.customer_name
       from Orders o
 inner join Customers c 
         on c.customer_id = o.customer_id
      where o.product_name in ('A','B')
        and o.customer_id not in (select customer_id 
                                         from Orders 
                                        where product_name = 'C')
   group by 1,2 having count(distinct o.product_name) = 2
  order by 1;

-- Approah 3: Simple Arithmatic Approach 
select o.customer_id, c.customer_name
       from Orders o
 inner join Customers c 
         on c.customer_id = o.customer_id
      where o.product_name in ('A','B','C')
   group by 1,2
   having sum(distinct case when product_name = 'A' then 1
            when product_name = 'B' then 2
            when product_name = 'C' then -1 end) = 3
order by 1;
