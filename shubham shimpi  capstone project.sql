create database Bank;
use Bank;

-- Q1. Write an SQL query to identify age group which is taking more loan and then calculate the sum of all of the balances of it. 
-- ANS:

select age,sum(balance)from bank.bank_details
group by age having count(loan)>=1;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q2. Write an SQL query to  calculate for each record if a loan has been taken less than 100,then calculate the fine of 15% of the current balance and create a temp table and then add the amount for each monthe from that temp table?
-- ANS:
-- step 1
create table temp(
AGE varchar(255),
new_balance varchar(255)
 );

-- =========================================
-- step 2

insert into temp 
select age, (balance*0.15) as new_balance from bank.bank_details
group by age
having count(loan) < 100;

-- step 3
insert into bank.bank_details
select new_balance from bank.temp;

-- --------------------------------------------------------------------------------------------------------------------------------------------------

-- Q3. Write an SQL query to claculate each age group along with each department's highest balance record?
-- ANS:

SELECT age,job,MAX(balance) 
FROM bank.bank_details
GROUP BY age,job;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q4. Write an SQL query to find the secondary highest education, where duration is more than 150. The query should contain only married people, and then calculate the interest amount?(Formula interest=> balance*15%).
-- ANS:

select education like 's',MAX(duration),marital
from bank.bank_details
having max(duration)>150;

-- -----------------------------Another way-------------------------------------------------------------------------------------------------------

SELECT education,duration,marital like 'married'
FROM bank.bank_details
WHERE education like 'secondary' 
GROUP BY education
HAVING duration>150;

-- Q5. write an SQL query to find which profession has taken more loan along with age.
-- ANS:

SELECT age,education FROM bank.bank_details
group BY  age,education
having count(loan) >=1;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q6. Write an SQL query to calculate each month"s total balance and then calculate in which month the highest amount of transaction was performed?

-- ANS:

select month,max(balance) from bank.bank_details
where balance in (select month,sum(balance) from bank.bank_details
group by month)
group by month
