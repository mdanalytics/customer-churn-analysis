/*==============================================================================
SECTION 6 : EXPLORATORY DATA ANALYSIS (EDA)
==============================================================================*/

---------------------------------------------------
-- Customer Overview 
---------------------------------------------------
-- Total Customers
select count(*) as total_customers from v_clean_customer_data;

-- Total Churn and Active and new join customers
select customer_status,count(*) as total_customers from v_clean_customer_data group by customer_status ;

-- Churn Rate
select count(*) as total_customers, sum(case when customer_status='churned' then 1 else 0 end) as churned_customers,
sum(case when customer_status='stayed' then 1 else 0 end) as active_customers,
round(sum(case when customer_status='churned' then 1 else 0 end)*100/count(*),2) as churn_rate_pct from v_clean_customer_data;

---------------------------------------------------
-- Gender Analysis
---------------------------------------------------
-- Gender Distribution
select gender,count(*) as gender_distribution from v_clean_customer_data group by gender;
-- share of churn by gender
select gender,count(*) as Total_customers ,sum(case when customer_status='churned' then 1 else 0 end) 
as churned_customers, round(sum(case when customer_status='churned' then 1 else 0 end)*100.0/(select 
count(*) from v_clean_customer_data where customer_status='churned'),2) as share_of_churn_by_gender,
round(sum(case when customer_status='churned' then 1 else 0 end)*100.0/ count(*),2) 
as gender_churn_pct from v_clean_customer_data group by gender;

---------------------------------------------------
-- Senior Citizen Analysis
---------------------------------------------------
-- Senior Citizen Distribution
	select case when age>=60 then 'senior_citizen' else 'non_senior_citizen'end
	as age_group, count(*) as total_customers from v_clean_customer_data group by age_group ;

-- Churn by Senior Citizen
SELECT CASE WHEN age >= 60 THEN 'Senior Citizen' ELSE 'Non-Senior Citizen' END AS age_group,
COUNT(*) AS total_customers,SUM(CASE WHEN customer_status = 'churned' THEN 1 ELSE 0 END) AS churned_customers,
				-- Share of Total Churn
round(sum(case when customer_status='churned' then 1 else 0 end)*100/(select count(*)  
from v_clean_customer_data where customer_status='churned'),2) as share_of_total_churn_pct,
			-- Actual Churn Rate by age_group
ROUND(SUM(CASE WHEN customer_status = 'churned' THEN 1 ELSE 0 END) * 100.0 /  COUNT(*),2) AS age_group_rate_pct FROM v_clean_customer_data GROUP BY age_group;
---------------------------------------------------
-- Contract Analysis
---------------------------------------------------
-- Contract Distribution
SELECT contract, COUNT(*) AS Total_Customers,
SUM(CASE WHEN customer_status = 'churned' THEN 1 ELSE 0 END) AS Churned_Customers,
    -- Share of Total Churn
ROUND(SUM(CASE WHEN customer_status = 'churned' THEN 1 ELSE 0 END) * 100.0 / (SELECT COUNT(*) 
FROM v_clean_customer_data WHERE customer_status = 'churned'), 2) AS share_of_total_churn_pct,
   -- Actual Churn Rate by contract
ROUND(SUM(CASE WHEN customer_status = 'churned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as 
contract_churn_pct FROM v_clean_customer_data GROUP BY contract;
---------------------------------------------------
-- Internet Service Analysis
---------------------------------------------------
-- Internet Service Distribution
select Internet_service,count(*) as Internet_Service_Distribution from v_clean_customer_data 
group by internet_service;
-- Churn by Internet Service
select Internet_service,count(*) as total_customers,
sum(case when customer_status='churned' then 1 else 0 end) as churned_customers,
-- share of churn by internet service 
sum(case when customer_status='churned' then 1 else 0 end)*100/
(select count(*) from v_clean_customer_data where customer_status='churned') as share_of_churn,
-- Actual Churn Rate by internet service 
round(sum(case when customer_status='churned' then 1 else 0 end)*100/count(*),2) 
as internet_service_rate_pct from v_clean_customer_data group by Internet_service;

---------------------------------------------------
-- Phone Service Analysis
---------------------------------------------------

-- Phone Service Distribution
select phone_service,count(*) as phone_Service_Distribution from v_clean_customer_data 
group by phone_service;
-- Churn by Phone Service
select phone_service,count(*) as total_customers,
sum(case when customer_status='churned' then 1 else 0 end) as churned_customers,
-- share of churn by internet service 
sum(case when customer_status='churned' then 1 else 0 end)*100/
(select count(*) from v_clean_customer_data where customer_status='churned') as share_of_churn,
-- Actual Churn Rate by phone service
round(sum(case when customer_status='churned' then 1 else 0 end)*100/count(*),2) as phone_service_rate_pct
 from v_clean_customer_data group by phone_service;
---------------------------------------------------
-- Multiple Lines Analysis
---------------------------------------------------
-- Multiple Lines Distribution
select multiple_lines,count(*) as Multiple_Lines_Distribution from v_clean_customer_data 
group by multiple_lines;
-- Churn by Multiple Lines
select multiple_lines,count(*) as total_customers,
sum(case when customer_status='churned' then 1 else 0 end) as churned_customers,
-- share of churn by Multiple Lines
round(sum(case when customer_status='churned' then 1 else 0 end)*100/
(select count(*) from v_clean_customer_data where customer_status='churned'),2) as share_of_churn,
-- Actual Churn Rate by Multiple Lines
round(sum(case when customer_status='churned' then 1 else 0 end)*100/count(*),2)  as multiple_lines_rate_pct
 from v_clean_customer_data group by multiple_lines;
---------------------------------------------------
-- Online Security Analysis
---------------------------------------------------
-- online_security Distribution
select online_security,count(*) as Multiple_Lines_Distribution from v_clean_customer_data 
group by online_security;
-- Churn by Online Security
select online_security,count(*) as total_customers,
sum(case when customer_status='churned' then 1 else 0 end) as churned_customers,
-- share of churn by online security
round(sum(case when customer_status='churned' then 1 else 0 end)*100/
(select count(*) from v_clean_customer_data where customer_status='churned'),2) as share_of_churn,
-- Actual Churn Rate by online security
round(sum(case when customer_status='churned' then 1 else 0 end)*100/ count(*),2) as online_security_rate_pct
 from v_clean_customer_data group by online_security;
---------------------------------------------------
-- Online Backup Analysis
---------------------------------------------------
-- online backup Distribution
select online_backup,count(*) as online_backup_Distribution from v_clean_customer_data 
group by online_backup;
-- Churn by online_backup
select online_backup,count(*) as total_customers,
sum(case when customer_status='churned' then 1 else 0 end) as churned_customers,
-- share of churn by online_backup
round(sum(case when customer_status='churned' then 1 else 0 end)*100/
(select count(*) from v_clean_customer_data where customer_status='churned'),2) as share_of_churn,
-- Actual Churn Rate by online_backup
round(sum(case when customer_status='churned' then 1 else 0 end)*100/ count(*),2)as online_backup_churn_rate_pct
 from v_clean_customer_data group by online_backup;
---------------------------------------------------
-- Device Protection Analysis
---------------------------------------------------
-- device_protection Distribution
select device_protection,count(*) as device_protection_Distribution from v_clean_customer_data 
group by device_protection;
-- Churn by device_protection
select device_protection,count(*) as total_customers,
sum(case when customer_status='churned' then 1 else 0 end) as churned_customers,
-- share of churn by device_protection
ROUND(sum(case when customer_status='churned' then 1 else 0 end)*100/
(select count(*) from v_clean_customer_data where customer_status='churned'),2) as share_of_churn,
-- Actual Churn Rate by device_protection
ROUND(sum(case when customer_status='churned' then 1 else 0 end)*100/ count(*),2)  as device_protection_churn_rate_pct
 from v_clean_customer_data group by device_protection;
---------------------------------------------------
-- Tech Support Analysis
---------------------------------------------------
--  tech_support Distribution
select tech_support,count(*) as tech_support_Distribution from v_clean_customer_data 
group by tech_support;
-- Churn by tech_support
select tech_support,count(*) as total_customers,
sum(case when customer_status='churned' then 1 else 0 end) as churned_customers,
-- share of churn by tech_support
ROUND(sum(case when customer_status='churned' then 1 else 0 end)*100/
(select count(*) from v_clean_customer_data where customer_status='churned'),2) as share_of_churn,
-- Actual Churn Rate by tech_support
ROUND(sum(case when customer_status='churned' then 1 else 0 end)*100/ count(*),2) as tech_support_churn_rate_pct
 from v_clean_customer_data group by tech_support;
---------------------------------------------------
-- Streaming TV Analysis
---------------------------------------------------
--  streaming_tv Distribution
select streaming_tv,count(*) as streaming_tv_Distribution from v_clean_customer_data 
group by streaming_tv;
-- Churn by streaming_tv
select streaming_tv,count(*) as total_customers,
sum(case when customer_status='churned' then 1 else 0 end) as churned_customers,
-- share of churn by streaming_tv
ROUND(sum(case when customer_status='churned' then 1 else 0 end)*100/
(select count(*) from v_clean_customer_data where customer_status='churned'),2) as share_of_churn,
-- Actual Churn Rate by tech_support
round(sum(case when customer_status='churned' then 1 else 0 end)*100/ count(*),2) as streaming_tv_churn_rate_pct
 from v_clean_customer_data group by streaming_tv;
---------------------------------------------------
-- Streaming Movies Analysis
---------------------------------------------------
-- Churn by Streaming Movies
select streaming_movies,count(*) as churn_by_streaming_movies from v_clean_customer_data where customer_status='churned'
group by streaming_movies;
--  streaming_movies Distribution
select streaming_movies,count(*) as streaming_movies_Distribution from v_clean_customer_data 
group by streaming_movies;
-- Churn by streaming_movies
select streaming_movies,count(*) as total_customers,
sum(case when customer_status='churned' then 1 else 0 end) as churned_customers,
-- share of churn by streaming_movies
round(sum(case when customer_status='churned' then 1 else 0 end)*100/
(select count(*) from v_clean_customer_data where customer_status='churned'),2) as share_of_churn,
-- Actual Churn Rate by streaming_movies
round(sum(case when customer_status='churned' then 1 else 0 end)*100/count(*),2)  as streaming_movies_rate_pct
 from v_clean_customer_data group by streaming_movies;
---------------------------------------------------
-- Paperless Billing Analysis
---------------------------------------------------
--  paperless_billing Distribution
select paperless_billing,count(*) as paperless_billing_Distribution from v_clean_customer_data 
group by paperless_billing;
-- Churn by paperless_billing
select paperless_billing,count(*) as total_customers,
sum(case when customer_status='churned' then 1 else 0 end) as churned_customers,
-- share of churn by streaming_movies
round(sum(case when customer_status='churned' then 1 else 0 end)*100/
(select count(*) from v_clean_customer_data where customer_status='churned'),2) as share_of_churn,
-- Actual Churn Rate by paperless_billing
round(sum(case when customer_status='churned' then 1 else 0 end)*100/ count(*),2) as paperless_billing_rate_pct
 from v_clean_customer_data group by paperless_billing;
---------------------------------------------------
-- Payment Method Analysis
---------------------------------------------------
--  payment_method Distribution
select payment_method,count(*) as paperless_billing_Distribution from v_clean_customer_data 
group by payment_method;
-- Churn by Payment Method
SELECT payment_method,COUNT(*) AS total_customers,
SUM(CASE WHEN customer_status = 'churned' THEN 1 ELSE 0 END) AS churned_customers,
ROUND(SUM(CASE WHEN customer_status = 'churned' THEN 1 ELSE 0 END) * 100.0 / count(*) , 2) AS payment_method_churn_rate_pct,
ROUND(SUM(CASE WHEN customer_status = 'churned' THEN 1 ELSE 0 END) * 100.0 / 
(SELECT COUNT(*) FROM v_clean_customer_data WHERE customer_status = 'churned'), 2) AS share_of_total_churn_pct
FROM v_clean_customer_data GROUP BY payment_method;
---------------------------------------------------
-- Monthly Charges Analysis
---------------------------------------------------

-- Average Monthly Charges
select round(avg(Monthly_Charge),2) as avg_monthly_charge from v_clean_customer_data;

-- customers who pay the highest monthly charges
select customer_id,monthly_charge from v_clean_customer_data where 
monthly_charge=(select max(monthly_charge) from v_clean_customer_data);

-- Highest Monthly Charges
select round(max(Monthly_Charge),2) as max_monthly_charge from v_clean_customer_data;

-- Lowest Monthly Charges
select round(min(Monthly_Charge),2) as lowest_monthly_charge from v_clean_customer_data;

-- Monthly Charges by Churn
select customer_status,round(sum(monthly_charge),2)as total_monthly_revenue from v_clean_customer_data 
 group by customer_status;
 
-- customers monthly charge greater then average monthly charge of their contract type.
select c1.customer_id,c1.contract,c1.monthly_charge from v_clean_customer_data c1 where c1.monthly_charge>
(select avg(c2.monthly_charge) from v_clean_customer_data c2 where c1.contract=c2.contract);
---------------------------------------------------
-- Total Charges Analysis
---------------------------------------------------
-- Average Total Charges
select round(avg(total_charges),2) as Avg_Total_Charge from v_clean_customer_data;
-- Highest total charges and lowest total charges
select max(total_charges) as highest_amount,min(total_charges) as lowest_amount from v_clean_customer_data;
-- Total Charges by Churn
select customer_status,count(total_charges)as churn_by_total_charges,round(sum(total_charges),2) 
as total_revenue from v_clean_customer_data group by customer_status;
---------------------------------------------------
-- Tenure Analysis
---------------------------------------------------
-- Maximum Tenure and Minimum Tenure and Average Tenure
select customer_status,round(avg(tenure_in_months),2) as avg_monthly_tenure,max(tenure_in_months) as max_monthly_tenure,
min(tenure_in_months) as min_monthly_tenure from v_clean_customer_data group by customer_status;
-- Advanced Query : Multi-metric Tenure Breakdown using Window Aggregates
WITH Tenure_Segment_Summary AS (
    SELECT CASE 
            WHEN tenure_in_months < 12 THEN '0-12 Months' 
            WHEN tenure_in_months < 24 THEN '13-24 Months' 
            WHEN tenure_in_months < 48 THEN '25-48 Months' 
            ELSE '49+ Months' 
        END AS tenure_cohort, COUNT(*) AS total_customers,
        SUM(CASE WHEN customer_status = 'churned' THEN 1 ELSE 0 END) AS churned_customers
    FROM v_clean_customer_data GROUP BY tenure_cohort)
    SELECT tenure_cohort,total_customers,churned_customers,
    ROUND(churned_customers * 100.0 / (select count(*) from v_clean_customer_data ), 2) AS total_churn_pct,
    ROUND(churned_customers * 100.0 / SUM(churned_customers) OVER (), 2) AS share_churn_pct
FROM Tenure_Segment_Summary ORDER BY total_churn_pct DESC;

-- single-month Cohort trend view analysis 
SELECT tenure_in_months,COUNT(*) AS total_customers,
       SUM(CASE WHEN customer_status='churned' THEN 1 ELSE 0 END) AS churned_customers,
       round(sum(case WHEN customer_status='churned' THEN 1 ELSE 0 END) *100.0/(select count(*) 
       from v_clean_customer_data where customer_status='churned'),2) as share_of_churn_pct,
       ROUND(SUM(CASE WHEN customer_status='churned' THEN 1 ELSE 0 END)*100.0/ COUNT(*),2) AS total_churn_pct
FROM v_clean_customer_data GROUP BY tenure_in_months ORDER BY tenure_in_months;
--------------------------------------------------
	-- customer segment Analysis
--------------------------------------------------
select 
case 
	when tenure_in_months<12 then 'new_customer' 
	when tenure_in_months<24 then 'Regular_customer' 
	when tenure_in_months<36 then 'Loyal customer' else 'Very Loyal customer' 
	end as customer_segment 
from v_clean_customer_data;

-- churn by customer segment
select case when tenure_in_months<12 then 'new_customer' 
when tenure_in_months<24 then 'regular_customer' when tenure_in_months<36 
then 'Loyal customer'else 'Very Loyal Customer'end as customer_segment,count(*) as churned_customers from v_clean_customer_data 
where customer_status='churned' group by  customer_segment;

-- Root-Cause Analysis (Churn Category & Reason Breakdown)
select churn_reason,count(*) as count_reason from v_clean_customer_data group by churn_reason;
---------------------------------------
-- Advanced analysis 
---------------------------------------
-- Advanced Query : State-wise Revenue Comparison using CTE and Window Functions
WITH State_Revenue_Stats AS (
    SELECT customer_id,state,total_revenue,customer_status,
	AVG(total_revenue) OVER (PARTITION BY state) AS avg_state_revenue
    FROM v_clean_customer_data) 
    SELECT customer_id,state,total_revenue,ROUND(avg_state_revenue, 2) AS avg_state_revenue,
    ROUND(total_revenue - avg_state_revenue, 2) AS revenue_difference,customer_status
FROM State_Revenue_Stats
WHERE total_revenue > avg_state_revenue
ORDER BY state, total_revenue DESC;
select state,count(*) as total_customers,sum(case when customer_status='churned' then 1 else 0 end) as churned_customers,
round(sum(case when customer_status='churned' then 1 else 0 end)*100/(select count(*) from v_clean_customer_data 
where customer_status='churned'),2) as share_churned_rate_pct,
round(sum(case when customer_status='churned' then 1 else 0 end)*100/count(*),2) as state_wise_churn_rate
from v_clean_customer_data group by state;
-- Customers generating above-average revenue within their state.
select c1.customer_id,c1.state,c1.total_revenue from v_clean_customer_data c1 where total_revenue>
(select avg(c2.total_revenue) from v_clean_customer_data c2 where c1.state=c2.state);

-- customers whose monthly_charge is above the average monthly_charge of customers in the same contract
WITH ContractAvgCharge AS (
    SELECT 
	customer_id, contract, monthly_charge, AVG(monthly_charge) OVER(PARTITION BY contract) 
    AS avg_contract_monthly_charge FROM v_clean_customer_data) 
    SELECT customer_id, contract, monthly_charge, ROUND(avg_contract_monthly_charge, 2) 
	AS avg_contract_charge FROM ContractAvgCharge 
WHERE monthly_charge > avg_contract_monthly_charge;

/*------------------------------------------------------
Root-Cause Analysis (Churn Category & Reason Breakdown)
------------------------------------------------------*/
SELECT churn_reason,COUNT(*) AS churned_customers,ROUND(COUNT(*) * 100.0 /SUM(COUNT(*)) OVER (),2) AS share_of_churn_pct
FROM v_clean_customer_data WHERE customer_status = 'churned'AND churn_reason <> 'Unknown'
GROUP BY churn_reason ORDER BY churned_customers DESC LIMIT 5;
---------------------------------------------------
-- Conditional Functions
---------------------------------------------------
-- Segment customers by tenure
select tenure_in_months,case when tenure_in_months<12 then 'New Customer' when tenure_in_months<24 then 'Regular Customer'
when tenure_in_months<36 then 'Loyal customer' else 'Very Loyal customer' end as Customer_segment from v_clean_customer_data;

-- Group customers by monthly charges.
select monthly_charge,case when monthly_charge<50 then 'low value' when monthly_charge<100 then 'Medium value'
 when monthly_charge<150 then 'High value' else 'Very Important' end as customer_group from v_clean_customer_data;
 -- churned customers
 select customer_status,if(customer_status='churned','Lost customer','Active customer') 
 as Churn_status from v_clean_customer_data;
---------------------------------------------------
-- SECTION 8 : VIEWS
---------------------------------------------------
-- Views
-- View 1 : Churned Customers
create view churn_customers as select * from v_clean_customer_data where customer_status='churned';
select * from churn_customers;

-- View 2 : Active Customers
create view Active_customers as select * from v_clean_customer_data where customer_status='stayed';
select * from active_customers;

-- View 3 : Senior Citizens
create view senior_citizens as select * from v_clean_customer_data where age>=60;
select * from senior_citizens;
-- View 4 : High Revenue Customers
select max(total_revenue) from v_clean_customer_data;
select min(total_revenue) from v_clean_customer_data;
create view High_revenue_customer as select * from v_clean_customer_data where total_revenue>5000;

-- View 5 : Fiber Optic Customers
create view Fiber_Optic_Customers as select * from v_clean_customer_data where internet_type='Fiber optic';
select * from Fiber_Optic_Customers;

-- View 6 : Month-to-Month Customers
create view Month_to_month_contract_customers as select * from v_clean_customer_data where Contract='month-to-month';
select * from Month_to_month_contract_customers;
--  -------------------------------------------------------