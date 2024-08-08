-- Question: Rearrange the Products table so that each row has (product_id, store, price)

-- English Video: https://www.youtube.com/watch?v=HrR_V_RT9c8
-- Tamil Video: https://www.youtube.com/watch?v=7WFY872iqCc

Create table Products (product_id int, store1 int, store2 int, store3 int);
Truncate table Products;
insert into Products (product_id, store1, store2, store3) values 
 (0, 95, 100 , 105)
,(1, 70, Null, 80 );

/*
+------------+--------+-------+
| product_id | store  | price |
+------------+--------+-------+
| 0          | store1 | 95    |
| 0          | store2 | 100   |
| 0          | store3 | 105   |
| 1          | store1 | 70    |
| 1          | store3 | 80    |
+------------+--------+-------+
*/

select product_id,
       'store1' as store,
       store1 as price
from Products 
where store1 is not null 
union all 
select product_id,
       'store2' as store,
       store2 as price
from Products 
where store2 is not null 
union all 
select product_id,
       'store3' as store,
       store3 as price
from Products 
where store3 is not null 

-- SQL for MS SQL Server 
select product_id, store, price 
      from products 
   unpivot (price for store in (store1, store2, store3))a
