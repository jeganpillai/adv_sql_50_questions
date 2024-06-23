-- Question: Calculate the bonus of each employee

-- English Video: https://www.youtube.com/watch?v=LcrfxmTffMo
-- Tamil Video: https://www.youtube.com/watch?v=M56ZK0bqoAE
 

Create table Employees (employee_id int, name varchar(30), salary int);
Truncate table Employees;
insert into Employees (employee_id, name, salary) values 
 (2, 'Meir'   , 3000)
,(3, 'Michael', 3800)
,(7, 'Addilyn', 7400)
,(8, 'Juan'   , 6100)
,(9, 'Kannon' , 7700);

/*
+-------------+-------+
| employee_id | bonus |
+-------------+-------+
| 2           | 0     |
| 3           | 0     |
| 7           | 7400  |
| 8           | 0     |
| 9           | 7700  |
+-------------+-------+
*/

-- *** Approach 1: Brute force method *** 
select employee_id,
       salary as bonus 
       from Employees 
      where employee_id%2 = 1 
        and substr(name,1,1) <> 'M'
union all 
select employee_id,
       0 as bonus 
       from Employees 
      where employee_id%2 <> 1 
         or substr(name,1,1) = 'M'
order by 1;

-- *** Approach 2: Using CASE statement *** 
select employee_id,
       case when employee_id%2 = 1 and substr(name,1,1) <> 'M' then salary else 0 end as bonus 
       from Employees 
order by 1;
