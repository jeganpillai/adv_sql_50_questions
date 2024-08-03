-- Question: Find all the Consecutive Available Seats in a cinema

-- English Video: 
-- Tamil Video: 

Create table Cinema (seat_id int, free int);
Truncate table Cinema;
insert into Cinema (seat_id, free) values 
 (1, 1)
,(2, 0)
,(3, 1)
,(4, 1)
,(5, 1);

/*
+---------+
| seat_id |
+---------+
| 3       |
| 4       |
| 5       |
+---------+
*/

-- Approach 1: General Self Join
select distinct c1.seat_id
       from Cinema c1 
 inner join Cinema c2  
         on (c2.seat_id + 1 = c1.seat_id or c2.seat_id = c1.seat_id + 1 )
        and c1.free = c2.free
        and c2.free = 1
   order by 1;

-- Approach 2: Using ABS() function 
select distinct c1.seat_id
       from Cinema c1 
 inner join Cinema c2 
         on abs(c2.seat_id - c1.seat_id) = 1
        and c1.free = c2.free
        and c2.free = 1
   order by 1;

-- Approach 3: Using Windows Function 
with raw_data as (
select c1.seat_id,
       c1.free,
       coalesce(lead(c1.free) over(order by seat_id),0) as nxt,
       coalesce(lag(c1.free) over(order by seat_id),0) as prev
       from Cinema c1)
select seat_id 
       from raw_data  
      where free = 1 and nxt + prev > 0
   order by 1;

-- Additional data for practice
Truncate table Cinema;
insert into Cinema (seat_id, free) values 
 (1 , 0)
,(2 , 1)
,(3 , 0)
,(4 , 1)
,(5 , 1)
,(6 , 1)
,(7 , 0)
,(8 , 1)
,(9 , 1)
,(10, 0)
,(11, 0)
,(12, 1)
,(13, 1)
,(14, 0)
,(15, 1)
,(16, 0)
,(17, 0)
,(18, 1)
,(19, 0)
,(20, 0);

/*
+---------+
| seat_id |
+---------+
| 4       |
| 5       |
| 6       |
| 8       |
| 9       |
| 12      |
| 13      |
+---------+
*/
