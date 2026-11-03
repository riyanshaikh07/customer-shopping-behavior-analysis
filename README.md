# Customer Shopping Behavior Analysis

End-to-end analysis of a retail customer shopping dataset using SQL, Python and Power BI.

## Dataset
- 3,900 customers, 18 columns
- Details: age, gender, item purchased, category, purchase amount, season, review rating, subscription status, shipping type, discount applied, previous purchases, payment method, purchase frequency

## Tools Used
- PostgreSQL (data cleaning and analysis)
- Python (pandas, matplotlib)
- Power BI (dashboard)

## Data Cleaning
- Filled 37 missing review ratings with the average rating
- Dropped promo_code_used because it was identical to discount_applied
- Renamed columns to snake_case

## Key Insights
- Total revenue is about $233K with an average order value of about $59.8
- Male customers make up 68% of the customer base
- Clothing is the top category by orders and revenue
- Fall has the highest revenue among all seasons
- Only 27% of customers are subscribers
- 765 customers have more than 40 previous purchases (Loyal segment)
- Average spend is almost the same across most segments

## Files
- Customer.pbix : Power BI dashboard
- shopping_analysis.sql : 22 SQL questions with solutions
- shopping_analysis.py : same analysis in Python with charts
- customer_shopping_behavior.csv : dataset
