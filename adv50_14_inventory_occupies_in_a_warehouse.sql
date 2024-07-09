-- Question: Find the cubic feet of volume the inventory occupies in each warehouse

-- English Video: https://www.youtube.com/watch?v=XGuHTXQ7FB8
-- Tamil Video: https://www.youtube.com/watch?v=V9xzUUcGKNU

Create table Warehouse (name varchar(50), product_id int, units int);
Truncate table Warehouse;
insert into Warehouse (name, product_id, units) values 
 ('GWD_house_1', 1,  1)
,('GWD_house_1', 2, 10)
,('GWD_house_1', 3,  5)
,('GWD_house_2', 1,  2)
,('GWD_house_2', 2,  2)
,('GWD_house_3', 4,  1);

Create table Products (product_id int, 
                       product_name varchar(50), 
                       Width int,
                       Length int,
                       Height int);
Truncate table Products;
insert into Products (product_id, product_name, Width, Length, Height) values 
 (1, 'TV'      , 5, 50, 40)
,(2, 'KeyChain', 5,  5,  5)
,(3, 'Phone'   , 2, 10, 10)
,(4, 'T-Shirt' , 4, 10, 20);

/*
+-------------------+------------+
| warehouse_name    | volume     | 
+-------------------+------------+
| GWD_house_1       | 12250      | 
| GWD_house_2       | 20250      |
| GWD_house_3       | 800        |
+-------------------+------------+
*/

select w.name as warehouse_name, 
       sum(p.width * p.length * p.height * w.units) as volume
       from Warehouse w 
 inner join Products p 
         on p.product_id = w.product_id 
   group by 1 order by 1;
