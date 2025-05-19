create database trlco_churn_dg;

CREATE TABLE customers (
    customerID VARCHAR(20) PRIMARY KEY,
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(3),
    Dependents VARCHAR(3),
    tenure INT,
    PhoneService VARCHAR(3),
    MultipleLines VARCHAR(20),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(20),
    OnlineBackup VARCHAR(20),
    DeviceProtection VARCHAR(20),
    TechSupport VARCHAR(20),
    StreamingTV VARCHAR(20),
    StreamingMovies VARCHAR(20),
    Contract VARCHAR(20),
    PaperlessBilling VARCHAR(3),
    PaymentMethod VARCHAR(50),
    MonthlyCharges FLOAT,
    TotalCharges VARCHAR(20),
    Churn VARCHAR(5)
);
SHOW VARIABLES LIKE 'secure_file_priv';
select * from customers limit 10;


#Total customers and churn rate
SELECT COUNT(*) AS total_customers FROM customers;

SELECT 
  Churn, COUNT(*) AS count,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customers), 2) AS percentage
FROM customers
GROUP BY Churn;

#Avg charges and tenure by churn
SELECT 
  Churn,
  ROUND(AVG(tenure), 2) AS avg_tenure,
  ROUND(AVG(MonthlyCharges), 2) AS avg_monthly,
  ROUND(AVG(CAST(TotalCharges AS DECIMAL(10,2))), 2) AS avg_total
FROM customers
GROUP BY Churn;
#Churn by contract type
SELECT 
  Contract,
  COUNT(*) AS total,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
  ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY Contract;
#Customer Segments
SELECT 
  customerID,
  Churn,
  tenure,
  MonthlyCharges,
  CASE
    WHEN Churn = 'Yes' THEN 'At Risk'
    WHEN Churn = 'No' AND tenure >= 24 THEN 'Loyal'
    WHEN Churn = 'No' AND tenure < 6 THEN 'Dormant'
    ELSE 'Neutral'
  END AS Segment
FROM customers;





