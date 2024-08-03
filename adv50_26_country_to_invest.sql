-- Question: Find the countries where Telecom companies can invest based on call duration

-- English Video: https://www.youtube.com/watch?v=DlI0TQKjwG4
-- Tamil Video: https://www.youtube.com/watch?v=6n5nMArDdY0 

Create table Person (id int, 
                     name varchar(15), 
                     phone_number varchar(11));
Truncate table Person;
insert into Person (id, name, phone_number) values 
 ( 3, 'Jonathan', '051-1234567')
,(12, 'Elvis'   , '051-7654321')
,( 1, 'Moncef'  , '212-1234567')
,( 2, 'Maroua'  , '212-6523651')
,( 7, 'Meir'    , '972-1234567')
,( 9, 'Rachel'  , '972-0011100');

Create table Country (name varchar(15), 
                      country_code varchar(3));
Truncate table Country;
insert into Country (name, country_code) values 
 ('Peru'    , '051')
,('Israel'  , '972')
,('Morocco' , '212')
,('Germany' , '049')
,('Ethiopia', '251'); 


Create table Calls (caller_id int, 
                    callee_id int, 
                    duration int);
Truncate table Calls;
insert into Calls (caller_id, callee_id, duration) values 
 ( 1,  9,  33)
,( 2,  9,   4)
,( 1,  2,  59)
,( 3, 12, 102)
,( 3, 12, 330)
,(12,  3,   5)
,( 7,  9,  13)
,( 7,  1,   3)
,( 9,  7,   1)
,( 1,  7,   7);

/*
+----------+
| country  |
+----------+
| Peru     |
+----------+
*/
  
-- How to join tables 
with all_calls as (
select caller_id as id, duration from Calls 
union all 
select callee_id as id, duration from Calls )
select a.id, 
       p.name, p.phone_number,
       left(p.phone_number,3) as cntry_code,
       c.name as country, 
       sum(duration) as duration 
       from all_calls a 
 inner join Person p 
         on p.id = a.id 
 inner join Country c 
         on c.country_code = left(p.phone_number,3)
   group by 1,2,3,4,5;

-- Find the average duration 
with all_calls as (
select caller_id as id, duration from Calls 
union all 
select callee_id as id, duration from Calls )
select c.name as country, 
       avg(duration) as avg_duration 
       from all_calls a 
 inner join Person p 
         on p.id = a.id 
 inner join Country c 
         on c.country_code = left(p.phone_number,3)
   group by 1;

-- Approach 1: Using CTE option 
with all_calls as (
select caller_id as id, duration from Calls 
union all 
select callee_id as id, duration from Calls )
select c.name as country
       from all_calls a 
 inner join Person p 
         on p.id = a.id 
 inner join Country c 
         on c.country_code = left(p.phone_number,3)
   group by 1 
     having avg(a.duration) > (select avg(duration) from all_calls);

-- Approach 2: Using Windows Function 
with all_calls as (
select caller_id as id, duration from Calls 
union all 
select callee_id as id, duration from Calls )
,average_duration_check as (
select c.name as country,
       avg(duration) over() as overall_avg,
       avg(duration) over(partition by c.name) as cntry_avg
       from all_calls a 
 inner join Person p 
         on p.id = a.id 
 inner join Country c 
         on c.country_code = left(p.phone_number,3) )
select distinct country 
       from average_duration_check
      where cntry_avg > overall_avg;
