/*==============================================================================
SECTION 5 : DATA CLEANING
==============================================================================*/
--  customer_id matched all condition to convert it to primary key
	ALTER TABLE customer_data modify customer_id VARCHAR(30) NOT NULL primary KEY;
-- Convert Data Types
ALTER TABLE customer_data modify GENDER VARCHAR(30) NOT NULL;
ALTER TABLE customer_data MODIFY AGE INT NOT NULL;
ALTER TABLE customer_data MODIFY Marital_Status VARCHAR(5);
ALTER TABLE customer_data MODIFY STATE VARCHAR(30);
ALTER TABLE customer_data MODIFY TENURE_IN_MONTHS INT NOT NULL;
ALTER TABLE customer_data MODIFY Offer_type VARCHAR(30);
ALTER TABLE customer_data MODIFY PHONE_SERVICE VARCHAR(10);
ALTER TABLE customer_data MODIFY MULTIPLE_LINES VARCHAR(5);
ALTER TABLE customer_data MODIFY INTERNET_SERVICE VARCHAR(20);
ALTER TABLE customer_data MODIFY Internet_Type VARCHAR(20);
ALTER TABLE customer_data MODIFY Online_Security VARCHAR(30);
ALTER TABLE customer_data MODIFY Online_Backup VARCHAR(30);
ALTER TABLE customer_data MODIFY Device_Protection VARCHAR(30);
ALTER TABLE customer_data MODIFY Tech_support VARCHAR(30);
ALTER TABLE customer_data MODIFY Streaming_TV VARCHAR(30);
ALTER TABLE customer_data MODIFY Streaming_Movies VARCHAR(30);
ALTER TABLE customer_data MODIFY Streaming_Music VARCHAR(30);
ALTER TABLE customer_data MODIFY Unlimited_Data VARCHAR(30);
ALTER TABLE customer_data MODIFY Contract VARCHAR(30);
ALTER TABLE customer_data MODIFY Paperless_Billing VARCHAR(30);

-- Handle Blank Values 
CREATE OR REPLACE VIEW v_clean_customer_data AS
SELECT 
    TRIM(customer_id) AS customer_id,
    TRIM(gender) AS gender,age,
    TRIM(marital_status) AS marital_status,TRIM(state) AS state,
    COALESCE(number_of_referrals, 0) AS number_of_referrals,tenure_in_months,
    COALESCE(NULLIF(TRIM(offer_type), ''), 'None') AS offer_type,TRIM(phone_service) AS phone_service,
    COALESCE(NULLIF(TRIM(multiple_lines), ''), 'Not Available') AS multiple_lines,TRIM(internet_service) AS internet_service,
    COALESCE(NULLIF(TRIM(internet_type), ''), 'No Internet') AS internet_type,
    COALESCE(NULLIF(TRIM(online_security), ''), 'No Internet Service') AS online_security,
    COALESCE(NULLIF(TRIM(online_backup), ''), 'No Internet Service') AS online_backup,
    COALESCE(NULLIF(TRIM(device_protection), ''), 'No Internet Service') AS device_protection,
    COALESCE(NULLIF(TRIM(tech_support), ''), 'No Internet Service') AS tech_support,
    COALESCE(NULLIF(TRIM(streaming_tv), ''), 'No Internet Service') AS streaming_tv,
    COALESCE(NULLIF(TRIM(streaming_movies), ''), 'No Internet Service') AS streaming_movies,
    COALESCE(NULLIF(TRIM(streaming_music), ''), 'No Internet Service') AS streaming_music,
    COALESCE(NULLIF(TRIM(unlimited_data), ''), 'No Internet Service') AS unlimited_data,TRIM(contract) AS contract,
    TRIM(paperless_billing) AS paperless_billing,TRIM(payment_method) AS payment_method,
    monthly_charge,total_charges,total_refunds,total_extra_data_charges,total_long_distance_charges,
total_revenue,churn_category,churn_reason,TRIM(customer_status) AS customer_status
FROM customer_data;
select * from v_clean_customer_data;

-- Duplicate Records Validation
select customer_id,count(*) as duplicate_customers from v_clean_customer_data group by customer_id having count(*)>1;
-- No duplicate records found.
-- No action required.

-- Verify Clean Dataset
select count(*) as total_records from v_clean_customer_data;
select
sum(case when customer_id is null or customer_id='' then 1 else 0 end)as missing_cust_id_data,
sum(case when gender is null or trim(gender)='' then 1 else 0 end)as missing_gender_data,
sum(case when age is null then 1 else 0 end)as missing_age_data,
sum(case when marital_status is null or trim(marital_status)='' then 1 else 0 end)as missing_married_data,
sum(case when state is null or trim(state)='' then 1 else 0 end)as missing_state_data,
sum(case when number_of_referrals is null  then 1 else 0 end) as missing_referal_data,
sum(case when tenure_in_months is null or trim(tenure_in_months)='' then 1 else 0 end)as missing_tenure_data,
sum(case when Offer_type is null or trim(Offer_type)='' then 1 else 0 end)as missing_deal_data,
sum(case when phone_service is null or trim(phone_service)='' then 1 else 0 end)as missing_phone_service_data,
sum(case when multiple_lines is null or trim(multiple_lines)='' then 1 else 0 end)as missing_lines_data,
sum(case when internet_service is null or trim(internet_service)='' then 1 else 0 end)as missing_internet_service_data,
sum(case when internet_type is null or trim(internet_type)='' then 1 else 0 end)as missing_INternet_type_data,
sum(case when online_security is null or trim(online_security)='' then 1 else 0 end)as missing_online_security_data,
sum(case when online_backup is null or trim(online_backup)='' then 1 else 0 end)as missing_online_backup_data,
sum(case when Device_protection is null or trim(Device_protection)='' then 1 else 0 end)as missing_device_protection_data,
SUM(CASE WHEN Tech_support IS NULL OR trim(Tech_support) = '' THEN 1 ELSE 0 END) AS missing_premium_support_data,
SUM(CASE WHEN Streaming_TV IS NULL OR trim(Streaming_TV) = '' THEN 1 ELSE 0 END) AS missing_streaming_tv_data,
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
from v_clean_customer_data;
desc v_clean_customer_data;
-- VERIFYING INVALID VALUES
SELECT DISTINCT gender FROM v_clean_customer_data;
SELECT DISTINCT marital_status FROM v_clean_customer_data;
SELECT DISTINCT contract FROM v_clean_customer_data;
-- MIN AND MAX OF QUANTITATIVE DATA
select min(age) min_age , max(age) as max_age from v_clean_customer_data;
select min(monthly_charge) as min_charge, max(monthly_charge) as max_charge from v_clean_customer_data;
-- CLEANED DATASET SAMPLE
select* from v_clean_customer_data limit 10;
