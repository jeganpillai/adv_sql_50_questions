-- Question: Evaluate Boolean Expression

-- English Video: https://www.youtube.com/watch?v=lXS4CkE7S_M
-- Tamil Video: https://www.youtube.com/watch?v=9NzF545EEbQ


Create Table If Not Exists Variables (name varchar(3), value int);
Truncate table Variables;
insert into Variables (name, value) values 
 ('x', 66)
,('y', 77);

Create Table If Not Exists Expressions (
  left_operand varchar(3), 
  operator ENUM('>', '<', '='), 
  right_operand varchar(3));
Truncate table Expressions;
insert into Expressions (left_operand, operator, right_operand) values 
 ('x', '>', 'y')
,('x', '<', 'y')
,('x', '=', 'y')
,('y', '>', 'x')
,('y', '<', 'x')
,('x', '=', 'x');

/*
+--------------+----------+---------------+-------+
| left_operand | operator | right_operand | value |
+--------------+----------+---------------+-------+
| x            | >        | y             | false |
| x            | <        | y             | true  |
| x            | =        | y             | false |
| y            | >        | x             | true  |
| y            | <        | x             | false |
| x            | =        | x             | true  |
+--------------+----------+---------------+-------+
*/

-- Approach 1: Manage in single CASE statement 
select e.left_operand,
       e.operator,
       e.right_operand,
       case when e.operator = '>' and vl.value > vr.value then 'true'
            when e.operator = '<' and vl.value < vr.value then 'true'
            when e.operator = '=' and vl.value = vr.value then 'true'
            else 'false' end value 
       from Expressions e 
 inner join Variables vl
         on vl.name = e.left_operand 
 inner join Variables vr
         on vr.name = e.right_operand;

-- Approach 2: Clusterted CASE statement 
select e.left_operand,
       e.operator,
       e.right_operand,
       case when 
       case when e.operator = '>' then vl.value > vr.value 
            when e.operator = '<' then vl.value < vr.value
            when e.operator = '=' then vl.value = vr.value
       end = 1 then 'true' else 'false' end as value 
       from Expressions e 
 inner join Variables vl
         on vl.name = e.left_operand 
 inner join Variables vr
         on vr.name = e.right_operand;
