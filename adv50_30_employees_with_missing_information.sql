-- Question: Report the Employees ID With Missing Information

-- English Video: https://www.youtube.com/watch?v=0VxCgRQ957c
-- Tamil Video: https://www.youtube.com/watch?v=VaMfj8cWma8

Create table Employees1 (employee_id int, name varchar(30));

Truncate table Employees1;
insert into Employees1 (employee_id, name) values 
 (2, 'Crew')
,(4, 'Haven')
,(5, 'Kristian');

Create table Salaries1 (employee_id int, salary int);
Truncate table Salaries1;
insert into Salaries1 (employee_id, salary) values 
 (5, 76071)
,(1, 22517)
,(4, 63539);

/*
+-------------+
| employee_id |
+-------------+
| 1           |
| 2           |
+-------------+
*/

-- SQL for databases supporting FULL JOIN (postgerSQL, Snowflake, Oracle, Teradata....) 
select coalesce(e.employee_id,s.employee_id) as employee_id,
       e.name,
       s.salary
       from Employees1 e 
  full join Salaries1 s 
         on s.employee_id = e.employee_id
      where e.name is null or s.salary is null  
   order by 1;

-- SQL for databases not supporting FULL JOIN (MySQL...)
select e.employee_id -- , e.name, s.salary 
       from Employees1 e 
  left join Salaries1 s 
         on s.employee_id = e.employee_id
      where s.salary is null or e.name is null 
union all 
select s.employee_id -- , e.name, s.salary 
       from Employees1 e 
 right join Salaries1 s 
         on s.employee_id = e.employee_id
      where s.salary is null or e.name is null
