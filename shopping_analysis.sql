CREATE TABLE customer_shopping (
    customer_id INT PRIMARY KEY,
    age INT,
    gender VARCHAR(10),
    item_purchased VARCHAR(50),
    category VARCHAR(30),
    purchase_amount INT,
    location VARCHAR(50),
    size VARCHAR(5),
    color VARCHAR(20),
    season VARCHAR(10),
    review_rating NUMERIC(2,1),
    subscription_status VARCHAR(5),
    shipping_type VARCHAR(20),
    discount_applied VARCHAR(5),
    promo_code_used VARCHAR(5),
    previous_purchases INT,
    payment_method VARCHAR(20),
    frequency_of_purchases VARCHAR(20)
);

\copy customer_shopping FROM 'customer_shopping_behavior.csv' CSV HEADER;

-- Q1. Show the first 10 rows of the table.
SELECT * FROM customer_shopping LIMIT 10;

-- Q2. How many customers are there in total?
SELECT COUNT(*) AS total_customers FROM customer_shopping;

-- Q3. What are the different product categories?
SELECT DISTINCT category FROM customer_shopping;

-- Q4. How many review ratings are missing?
SELECT COUNT(*) AS null_ratings
FROM customer_shopping
WHERE review_rating IS NULL;

-- Q5. Fill the missing review ratings with the average rating.
UPDATE customer_shopping
SET review_rating = (SELECT ROUND(AVG(review_rating), 1) FROM customer_shopping)
WHERE review_rating IS NULL;

-- Q6. Remove the promo_code_used column because it is same as discount_applied.
ALTER TABLE customer_shopping DROP COLUMN promo_code_used;

-- Q7. What is the total revenue?
SELECT SUM(purchase_amount) AS total_revenue FROM customer_shopping;

-- Q8. What is the average purchase amount?
SELECT ROUND(AVG(purchase_amount), 2) AS avg_purchase FROM customer_shopping;

-- Q9. What are the highest and lowest purchase amounts?
SELECT
    MAX(purchase_amount) AS highest_purchase,
    MIN(purchase_amount) AS lowest_purchase
FROM customer_shopping;

-- Q10. Show all customers older than 50.
SELECT customer_id, age, gender, purchase_amount
FROM customer_shopping
WHERE age > 50;

-- Q11. Show all female customers who bought from the Clothing category.
SELECT customer_id, age, item_purchased, purchase_amount
FROM customer_shopping
WHERE gender = 'Female' AND category = 'Clothing';

-- Q12. How many customers used a discount?
SELECT COUNT(*) AS discount_customers
FROM customer_shopping
WHERE discount_applied = 'Yes';

-- Q13. Show the top 10 highest purchase amounts.
SELECT customer_id, item_purchased, purchase_amount
FROM customer_shopping
ORDER BY purchase_amount DESC
LIMIT 10;

-- Q14. How many customers are there for each gender?
SELECT gender, COUNT(*) AS total_customers
FROM customer_shopping
GROUP BY gender;

-- Q15. What is the total revenue for each category?
SELECT category, SUM(purchase_amount) AS total_revenue
FROM customer_shopping
GROUP BY category
ORDER BY total_revenue DESC;

-- Q16. What is the average spend in each season?
SELECT season, ROUND(AVG(purchase_amount), 2) AS avg_spend
FROM customer_shopping
GROUP BY season
ORDER BY avg_spend DESC;

-- Q17. Which 5 states generate the most revenue?
SELECT location, SUM(purchase_amount) AS total_revenue
FROM customer_shopping
GROUP BY location
ORDER BY total_revenue DESC
LIMIT 5;

-- Q18. Which categories have total revenue greater than 50000?
SELECT category, SUM(purchase_amount) AS total_revenue
FROM customer_shopping
GROUP BY category
HAVING SUM(purchase_amount) > 50000;

-- Q19. How many customers are subscribed and how many are not?
SELECT subscription_status, COUNT(*) AS total_customers
FROM customer_shopping
GROUP BY subscription_status;

-- Q20. Which 5 products have the highest average review rating?
SELECT item_purchased, ROUND(AVG(review_rating), 2) AS avg_rating
FROM customer_shopping
GROUP BY item_purchased
ORDER BY avg_rating DESC
LIMIT 5;

-- Q21. Divide customers into New (10 or less previous purchases), Returning (11 to 40) and Loyal (more than 40) and count each group.
SELECT
    CASE
        WHEN previous_purchases <= 10 THEN 'New'
        WHEN previous_purchases <= 40 THEN 'Returning'
        ELSE 'Loyal'
    END AS customer_segment,
    COUNT(*) AS total_customers
FROM customer_shopping
GROUP BY customer_segment;

-- Q22. What is the total revenue for each age group?
SELECT
    CASE
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56-70'
    END AS age_group,
    SUM(purchase_amount) AS total_revenue
FROM customer_shopping
GROUP BY age_group
ORDER BY total_revenue DESC;
