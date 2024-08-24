-- Question: Report the transaction IDs with the maximum amount on their respective day

-- English Video: 
-- Tamil Video: 

Create table Transactions (transaction_id int, day datetime, amount int);
Truncate table Transactions;
insert into Transactions (transaction_id, day, amount) values 
 (8, '2024-04-03 15:57:28', 57)
,(9, '2024-04-28 08:47:25', 21)
,(1, '2024-04-29 13:28:30', 58)
,(5, '2024-04-28 16:39:59', 40)
,(6, '2024-04-29 23:39:28', 58);

/*
+----------------+
| transaction_id |
+----------------+
| 1              |
| 5              |
| 6              |
| 8              |
+----------------+
*/

-- Approach 1: Using CTE logic 
with raw_data as (
select date(day) as day, max(amount) as amount 
       from Transactions t 
   group by 1)
select distinct t.transaction_id
       from Transactions t 
 inner join raw_data r 
         on date(r.day) = date(t.day) 
        and r.amount = t.amount 
   order by 1 ;

-- Approach 2: Using Siubquery table
select distinct t.transaction_id
       from Transactions t 
 inner join (select date(day) as day, max(amount) as amount 
                    from Transactions t 
                group by 1) r 
         on date(r.day) = date(t.day) 
        and r.amount = t.amount 
   order by 1 ;

-- Apprach 3: Using Correlated Subquery 
select distinct t.transaction_id
       from Transactions t 
      where t.amount = (select max(tt.amount) as amount 
                    from Transactions tt
                    where date(tt.day) = date(t.day))
   order by 1 ;

-- Approach 4: Using Concatenation of strings
select distinct t.transaction_id
       from Transactions t 
      where (date(day), t.amount) in (select date(day) as day, max(amount) as amount 
                                             from Transactions t 
                                         group by 1)
   order by 1 ;

-- Approach 5: Using Windows function 
with raw_data as (
select transaction_id, day, amount,
       dense_rank() over(partition by date(day) order by amount desc) as rnk 
       from Transactions t )
select transaction_id from raw_data where rnk = 1 order by 1;
