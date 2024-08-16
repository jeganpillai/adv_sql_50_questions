-- Question: Find the accounts that should be banned from a platform if it was logged in at same moment from two different IP addresses.

-- English Video: https://www.youtube.com/watch?v=haU3SLA0pLM
-- Tamil Video: https://www.youtube.com/watch?v=LDE56ti1hu0

Create table LogInfo (account_id int, 
                      ip_address varchar(25), 
                      login datetime, 
                      logout datetime);
Truncate table LogInfo;
insert into LogInfo (account_id, ip_address, login, logout) values 
 (1, '10.0.0.0'   , '2024-08-01 09:00:00', '2024-08-01 09:30:00')
,(1, '172.16.0.0' , '2024-08-01 08:00:00', '2024-08-01 11:30:00')
,(2, '192.168.0.0', '2024-08-01 20:30:00', '2024-08-01 22:00:00')
,(2, '127.255.0.0', '2024-08-02 20:30:00', '2024-08-02 22:00:00')
,(3, '169.254.0.0', '2024-08-01 16:00:00', '2024-08-01 16:59:59')
,(3, '192.0.0.0'  , '2024-08-01 17:00:00', '2024-08-01 17:59:59')
,(4, '198.0.2.0'  , '2024-08-01 16:00:00', '2024-08-01 17:00:00')
,(4, '224.0.0.0'  , '2024-08-01 17:00:00', '2024-08-01 17:59:59');

/*
+------------+
| account_id |
+------------+
| 1          |
| 4          |
+------------+
*/

select l1.account_id 
       from LogInfo l1 
 inner join LogInfo l2 
         on l2.account_id = l1.account_id 
        and l2.ip_address <> l1.ip_address 
        and l2.login > l1.login
        and l2.login between l1.login and l1.logout; 
