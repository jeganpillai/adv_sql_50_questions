Create table If Not Exists Logs (log_id int);
Truncate table Logs;
insert into Logs (log_id) values 
 ( 1)
,( 2)
,( 3)
,( 7)
,( 8)
,(10);

/*
+------------+--------------+
| start_id   | end_id       |
+------------+--------------+
| 1          | 3            |
| 7          | 8            |
| 10         | 10           |
+------------+--------------+
*/


--Approach 1: Using Windows function in CTE format
with initial_setup as (
select log_id, 
       row_number() over(order by log_id) as rnum 
       from Logs )
,bucketing as (
select log_id,
       rnum,
       log_id - rnum as bucket 
       from initial_setup)
select min(log_id) as start_id,
       max(log_id) as end_id 
       from bucketing 
       group by bucket;

--Approach 1: Using Windows function in Subquery format
select min(log_id) as start_id,
       max(log_id) as end_id 
       from (select log_id,
                    rnum,
                    log_id - rnum as bucket 
                    from (select log_id, 
                                  row_number() over(order by log_id) as rnum 
                                  from Logs) a )b 
  group by bucket;
