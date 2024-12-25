-- Question: Find the Continuous interval of Days in a given period

-- English Video: 
-- Tamil Video: 

Create table Failed (fail_date date);
Truncate table Failed;
insert into Failed (fail_date) values 
('2023-12-28'),
('2023-12-29'),
('2024-01-04'),
('2024-01-05');

Create table Succeeded (success_date date);
Truncate table Succeeded;
insert into Succeeded (success_date) values 
('2023-12-30'),
('2023-12-31'),
('2024-01-01'),
('2024-01-02'),
('2024-01-03'),
('2024-01-06');

/*
-- Expected Output
+--------------+--------------+--------------+
| period_state | start_date   | end_date     |
+--------------+--------------+--------------+
| succeeded    | 2024-01-01   | 2024-01-03   |
| failed       | 2024-01-04   | 2024-01-05   |
| succeeded    | 2024-01-06   | 2024-01-06   |
+--------------+--------------+--------------+
*/

-- Approach 1: Group the Data, Rank and Create Bucket then firnd the start and end date  
with raw_data as (
select 'Failed' as flg, fail_date as process_date 
       from Failed
      where fail_date between '2024-01-01' and '2024-12-31'
union all  
select 'Succeeded' as flg, success_date as process_date 
       from Succeeded
      where success_date between '2024-01-01' and '2024-12-31') 
,sorting_dataset as (
select flg, process_date,
       row_number() over(partition by flg order by process_date) as rnum
       from raw_data )
,bucketed_dataset as (
select flg, process_date, rnum,
       date_add(process_date, interval -rnum day) as bucket 
       from sorting_dataset)
select flg, min(process_date) as start_date,
       max(process_date) as end_date 
       from bucketed_dataset
   group by flg, bucket
   order by 2 ;

-- Approach 2: Combine the Rank and Bucketing in one step 
with raw_data as (
select 'failed' as period_state, fail_date as process_date 
       from Failed
      where fail_date between '2019-01-01' and '2019-12-31'
union all  
select 'succeeded' as period_state, success_date as process_date 
       from Succeeded
      where success_date between '2019-01-01' and '2019-12-31') 
,bucketed_dataset as (
select period_state, process_date,
       row_number() over(partition by period_state order by process_date) as rnum,
       date_add(process_date, interval - row_number() over(partition by period_state order by process_date) day) as bucket  
       from raw_data )
select period_state, min(process_date) as start_date,
       max(process_date) as end_date 
       from bucketed_dataset
   group by period_state, bucket
   order by 2 ;

-- Approach 3: Instead of UNION and then do the Rank, do it separate
with bucketed_dataset as (
select 'failed' as period_state, fail_date as process_date ,
       date_add(fail_date, interval - row_number() over(order by fail_date) day) as bucket
       from Failed
      where fail_date between '2019-01-01' and '2019-12-31'
union all  
select 'succeeded' as period_state, success_date as process_date,
       date_add(success_date, interval - row_number() over(order by success_date) day) as bucket 
       from Succeeded
      where success_date between '2019-01-01' and '2019-12-31')
 select period_state, min(process_date) as start_date,
       max(process_date) as end_date 
       from bucketed_dataset
   group by period_state, bucket
   order by 2 ; 
