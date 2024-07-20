-- Question: For each day and make, find the distinct leads and partners the cars are sold to. 

-- English Video: 
-- Tamil Video:

Create table DailySales(date_id date, 
                        make_name varchar(20), 
                        lead_id int, 
                        partner_id int);
Truncate table DailySales;
insert into DailySales (date_id, make_name, lead_id, partner_id) values
 ('2020-12-8', 'toyota', 0, 1)
,('2020-12-8', 'toyota', 1, 0)
,('2020-12-8', 'toyota', 1, 2)
,('2020-12-7', 'toyota', 0, 2)
,('2020-12-7', 'toyota', 0, 1)
,('2020-12-8', 'honda' , 1, 2)
,('2020-12-8', 'honda' , 2, 1)
,('2020-12-7', 'honda' , 0, 1)
,('2020-12-7', 'honda' , 1, 2)
,('2020-12-7', 'honda' , 2, 1);

/*
+------------+-----------+--------------+-----------------+
| date_id    | make_name | unique_leads | unique_partners |
+------------+-----------+--------------+-----------------+
| 2024-07-18 | toyota    | 2            | 3               |
| 2024-07-18 | honda     | 2            | 2               |
| 2024-07-17 | toyota    | 1            | 2               |
| 2024-07-17 | honda     | 3            | 2               |
+------------+-----------+--------------+-----------------+
*/

-- Approach 
select date_id, make_name,
       count(distinct lead_id) as unqiue_leads,
       count(distinct partner_id) as unique_partners 
       from DailySales
       group by 1,2 ;
