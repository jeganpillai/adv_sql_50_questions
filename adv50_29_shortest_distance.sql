-- Question: Find the shortest distance between any two points

-- English Video: 
-- Tamil Video: 

Create Table Point (x int not null);
Truncate table Point;
insert into Point (x) values 
 (-1)
,( 0)
,( 2);

/*
+----------+
| shortest |
+----------+
| 1        |
+----------+
*/

-- Approach 1: Using Self Join
select p1.x,
       p2.x,
       abs(p1.x - p2.x) diff 
       from Point p1
 inner join Point p2 
         on p1.x > p2.x;

-- Approach 2: Using Windows Function 
with all_data as (
select p1.x,
       coalesce(lead(p1.x) over(order by p1.x),
       lag(p1.x) over(order by p1.x)) as x0 
       from Point p1)
select min(abs(x-x0)) as shortest from all_data         
