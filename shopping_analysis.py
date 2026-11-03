import pandas as pd

df = pd.read_csv("customer_shopping_behavior.csv", encoding="utf-8-sig")

df.columns = (
    df.columns.str.strip()
    .str.lower()
    .str.replace(r"\s*\(usd\)", "", regex=True)
    .str.replace(" ", "_")
)

print("Q1. Show the first 10 rows of the table.")
print(df.head(10))

print("\nQ2. How many customers are there in total?")
print(len(df))

print("\nQ3. What are the different product categories?")
print(df["category"].unique())

print("\nQ4. How many review ratings are missing?")
print(df["review_rating"].isnull().sum())

print("\nQ5. Fill the missing review ratings with the average rating.")
df["review_rating"] = df["review_rating"].fillna(round(df["review_rating"].mean(), 1))
print(df["review_rating"].isnull().sum())

print("\nQ6. Remove the promo_code_used column because it is same as discount_applied.")
df = df.drop(columns=["promo_code_used"])
print(df.columns.tolist())

print("\nQ7. What is the total revenue?")
print(df["purchase_amount"].sum())

print("\nQ8. What is the average purchase amount?")
print(round(df["purchase_amount"].mean(), 2))

print("\nQ9. What are the highest and lowest purchase amounts?")
print(df["purchase_amount"].max(), df["purchase_amount"].min())

print("\nQ10. Show all customers older than 50.")
print(df[df["age"] > 50][["customer_id", "age", "gender", "purchase_amount"]])

print("\nQ11. Show all female customers who bought from the Clothing category.")
print(
    df[(df["gender"] == "Female") & (df["category"] == "Clothing")][
        ["customer_id", "age", "item_purchased", "purchase_amount"]
    ]
)

print("\nQ12. How many customers used a discount?")
print((df["discount_applied"] == "Yes").sum())

print("\nQ13. Show the top 10 highest purchase amounts.")
print(df.nlargest(10, "purchase_amount")[["customer_id", "item_purchased", "purchase_amount"]])

print("\nQ14. How many customers are there for each gender?")
print(df["gender"].value_counts())

print("\nQ15. What is the total revenue for each category?")
print(df.groupby("category")["purchase_amount"].sum().sort_values(ascending=False))

print("\nQ16. What is the average spend in each season?")
print(df.groupby("season")["purchase_amount"].mean().round(2).sort_values(ascending=False))

print("\nQ17. Which 5 states generate the most revenue?")
print(df.groupby("location")["purchase_amount"].sum().sort_values(ascending=False).head(5))

print("\nQ18. Which categories have total revenue greater than 50000?")
category_revenue = df.groupby("category")["purchase_amount"].sum()
print(category_revenue[category_revenue > 50000])

print("\nQ19. How many customers are subscribed and how many are not?")
print(df["subscription_status"].value_counts())

print("\nQ20. Which 5 products have the highest average review rating?")
print(df.groupby("item_purchased")["review_rating"].mean().round(2).sort_values(ascending=False).head(5))

print("\nQ21. Divide customers into New (10 or less previous purchases), Returning (11 to 40) and Loyal (more than 40) and count each group.")
df["customer_segment"] = pd.cut(
    df["previous_purchases"],
    bins=[0, 10, 40, df["previous_purchases"].max()],
    labels=["New", "Returning", "Loyal"],
)
print(df["customer_segment"].value_counts())

print("\nQ22. What is the total revenue for each age group?")
df["age_group"] = pd.cut(
    df["age"],
    bins=[17, 25, 35, 45, 55, 70],
    labels=["18-25", "26-35", "36-45", "46-55", "56-70"],
)
print(df.groupby("age_group", observed=True)["purchase_amount"].sum().sort_values(ascending=False))

import matplotlib.pyplot as plt

age_spend = df.groupby("age")["purchase_amount"].mean()
plt.figure(figsize=(10, 5))
plt.plot(age_spend.index, age_spend.values, marker="o", color="#4c72b0")
plt.title("Average Spend by Age")
plt.xlabel("Age")
plt.ylabel("Average Purchase Amount (USD)")
plt.grid(alpha=0.3)
plt.tight_layout()
plt.savefig("age_vs_avg_spend.png", dpi=150)
plt.show()

season_order = ["Spring", "Summer", "Fall", "Winter"]
season_revenue = df.groupby("season")["purchase_amount"].sum().reindex(season_order)
plt.figure(figsize=(8, 5))
plt.plot(season_revenue.index, season_revenue.values, marker="o", color="#dd8452")
plt.title("Revenue by Season")
plt.xlabel("Season")
plt.ylabel("Total Revenue (USD)")
plt.grid(alpha=0.3)
plt.tight_layout()
plt.savefig("season_revenue.png", dpi=150)
plt.show()
