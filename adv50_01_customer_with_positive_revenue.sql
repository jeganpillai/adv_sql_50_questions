-- Question: Find Customers With Positive Revenue for this year 

-- English Video: https://www.youtube.com/watch?v=WD7ktK5Vmo8
-- Tamil Video: https://www.youtube.com/watch?v=UlmlRKJl9ko

Create table Customers (customer_id int, year int, revenue int);
Truncate table Customers;
insert into Customers (customer_id, year, revenue) values 
 (1, 2022,  50)
,(1, 2023,  70)
,(1, 2024,  30)
,(2, 2024, -50)
,(3, 2021,  50)
,(3, 2023,  10)
,(4, 2024,  20);

-- Approach 1: Basic Select statement with WHERE clause 
select customer_id 
       from Customers 
      where year = 2024
        and revenue > 0
   order by 1;
