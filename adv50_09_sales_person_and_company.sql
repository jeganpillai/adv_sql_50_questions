-- Question: Find the Sales Person who never got Order for the Company RED

-- English Video: 
-- Tamil Video: 

Create table SalesPerson (sales_id int, 
                          name varchar(255), 
                          salary int, 
                          commission_rate int, 
                          hire_date date);
Truncate table SalesPerson;
insert into SalesPerson (sales_id, name, salary, commission_rate, hire_date) values
 (101, 'John', 100000,  6, '2023-04-01')
,(102, 'Amy' ,  12000,  5, '2020-05-01')
,(103, 'Mark',  65000, 12, '2023-12-25')
,(104, 'Pam' ,  25000, 25, '2021-01-01')
,(105, 'Alex',   5000, 10, '2024-02-03');

Create table Company (com_id int, 
                      name varchar(255), 
                      city varchar(255));
Truncate table Company;
insert into Company (com_id, name, city) values 
 (501, 'RED'   , 'Boston'  )
,(502, 'ORANGE', 'New York')
,(503, 'YELLOW', 'Boston'  )
,(504, 'GREEN' , 'Austin'  );

Create table If Not Exists Orders (order_id int, 
                                   order_date date, 
                                   com_id int, 
                                   sales_id int, 
                                   amount int);
Truncate table Orders;
insert into Orders (order_id, order_date, com_id, sales_id, amount) values 
 (1, '2024-06-04', 503, 104, 10000)
,(2, '2024-06-21', 504, 105,  5000)
,(3, '2024-06-06', 501, 101, 50000)
,(4, '2024-06-11', 501, 104, 25000);

/*
+------+
| name |
+------+
| Amy  |
| Mark |
| Alex |
+------+
*/

-- Approach 1: Using NOT IN Clause 
select s.name 
       from SalesPerson s 
      where sales_id not in (select distinct sales_id
                                    from Orders o 
                              inner join Company c 
                                      on c.com_id = o.com_id 
                                     and c.name = 'RED');

-- Approach 2: Using CTE table 
with exception_sales_id as (
select distinct sales_id
       from Orders o 
 inner join Company c 
         on c.com_id = o.com_id 
        and c.name = 'RED')
select s.name 
       from SalesPerson s 
  left join exception_sales_id e 
         on e.sales_id = s.sales_id 
      where e.sales_id is null;
