-- 1
CREATE DATABASE credit_card_classification ;
-- 2
/*drop table if exists credit_card_data;
   CREATE TABLE `credit_card_data` (
  `Customer_Number` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `Offer_Accepted` enum('Yes','No') DEFAULT NULL,
  `Reward`enum('Air Miles','Cashback','Points') DEFAULT NULL ,
  `Mailer_Type` enum('Letter','Postcard') DEFAULT NULL,
  `Income_Level` enum('Low','Medium','High') DEFAULT NULL,
  `Nr_Bank_Accounts_Open` tinyint(3) unsigned DEFAULT NULL,
  `Overdraft_Protection` enum('Yes','No') DEFAULT NULL,
  `Credit_Rating` enum('Low','Medium','High') DEFAULT NULL,
  `Nr_Credit_Cards_Held` smallint(5) unsigned DEFAULT NULL,
  `Nr_Homes_Owned` decimal(5,2) DEFAULT NULL,
  `Household_Size` decimal(5,2) DEFAULT NULL,
  `Own_Your_Home` enum('Yes','No') DEFAULT NULL,
  `Average_Balance` int(6),
  `Q1_Balance` int(6),
  `Q2_Balance` int(6),
  `Q3_Balance` int(6),
  `Q4_Balance` int(6),
  PRIMARY KEY (`Customer_Number`)
  ) */

-- ALTER TABLE credit_card_data RENAME COLUMN `# Bank Accounts Open` TO  Nr_Bank_Accounts_Open;
-- ALTER TABLE credit_card_data RENAME COLUMN `# Credit Cards Held` TO  Nr_Credit_Cards_Held;
-- ALTER TABLE credit_card_data RENAME COLUMN `# Homes Owned` TO  Nr_Homes_Owned;
-- *3
SHOW VARIABLES LIKE 'local_infile'; 
SET GLOBAL local_infile = 1;
-- 4*
SELECT * FROM credit_card_classification.credit_card_data;
-- 5*
alter table credit_card_data
drop column `Q4 Balance`;
SELECT * FROM credit_card_classification.credit_card_data;
-- 6*
SELECT COUNT(*) as Nr_rows
FROM credit_card_data;
-- 7*
SELECT DISTINCT `Customer Number`, `Offer Accepted`, `Reward`, `Mailer Type`, `Nr_Credit_Cards_Held`, `Household Size`
FROM credit_card_data;
-- 8*
SELECT `Customer Number`, `Average Balance`FROM credit_card_data
ORDER BY `Average Balance` desc limit 10;
-- 9*
SELECT round(AVG(`Average Balance`)) as Total_Average_Balance
FROM credit_card_data;
-- 10*
SELECT `Income Level`, round(AVG(`Average Balance`)) as Total_Average_Balance
FROM credit_card_data
group by `Income Level`;

SELECT `Nr_Bank_Accounts_Open`, round(AVG(`Average Balance`)) as Total_Average_Balance
FROM credit_card_data
group by `Nr_Bank_Accounts_Open`;

SELECT `Credit Rating`, round(AVG(`Nr_Bank_Accounts_Open`)) as AVG_CreditCardsHeld
FROM credit_card_data
group by `Credit Rating`;

SELECT `Nr_Credit_Cards_Held`, round(avg(`Nr_Bank_Accounts_Open`))
FROM credit_card_data
group by `Nr_Credit_Cards_Held`;
-- 11*
select * from credit_card_data
where `Credit Rating` =('medium' or 'high') and
Nr_Credit_Cards_Held <= 2 and 
`Own Your Home` = 'yes' and 
`Household Size` >= 3 and 
`Offer Accepted` = 'yes';
-- 12*
select * from credit_card_data
where  `Average Balance`< ( select avg(`Average Balance`) from credit_card_data);
-- 13*
CREATE VIEW credit_card_data_view AS
select * from credit_card_data
where  `Average Balance`< ( select avg(`Average Balance`) from credit_card_data);
-- 14*
select `Offer Accepted`, count(`Customer Number`) as Total_Customers from credit_card_data
group by `Offer Accepted`;
-- 15*
select round((select avg(`Average Balance`) from credit_card_data where `Credit Rating`= 'high') - 
(select avg(`Average Balance`) from credit_card_data where `Credit Rating`= 'low')) as Difference_high_low_rating;
-- 16*
select `Mailer Type`, count(`Customer Number`) as Total_Customers from credit_card_data
group by `Mailer Type`;
-- 17*
select * from credit_card_data
order by `Q1 Balance` asc 
limit 12, 1;