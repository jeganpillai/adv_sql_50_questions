-- Question: Find the difference between the number of apples and oranges sold each day

-- English Video: 
-- Tamil Video: 

Create table Sales (sale_date date, fruit varchar(50), sold_num int);
Truncate table Sales;
insert into Sales (sale_date, fruit, sold_num) values 
 ('2024-07-01', 'apples' , 10)
,('2024-07-01', 'oranges',  8)
,('2024-07-02', 'apples' , 15)
,('2024-07-02', 'oranges', 15)
,('2024-07-03', 'apples' , 20)
,('2024-07-03', 'oranges',  0)
,('2024-07-04', 'apples' , 15)
,('2024-07-04', 'oranges', 16);

/*
+------------+--------------+
| sale_date  | diff         |
+------------+--------------+
| 2024-07-01 | 2            |
| 2024-07-02 | 0            |
| 2024-07-03 | 20           |
| 2024-07-04 | -1           |
+------------+--------------+
*/

-- Approach 1: Case statement using SUM function
select sale_date,
       sum(case when fruit = 'apples' then sold_num else 0 end) as apple_sale,
       sum(case when fruit = 'oranges' then sold_num else 0 end) as orange_sale
from Sales 
group by 1 order by 1;

-- Approach 2: Case statement using MAX function
select sale_date,
       max(case when fruit = 'apples' then sold_num else 0 end) - 
       max(case when fruit = 'oranges' then sold_num else 0 end) as diff
from Sales 
group by 1 order by 1;

