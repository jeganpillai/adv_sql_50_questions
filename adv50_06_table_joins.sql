-- Question: Combine two tables for the required dataset

-- English Video: https://www.youtube.com/watch?v=px1hMcEEnto
-- Tamil Video: https://www.youtube.com/watch?v=sYkIib-8mkE

Create table Person (personId int, 
                     firstName varchar(255), 
                     lastName varchar(255));
Truncate table Person;
insert into Person (personId, lastName, firstName) values 
 (1, 'Wang', 'Allen')
,(2, 'Alice', 'Bob');

Create table Address (addressId int, 
                      personId int, 
                      city varchar(255), 
                      state varchar(255));
Truncate table Address;
insert into Address (addressId, personId, city, state) values 
 (101, 2, 'New York City', 'New York')
,(201, 3, 'Dublin', 'California');

/*
+-----------+----------+---------------+----------+
| firstName | lastName | city          | state    |
+-----------+----------+---------------+----------+
| Allen     | Wang     | Null          | Null     |
| Bob       | Alice    | New York City | New York |
+-----------+----------+---------------+----------+
*/
-- Basic Left Join 
select p.firstName, p.lastName, a.city, a.state
       from Person p 
  left join Address a 
         on a.personId = p.personId;

/* Types of Joins */ 
-- Type 1 : INNER JOIN 
select p.firstName, p.lastName, a.city, a.state
       from Person p 
 inner join Address a 
         on a.personId = p.personId;

-- Type 2: LEFT JOIN 
select p.firstName, p.lastName, a.city, a.state
       from Person p 
  left join Address a 
         on a.personId = p.personId;

-- Type 2-a: Data from Primary table with no match
select p.firstName, p.lastName, a.city, a.state
       from Person p 
  left join Address a 
         on a.personId = p.personId
      where a.personId is null;

-- Type 3: RIGHT JOIN 
select p.firstName, p.lastName, a.city, a.state
       from Person p 
  right join Address a 
         on a.personId = p.personId;

-- Type 3-a: Data from Primary table with no match
select p.firstName, p.lastName, a.city, a.state
       from Person p 
  right join Address a 
         on a.personId = p.personId
      where p.personId is null;

-- Type 4: FULL JOIN 
select p.firstName, p.lastName, a.city, a.state 
       from Person p 
  full join Address a 
         on a.personId = p.personId;

-- Type 4-a: Data from Both tables with no match
select p.firstName, p.lastName, a.city, a.state 
       from Person p 
  full join Address a 
         on a.personId = p.personId 
      where a.personId is null or p.personId is null;
-- Type 4-b: FULL JOIN with MySQL 
with all_data as (
select p.firstName, p.lastName, a.city, a.state
       from Person p 
  left join Address a 
         on a.personId = p.personId
union 
select p.firstName, p.lastName, a.city, a.state
       from Person p 
 right join Address a 
         on a.personId = p.personId)
select * from all_data 
where firstName is null or city is null;
