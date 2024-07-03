-- Question: Find the Latest Login of all users in 2024

-- English Video: https://www.youtube.com/watch?v=9yQvd6n2m_w
-- Tamil Video: https://www.youtube.com/watch?v=Xpn4-LPOkno

Create table Logins (user_id int, time_stamp datetime);
Truncate table Logins;
insert into Logins (user_id, time_stamp) values 
 ( 6, '2024-06-30 15:06:07')
,( 6, '2023-04-21 14:06:06')
,( 6, '2023-03-07 00:18:15')
,( 8, '2024-02-01 05:10:53')
,( 8, '2024-12-30 00:46:50')
,( 2, '2024-01-16 02:49:50')
,( 2, '2023-08-25 07:59:08')
,(14, '2023-07-14 09:00:00')
,(14, '2023-01-06 11:59:59');

/*
+---------+---------------------+
| user_id | last_stamp          |
+---------+---------------------+
| 6       | 2024-06-30 15:06:07 |
| 8       | 2024-12-30 00:46:50 |
| 2       | 2024-01-16 02:49:50 |
+---------+---------------------+
*/

-- Approach 1: General Select statement
select user_id, max(time_stamp) as last_stamp
       from Logins 
      where year(time_stamp) = 2024
   group by 1;

-- Approach 2: Using Windows function 
with all_data as (
select user_id, 
       time_stamp,
       row_number() over(partition by user_id order by time_stamp desc) as rnk
       from Logins 
      where year(time_stamp) = 2024)
select user_id, time_stamp as last_stamp 
       from all_data 
      where rnk = 1;
