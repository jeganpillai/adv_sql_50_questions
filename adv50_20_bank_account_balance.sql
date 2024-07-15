-- Question: Report the name and balance of users with a balance higher than $10000

-- English Video: https://www.youtube.com/watch?v=mps3VPdRZuU
-- Tamil Video: https://www.youtube.com/watch?v=A6cWqWa1wjs

create table Users (account int, name varchar(20));
Truncate table Users;
insert into Users (account, name) values 
 (900001, 'Alice')
,(900002, 'Bob')
,(900003, 'Charlie');

Create table Transactions (trans_id int, 
                           account int, 
                           amount int, 
                           transacted_on date);
Truncate table Transactions;
insert into Transactions (trans_id, account, amount, transacted_on) values
 (1, 900001,  7000, '2020-08-01')
,(2, 900001,  7000, '2020-09-01')
,(3, 900001, -3000, '2020-09-02')
,(4, 900002,  1000, '2020-09-12')
,(5, 900003,  6000, '2020-08-07')
,(6, 900003,  6000, '2020-09-07')
,(7, 900003, -4000, '2020-09-11');

/*
+------------+------------+
| name       | balance    |
+------------+------------+
| Alice      | 11000      |
+------------+------------+
*/

select u.name,
       sum(t.amount) as balance
       from Users u 
 inner join Transactions t 
         on t.account = u.account 
   group by 1 
     having sum(t.amount) > 10000;
