-- Question: Find the percentage of immediate orders

-- English Video: 
-- Tamil Video: 

Create table Delivery (delivery_id int, 
                       customer_id int, 
                       order_date date,
                       customer_pref_delivery_date date);
Truncate table Delivery;
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values
 (1, 1, '2024-07-01', '2024-07-02')
,(2, 5, '2024-07-02', '2024-07-02')
,(3, 1, '2024-07-11', '2024-07-11')
,(4, 3, '2024-07-24', '2024-07-26')
,(5, 4, '2024-07-21', '2024-07-22')
,(6, 2, '2024-07-11', '2024-07-13');

/*
+----------------------+
| immediate_percentage |
+----------------------+
| 33.33                |
+----------------------+
*/

-- Approach 1: Summing up boolean flg
select round(sum(case when order_date = customer_pref_delivery_date then 1 else 0 end)/count(*) * 100.0,2) as delivery_flg 
       from Delivery ;

-- Approach 2: Using Count option 
select round(count(case when order_date = customer_pref_delivery_date then delivery_id end)/count(*) * 100.0,2) as delivery_flg 
       from Delivery ;
