#Q2 Find the average age of churned customers
SELECT 
    AVG(Age) AS Average_Age_Churned_Customers
FROM cc;

#Q3 Discover the most common contract types among churned customers
SELECT 
    Contract, 
    COUNT(Age) AS ChurnedCustomerCount
FROM 
    cc
GROUP BY 
    Contract
ORDER BY 
    ChurnedCustomerCount DESC;
    
####  
ALTER TABLE customer_churn
MODIFY COLUMN `Total Charges` INT;
####
        
#Q11  Identify the average total charges for customers grouped by gender and marital status
SELECT 
    Gender,
    Married,
    AVG	(`Total Charges`) AS AvgTotalCharges
FROM 
    customer_churn
GROUP BY 
    Gender, 
    Married
ORDER BY 
    Gender, 
    Married;
    
select* from cc;
SHOW COLUMNS FROM customer_churn;


#Q12 Calculate the average monthly charges for different age groups among churned customers

 SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        WHEN Age BETWEEN 56 AND 65 THEN '56-65'
        ELSE '66 and above' 
    END AS AgeGroup,
    AVG(`Monthly Charge`) AS AverageMonthlyCharges
FROM 
    cc
GROUP BY 
    AgeGroup
ORDER BY 
    MIN(Age);
    
    
    
#Q27 Stored Procedure to Calculate Churn Rate
DELIMITER //

CREATE PROCEDURE CalculateChurnRate()
BEGIN
    DECLARE total_customers INT;
    DECLARE churned_customers INT;
    DECLARE churn_rate DECIMAL(5, 2);

    
    SELECT COUNT(*) into total_customers
    FROM customer_churn;

    
    SELECT COUNT(*) INTO churned_customers
    FROM customer_churn
    WHERE `Customer Status` = 'churned';

    -- Calculate the churn rate
    IF total_customers > 0 THEN
        SET churn_rate = (churned_customers / total_customers) * 100;
    ELSE
        SET churn_rate = 0; -- Handle case where there are no customers
    END IF;

    -- Return the results
    SELECT total_customers AS TotalCustomers,
           churned_customers AS ChurnedCustomers,
           churn_rate AS ChurnRate;
END //

DELIMITER ;

CALL CalculateChurnRate();





