-- Question: report the number of calls and the total call duration between friends

-- English Video: https://www.youtube.com/watch?v=JeSreeYusM8
-- Tamil Video: https://www.youtube.com/watch?v=SqC6gACgp14

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

-- Approach 1: Using UNION ALL 
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

-- Approach 2: Using CASE statement 
select case when from_id < to_id then from_id else to_id end as person1,
       case when from_id < to_id then to_id else from_id end as person2,
       count(*) as call_count,
       sum(duration) as total_duration
       from Calls 
   group by 1,2 ;

-- Approach 3: Using LEAST and GREATEST statement 
select least(from_id,to_id) as person1,
       greatest(from_id, to_id) as person2,
       count(*) as call_count,
       sum(duration) as total_duration
       from Calls 
   group by 1,2 ;
