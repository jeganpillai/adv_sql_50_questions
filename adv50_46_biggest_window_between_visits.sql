-- Question: Find the Biggest Window between Visits

-- English Video: 
-- Tamil Video: 

Create table UserVisits(user_id int, visit_date date);
Truncate table UserVisits;
insert into UserVisits (user_id, visit_date) values 
(1, '2024-10-20'),
(1, '2024-11-28'),
(1, '2024-12-03'),
(2, '2024-10-05'),
(2, '2024-12-09'),
(3, '2024-11-11');

-- Approach 1: Using Self Join 
with raw_data as (
select a.user_id,
       a.visit_date, 
       min(coalesce(b.visit_date, '2025-01-01')) as next_visit_date 
       from UserVisits a 
  left join UserVisits b 
         on b.user_id = a.user_id 
        and b.visit_date > a.visit_date 
   group by 1,2 )
select a.user_id,  
       max(datediff(a.next_visit_date, a.visit_date)) as diff_window 
       from raw_data a 
   group by 1 ;

-- Approach 2: Using Windows Function 
with raw_data as (
select a.user_id,
       a.visit_date, 
       coalesce(lead(a.visit_date) over(partition by a.user_id order by a.user_id, a.visit_date), '2025-01-01') as next_visit_date ,
       datediff(coalesce(lead(a.visit_date) over(partition by a.user_id order by a.user_id, a.visit_date), '2025-01-01') , a.visit_date) as diff 
       from UserVisits a)
 select a.user_id,
        max(a.diff) as biggest_window
        from raw_data a 
    group by 1 ;

-- or 

with raw_data as (
select a.user_id,
       a.visit_date, 
       coalesce(lead(a.visit_date) over(partition by a.user_id order by a.user_id, a.visit_date), '2025-01-01') as next_visit_date
       from UserVisits a)
 select a.user_id,
        max(datediff(a.next_visit_date, a.visit_date)) as biggest_window
        from raw_data a 
    group by 1 ;
