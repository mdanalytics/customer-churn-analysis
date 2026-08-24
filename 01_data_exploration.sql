/*==============================================================================
                            CUSTOMER CHURN ANALYSIS
==============================================================================

Project Title : Customer Churn Analysis
Author        : Mohammed Hassan
Role          : Data Analyst
Tool          : MySQL Workbench
Database      : customer_churn
Dataset       : customer_data.csv
Project Type  : End-to-End SQL Data Analysis Project

------------------------------------------------------------------------------
Project Objective
------------------------------------------------------------------------------
Analyze customer churn data to identify the major reasons customers leave,
measure churn rate, understand customer behavior, and provide business
recommendations to reduce customer churn.

------------------------------------------------------------------------------
Dataset Information
------------------------------------------------------------------------------
Table Name    : customer_data
Total Columns : 32
Total Rows    : 6418

Primary Key : customer_id

==============================================================================*/


/*==============================================================================
SECTION 1 : CREATE DATABASE
==============================================================================*/

-- Create Database
CREATE DATABASE IF NOT EXISTS customer_churn;
-- Use Database
USE customer_churn;
/*******************************************************************************/

/*==============================================================================
SECTION 2 : IMPORT DATA
==============================================================================*/

-- Import customer_data.csv using MySQL Workbench
-- Table Data Import Wizard

-- Table Name    : customer_data
-- Rows Imported : 6418
-- Import Status : SUCCESS
/*******************************************************************************/


/*==============================================================================
SECTION 3 : DATA INSPECTION
==============================================================================*/

-- Preview Dataset
SELECT * FROM CUSTOMER_DATA;

-- Total Rows
SELECT COUNT(*) AS TOTAL_ROWS FROM CUSTOMER_DATA;

-- Total Columns
SELECT COUNT(*) AS TOTAL_COLUMN FROM INFORMATION_SCHEMA.COLUMNS WHERE 
TABLE_SCHEMA ='CUSTOMER_CHURN' AND TABLE_NAME = 'CUSTOMER_DATA';

-- Customer Status Validation : Customer status
select customer_status,count(*) as customers_count from customer_data group by customer_status;
-- Table Structure and Check Data Types
describe CUSTOMER_DATA;
-- Sample Records
select * from customer_data limit 5;

/*******************************************************************************/

/*==============================================================================
SECTION 4 : DATA QUALITY CHECK
==============================================================================*/
-- Rename Columns (if required)
alter table customer_data rename column married to Marital_Status;
alter table customer_data rename column value_deal to Offer_type;
alter table customer_data rename column premium_support to Tech_support;
alter table customer_data rename column device_protection_plan to Device_protection;

-- Check NULL Values and Check Blank Values
select
sum(case when customer_id is null or trim(customer_id)='' then 1 else 0 end)as missing_cust_id_data,
sum(case when gender is null or trim(gender)='' then 1 else 0 end)as missing_gende_datar,
sum(case when age is null then 1 else 0 end)as missing_age_data,
sum(case when Marital_Status is null or trim(Marital_Status)='' then 1 else 0 end)as missing_married_data,
sum(case when state is null or trim(state)='' then 1 else 0 end)as missing_state_data,
sum(case when number_of_referrals is null then 1 else 0 end)as missing_referal_data,
sum(case when tenure_in_months is null then 1 else 0 end)as missing_tenure_data,
sum(case when Offer_type is null or trim(Offer_type)='' then 1 else 0 end)as missing_deal_data,
sum(case when phone_service is null or trim(phone_service)='' then 1 else 0 end)as missing_phone_service_data,
sum(case when multiple_lines is null or trim(multiple_lines)='' then 1 else 0 end)as missing_lines_data,
sum(case when internet_service is null or trim(internet_service)='' then 1 else 0 end)as missing_internet_service_data,
sum(case when internet_type is null or trim(internet_type)='' then 1 else 0 end)as missing_INternet_type_data,
sum(case when online_security is null or trim(online_security)='' then 1 else 0 end)as missing_online_security_data,
sum(case when online_backup is null or trim(online_backup)='' then 1 else 0 end)as missing_online_backup_data,
sum(case when Device_protection is null or trim(Device_protection)='' then 1 else 0 end)as missing_device_protection_data,
SUM(CASE WHEN Tech_support IS NULL OR trim(Tech_support) = '' THEN 1 ELSE 0 END) AS missing_premium_support_data,
SUM(CASE WHEN Streaming_TV IS NULL OR trim(Streaming_TV)= '' THEN 1 ELSE 0 END) AS missing_streaming_tv_data,
SUM(CASE WHEN Streaming_Movies IS NULL OR trim(Streaming_Movies) = '' THEN 1 ELSE 0 END) AS missing_streaming_movies_data,
SUM(CASE WHEN Streaming_Music IS NULL OR trim(Streaming_Music) = '' THEN 1 ELSE 0 END) AS missing_streaming_music_data,
SUM(CASE WHEN Unlimited_Data IS NULL OR trim(Unlimited_Data) = '' THEN 1 ELSE 0 END) AS missing_unlimited_data_data,
SUM(CASE WHEN Contract IS NULL OR trim(Contract) = '' THEN 1 ELSE 0 END) AS missing_contract_data,
SUM(CASE WHEN Paperless_Billing IS NULL OR trim(Paperless_Billing) = '' THEN 1 ELSE 0 END) AS missing_paperless_billing_data,
SUM(CASE WHEN Payment_Method IS NULL OR trim(Payment_Method) = '' THEN 1 ELSE 0 END) AS missing_payment_method_data,
SUM(CASE WHEN Monthly_Charge IS NULL THEN 1 ELSE 0 END) AS missing_monthly_charge_data,
SUM(CASE WHEN Total_Charges IS NULL THEN 1 ELSE 0 END) AS missing_total_charges_data,
SUM(CASE WHEN Total_Refunds IS NULL THEN 1 ELSE 0 END) AS missing_total_refunds_data,
SUM(CASE WHEN Total_Extra_Data_Charges IS NULL THEN 1 ELSE 0 END) AS missing_total_extra_data_charges_data,
SUM(CASE WHEN Total_Long_Distance_Charges IS NULL THEN 1 ELSE 0 END) AS missing_total_long_distance_charges_data,
SUM(CASE WHEN Total_Revenue IS NULL THEN 1 ELSE 0 END) AS missing_total_revenue_data,
SUM(CASE WHEN Customer_Status IS NULL OR trim(Customer_Status) = '' THEN 1 ELSE 0 END) AS missing_customer_status_data,
SUM(CASE WHEN Churn_Category IS NULL OR trim(Churn_Category) = '' THEN 1 ELSE 0 END) AS missing_churn_category_data,
SUM(CASE WHEN Churn_Reason IS NULL OR trim(Churn_Reason) = '' THEN 1 ELSE 0 END) AS missing_churn_reason_data
from customer_data
;
-- Check Duplicate Customer IDs
select customer_id, count(*) as Duplicate_Customers from customer_data group by customer_id having count(*)>1;

-- Check Logical Inconsistency: Zero Tenure with Non-Zero Total Charges
select customer_id,tenure_in_months,total_charges from customer_data 
where tenure_in_months=0 and total_charges>0;

-- 2. Check Outliers 
select monthly_charge from customer_data order by monthly_charge desc;
select total_charges from customer_data order by total_charges desc;
select tenure_in_months from customer_data order by tenure_in_months desc;

-- 3.  Invalid Negative Values in Financial Columns
select 
count(case when monthly_charge<0 then 1 end) as negative_monthly_charge,
count(case when total_charges<0 then 1 end) as negative_total_charges,
count(case when tenure_in_months<0 then 1 end) as negative_tenure 
from customer_data;
-- Check Invalid Values
select * from customer_data limit 5;
select distinct gender from customer_data;
select distinct Marital_Status from customer_data;
select distinct state from customer_data;
select distinct Offer_type from customer_data;
select distinct contract from customer_data;
select distinct payment_method from customer_data;
select distinct Customer_status from customer_data;
SELECT DISTINCT internet_service FROM customer_data;
SELECT DISTINCT internet_type FROM customer_data;
SELECT DISTINCT churn_category FROM customer_data;
SELECT DISTINCT churn_reason FROM customer_data;
SELECT DISTINCT multiple_lines FROM customer_data;
SELECT DISTINCT online_security FROM customer_data;
SELECT DISTINCT online_backup FROM customer_data;
SELECT DISTINCT device_protection FROM customer_data;
SELECT DISTINCT tech_support FROM customer_data;

-- Check Data Consistency
SELECT count(*) as churned_without_category FROM customer_data WHERE customer_status = 'churned' AND 
(churn_category IS NULL OR TRIM(churn_category)='');
select count(*) as churn_without_reason from customer_data where customer_status ='churned' and 
(churn_reason is null or trim(churn_reason)='');

-- Checking Financial Revenue Consistency Formula
-- Total Revenue should equal (Total Charges + Extra Data + Long Distance - Refunds)
	select customer_id,total_charges,total_extra_data_charges,total_long_distance_charges, 
	total_refunds, total_revenue, round((total_charges+total_extra_data_charges+total_long_distance_charges-total_refunds),2)
	as calculated_total_revenue from customer_data where round(total_revenue,2)<>
	round((total_charges+total_extra_data_charges+total_long_distance_charges-total_refunds),2);
-- Expected Outcome: 0 rows mismatch

-- Primary Key validation : customer_id 
-- compare total customers to uniqe customer_id
select count(*) as total_customers ,count(distinct customer_id) as unique_customer from customer_data;
-- Check Null customer_id
select count(*) as Null_count from customer_data where customer_id is null;
-- check Blank customer_id
select count(*) as Blank_count from customer_data where customer_id='';
-- Checking Duplicate customer_id
select customer_id,count(*) as Count_duplicate_id from customer_data group by customer_id having count(*)>1;
-- data validation checking
SELECT customer_id FROM customer_data WHERE customer_status = 'churned' AND churn_reason IS NULL;

/*******************************************************************************/
