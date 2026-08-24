/*==============================================================================
SECTION 7 : BUSINESS QUESTIONS
==============================================================================*/
-- Q1. What is the overall churn rate?
-- Answer:
-- The overall customer churn rate is 26.99%, meaning nearly 27 out of every
-- 100 customers have discontinued the service.

-- Q2. what is the monthly loss after losing customers?
-- The overall monthly loss is 126891 after losing customers

-- Q3. what is the total loss after losing customers?
-- The total loss 2657092 after losing customers

-- Q4. Which contract type has the highest churn?
-- Answer:
-- Customers with Month-to-Month contracts have the highest churn, with
-- 1,529 churned customers and churned rate is 46.53. This suggests that customers without long-term
-- contracts are significantly more likely to leave.

-- Q5. Which payment method has the highest churn?
-- Answer:
-- Customers using Bank Withdrawal have the highest churn, with
-- 1,231 churned customers. This payment method accounts for approximately
-- 71.7% of all churned customers in this category.

-- Q6. Which internet service has the highest churn?
-- Answer:
-- Customers who subscribed to Internet Service recorded the highest churn,
-- with 1,623 churned customers. This indicates that internet-related services
-- play a major role in customer churn.

-- Q7. Do senior citizens churn more?
-- Answer:
-- The Non-Senior Citizen group accounts for the majority of customers (65.82%) and 
-- also contributes the majority of total churned customers (65.82%, 1,140 customers). 
-- However, the Senior Citizen group has a higher churn rate, with 36.14% of senior customers churning 
-- compared with 23.85% among non-senior customers. This indicates that senior citizens are more likely 
-- to churn proportionally, even though non-senior customers generate a larger absolute number of churned customers.

-- Q8. Does gender affect churn?
-- Answer:
-- Gender has very little impact on customer churn. Female customers have only
-- about a 1% higher churn rate than male customers, indicating gender is not
-- a significant factor influencing churn.

-- Q9. Which customer pays the highest monthly charge?
-- Answer:
-- Customer ID '42152-DEL' has the highest monthly charge in the dataset.

-- Q10. Which customer stayed the longest?
-- Answer:
-- Customer ID '11290-JAM' has the highest tenure, indicating the longest
-- customer relationship in the dataset.

-- Q11. Which service contributes most to churn?
-- Answer:
-- Customers using Internet Service account for the highest number of churned
-- customers (1,623), making it the service category with the greatest
-- contribution to customer churn.

-- Q12. Which customer segment has the highest churn?
-- Answer:
-- New Customers (Tenure < 12 months) have the highest churn, with
-- 631 churned customers. This suggests that most customer attrition occurs
-- during the early stages of the customer lifecycle.

-- Q13. which state have the highest churn customers?
-- Answer:
-- Jammu & Kashmir represents a critical high-risk region for customer retention, 
-- exhibiting the highest state-wise churn rate at 57.19%. It is followed by 
-- Assam (38.13%) and Jharkhand (34.51%), indicating that localized retention 
-- strategies are urgently needed in these top-tier churn states.

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
/*==============================================================================
SECTION 9 : KPI QUERIES
==============================================================================*/

-- KPI 1 : Total Customers
	select count(*) as total_customer from v_clean_customer_data;

-- KPI 2 : Churn Customers
	select count(*) as churn_customer from v_clean_customer_data where customer_status='churned';
-- KPI 3 : Active Customers
	select count(*) as Active_customer from v_clean_customer_data where customer_status='stayed';
-- KPI 4 : Churn Rate
	select round(count(*)*100.0/(select count(*) from v_clean_customer_data ),2) 
    as churn_rate from v_clean_customer_data where customer_status='churned';
    
-- KPI 5 : Average Monthly Charges
	select round(avg(monthly_charge),2) as Average_Monthly_Charges from v_clean_customer_data;
-- KPI 6 : Average Tenure
	select round(avg(tenure_in_months),2) as Avg_Tenure from v_clean_customer_data;
-- KPI 7 : Average Total Charges
select round(avg(total_charges),2) as avg_total_charges from v_clean_customer_data;
/*******************************************************************************/
/*==============================================================================
SECTION 10 : DASHBOARD DATASET
==============================================================================*/

-- Query 1 : Customer Summary
-- Total Customers,Churned Customers,Active Customers,Churn Rate
select count(*) as total_customers,
	sum(case when customer_status='churned' then 1 else 0 end) as churned_customers,
	sum(case when customer_status='stayed' then 1 else 0 end) as Active_customers,
    round(sum(case when customer_status='churned' then 1 else 0 end)*100.0/count(*),2)
    as churn_rate from v_clean_customer_data
    ;
-- Query 2 : Contract Analysis
select contract,count(*) as total_customers,
sum(case when customer_status='churned' then 1 else 0 end) as churned_customers,
sum(case when customer_status='stayed' then 1 else 0 end) as Active_customers,
round(sum(case when customer_status='churned' then 1 else 0 end)*100.0/count(*),2) as churn_rate 
 from v_clean_customer_data group by contract;
 
 -- Advanced Query : Top 3 Highest Monthly Spenders by Contract Type using Window Function
WITH Ranked_Customers AS (SELECT customer_id,contract,monthly_charge,total_revenue,customer_status,
DENSE_RANK() OVER (PARTITION BY contract ORDER BY monthly_charge DESC) AS charge_rank FROM v_clean_customer_data
)SELECT customer_id,contract,monthly_charge,total_revenue,customer_status,charge_rank 
from Ranked_Customers where charge_rank <= 3;

-- Query 3 : Internet Service Analysis
select internet_type,count(*) as Totla_customers,
sum(case when customer_status='churned' then 1 else 0 end) as Churned_Customers,
round(sum(case when customer_status='churned' then 1 else 0 end)*100.0/count(*),2) as Churn_Rate_pct
from v_clean_customer_data group by Internet_type;

-- Query 4 : Payment Method Analysis
select payment_method,count(*) as total_customers,
sum(case when customer_status='churned' then 1 else 0 end) as Churn_customers,
sum(case when customer_status='stayed' then 1 else 0 end) as Active_customers,
round(sum(case when customer_status='churned' then 1 else 0 end)*100.0/count(*),2) as churn_rate 
from v_clean_customer_data group by payment_method;
-- Query 5 : Monthly Charges Analysis
select case when monthly_charge<50 then 'Low' 
when monthly_charge<100 then 'Medium' else 'High'end as Month_charge_Group,count(*) as Total_Customers,
sum(case when customer_status='churned' then 1 else 0 end) as Churned_customers,
sum(case when customer_status='stayed' then 1 else 0 end) as Active_customers from 
v_clean_customer_data group by Month_charge_Group;

-- Query 6 : Tenure Analysis
select max(tenure_in_months) from v_clean_customer_data;
select case when tenure_in_months<12 then'0-12 Months' when tenure_in_months<24
then '13-24 Months' when tenure_in_months<36 then '25-48 Months' else '49+' end as Customer_Type,count(*) as Total_Customers,
sum(case when customer_status='churned' then 1 else 0 end) as Churned_customers,
sum(case when customer_status='stayed' then 1 else 0 end) as Active_customers,
round(sum(case when customer_status='churned' then 1 else 0 end)*100.0/count(*),2) 
as Churn_Rate from v_clean_customer_data group by customer_type;
-- Query 7 : Gender Analysis
select gender, count(*) as Total_customers ,
sum(case when customer_status='churned' then 1 else 0 end) as Churned_customers,
round(sum(case when customer_status='churned' then 1 else 0 end)*100.0/count(*),2) 
as churn_rate from v_clean_customer_data group by gender;

/*******************************************************************************/
/*==============================================================================
SECTION 11 : BUSINESS INSIGHTS
==============================================================================*/

-- Insight 1 (Contract Duration Risk):
-- Month-to-Month contracts represent the single largest churn vector (88.28% of total churned users).
-- Customers without annual commitments show significantly higher attrition within the first 60-90 days.

-- Insight 2 (Internet Service Vulnerability):
-- Fiber Optic users exhibit a disproportionately high churn rate compared to DSL subscribers, 
-- indicating potential service outages, high price sensitivity, or competitive pressure in high-tier plans.

-- Insight 3 (Early Lifecycle Vulnerability):
-- Customer attrition peaks during early tenure (<12 months), accounting for over 36% of all churn.
-- Once a customer crosses the 24-month mark, churn drops dramatically, highlighting the need for onboarding retention.

-- Insight 4 (Payment Method Risk Correlation):
-- Customers using manual Bank Withdrawals and Electronic Checks show a high concentration of churn, 
-- whereas automated Credit Card and Direct Debit customers exhibit much higher retention.

-- Insight 5 (Gender Neutrality):
-- Gender shows less than 1% variance in churn rate, confirming that marketing retention spend 
-- should NOT be segmented by gender, but rather by tenure, service type, and contract duration.

/*******************************************************************************/

/*==============================================================================
SECTION 12 : BUSINESS RECOMMENDATIONS
==============================================================================*/

-- Recommendation 1: Strategy: Launch an automated "Month-2 Conversion Campaign" offering a 10% monthly discount 
-- or a free speed upgrade for Month-to-Month users who convert to a 12-month contract.
-- Target Metric: Reduce Month-to-Month churn by 15% within 2 quarters.

-- Recommendation 2: Fiber Optic Onboarding & Technical Support
-- Strategy: Offer complimentary Premium Tech Support for the first 90 days to all new Fiber Optic subscribers 
-- and institute proactive network monitoring to address service disruptions before customer complaints occur.
-- Target Metric: Increase 1st-year Fiber Optic retention by 20%.

-- Recommendation 3: Auto-Pay Discount Incentive
-- Strategy: Introduce a $2–$5 monthly bill credit for customers who switch from manual Bank Withdrawal/Electronic Check 
-- to automated Credit Card/Debit recurring payments.
-- Target Metric: Shift 30% of manual billing users to auto-pay to lower payment-failure-driven churn.

-- Recommendation 4: Early Lifecycle Loyalty Milestones
-- Strategy: Implement a "6-Month Loyalty Reward" (e.g., free streaming add-on for 1 month) 
-- to boost engagement during the highest-risk tenure window (Months 0-12).
-- Target Metric: Lower early-tenure churn rate from 36% down to under 25%.

-- Recommendation 5: Data-Driven Resource Allocation
-- Strategy: Shift retention marketing budget away from demographic targeting (such as gender) 
-- and reallocate 100% of the budget toward high-risk product segments (Fiber Optic + Month-to-Month + Manual Payment).

-- 	problem 1: Competitor had better devices — 289 customers 

-- Recommendation 6:  Device Upgrade Loyalty Program: High-value/tenured customers ke liye hardware upgrades 
-- (e.g., WiFi-6 routers, latest 5G modems) free ya discounted rates par introduce karein.
-- Trade-in / Buyback Offers: Old hardware ko trade-in karke new hardware par monthly bill discount offer karein.
-- Hardware Bundling: Long-term contracts (12/24 months) lock-in karne ke liye zero-cost device upgrades promise karein

-- Problem 2: Customers are finding better pricing or promotional offers from competitors.

-- Recommendation 7: Proactive Risk Scoring & Matching: AI/Data models se high-risk churn customers
-- identify karke unhe competitive renewal discounts auto-suggest karein.
-- Retention / Save Offers: Support & cancellation team ke paas tailored "Save Plans" hon 
-- (e.g., temporary 20% discount for 6 months ya free add-on services).
-- Value-Add Bundles: Price cut karne ke bajaye extra services introduce karein 
-- (e.g., OTT subscriptions, security software) jisse total product value high lage.

-- Problem 3: Attitude of support person — 208 customers

-- •  Recommendation 8: Provide customer-service communication training. 
-- •  Train employees in empathy, patience and problem resolution. 
-- •  Monitor customer-support interactions. 
-- •  Introduce customer satisfaction (CSAT) surveys after support interactions. 
-- •  Identify support agents/teams receiving consistently poor feedback. 
-- •  Reward employees with consistently high customer satisfaction.

--  Problem 4: The company doesn't know why these customers churned.

-- • Recommendation 9: Add a mandatory churn reason during cancellation. 
-- •  Conduct short exit surveys. 
-- •  Allow customers to select multiple reasons. 
-- •  Follow up with high-value churned customers. 
-- •  Standardize churn-reason categories. 
-- •  Track "Other/Don't know" as a data-quality KPI.
-- Incentivize Exit Feedback: Cancellation ke waqt detailed feedback dene par small incentive 
-- (e.g., Amazon gift card / final bill credit) offer karein taaki accurate data capture ho sake.

-- Problem 5: Customers believe competitors provide better data value.

-- •  Recommendation 10: Plan Restructuring (Data Tiering): Market benchmarking karke base-plan 
--    data limits badhayein ya Data Rollover feature introduce karein.
-- •  Uncapped / Unlimited Tier Add-ons: High-data consumers ke liye small incremental fee
--    (e.g., ₹99/month extra) par Unlimited/Top-up Data add-ons offer karein.
-- •  Usage Alert & Auto-Boost: Jab customer apna 80-90% monthly quota finish kare, 
--    toh app par extra bonus data claim karne ka dynamic push notification bhejein.


/*==============================================================================
                            END OF PROJECT
==============================================================================*/