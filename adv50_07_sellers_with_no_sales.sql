-- Question: Find the Sellers With No Sales

-- English Video: 
-- Tamil Video: 

Create table Customer (
  customer_id int, 
  customer_name varchar(20));
Truncate table Customer;
insert into Customer (customer_id, customer_name) values 
 (101, 'Alice'  )
,(102, 'Bob'    )
,(103, 'Charlie');

Create table Orders (
  order_id int, 
  sale_date date, 
  order_cost int, 
  customer_id int, 
  seller_id int);
Truncate table Orders;
insert into Orders (order_id, sale_date, order_cost, customer_id, seller_id) values 
 (1, '2024-03-01', 1500, 101, 1)
,(2, '2024-05-25', 2400, 102, 2)
,(3, '2023-05-25',  800, 101, 3)
,(4, '2024-09-13', 1000, 103, 2)
,(5, '2023-02-11',  700, 101, 2);

Create table Seller (
  seller_id int, 
  seller_name varchar(20));
Truncate table Seller;
insert into Seller (seller_id, seller_name) values 
 (1, 'Daniel'   )
,(2, 'Elizabeth')
,(3, 'Frank'    );

/*
+-------------+
| seller_name |
+-------------+
| Frank       |
+-------------+
*/
select distinct s.seller_name
       from Seller s 
  left join Orders o 
         on o.seller_id = s.seller_id 
--        and sale_date between '2020-01-01' and '2020-12-31'
--        and year(sale_date) = 2024
        and left(sale_date,4) = 2024 
      where o.seller_id is null 
   order by 1;
