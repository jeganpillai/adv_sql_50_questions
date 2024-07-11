-- Question: Find total time spent by each employee in office

-- English Video: https://www.youtube.com/watch?v=ExoNWE0ZNJA
-- Tamil Video: https://www.youtube.com/watch?v=95FJEHy5A-w 

Create table Employees(emp_id int, 
                       event_day date, 
                       in_time int, 
                       out_time int);
Truncate table Employees;
insert into Employees (emp_id, event_day, in_time, out_time) values 
 (1, '2024-06-28',  4,  32)
,(1, '2024-06-28', 55, 200)
,(1, '2024-07-03',  1,  42)
,(2, '2024-06-28',  3,  33)
,(2, '2024-07-09', 47,  74);

/*
+------------+--------+------------+
| day        | emp_id | total_time |
+------------+--------+------------+
| 2024-06-28 | 1      | 173        |
| 2024-06-28 | 2      | 30         |
| 2024-07-03 | 1      | 41         |
| 2024-07-09 | 2      | 27         |
+------------+--------+------------+
*/

-- Basic Aggregate Function
select event_day as day,
       emp_id,
       sum(out_time - in_time) as total_time 
from Employees 
group by 1,2 order by 1,2;
