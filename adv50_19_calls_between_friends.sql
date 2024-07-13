-- Question: report the number of calls and the total call duration between friends

-- English Video: 
-- Tamil Video: 

Create table Calls (from_id int, 
                    to_id int, 
                    duration int);
Truncate table Calls;
insert into Calls (from_id, to_id, duration) values 
 (1, 2,  59)
,(2, 1,  11)
,(1, 3,  20)
,(3, 4, 100)
,(3, 4, 200)
,(3, 4, 200)
,(4, 3, 499);

/*
+---------+---------+------------+----------------+
| person1 | person2 | call_count | total_duration |
+---------+---------+------------+----------------+
| 1       | 2       | 2          | 70             |
| 1       | 3       | 1          | 20             |
| 3       | 4       | 4          | 999            |
+---------+---------+------------+----------------+
*/

with all_raw_data as (
select from_id,
       to_id,
       duration
       from Calls 
      where from_id < to_id 
union all 
select to_id,
       from_id,
       duration
       from Calls 
      where to_id < from_id )
select from_id,
       to_id,
       count(*) as call_count,
       sum(duration) as total_duration 
       from all_raw_data 
   group by 1,2; 
