# Zomato_Sales_Project_SQL

---

# Zomato Dataset Analysis

This project contains SQL queries used to analyze a **Zomato restaurant dataset** with the following columns:

- `name`: Name of the restaurant
- `online_order`: Whether the restaurant accepts online orders (Yes/No)
- `book_table`: Whether the restaurant allows table bookings (Yes/No)
- `rate`: Rating of the restaurant
- `votes`: Number of votes the restaurant has received
- `approx_cost(for two people)`: Approximate cost for two people
- `listed_in(type)`: Type of listing (e.g., Fine Dining, Casual Dining, etc.)

## Table of Contents
1. [Objective](#objective)
2. [SQL Queries](#sql-queries)
3. [How to Run](#how-to-run)

## Objective

The goal of this project is to analyze the Zomato dataset using SQL queries and gain insights into restaurant trends, customer preferences, and the relationship between restaurant ratings, votes, and cost.

## SQL Queries

### 1. Total number of restaurants
```sql
SELECT COUNT(*) AS total_restaurants FROM zomato;
```

### 2. Number of unique restaurant names
```sql
SELECT COUNT(DISTINCT name) AS unique_restaurants FROM zomato;
```

### 3. Number of restaurants that accept online orders
```sql
SELECT online_order, COUNT(*) AS count FROM zomato GROUP BY online_order;
```

### 4. Number of restaurants that allow table booking
```sql
SELECT book_table, COUNT(*) AS count FROM zomato GROUP BY book_table;
```

### 5. Different types of restaurant listings
```sql
SELECT DISTINCT listed_in(type) FROM zomato;
```

### 6. Average rating of restaurants
```sql
SELECT AVG(rate) AS average_rating FROM zomato;
```

### 7. Top 10 highest-rated restaurants
```sql
SELECT name, rate, votes FROM zomato ORDER BY rate DESC LIMIT 10;
```

### 8. Number of restaurants in different rating categories
```sql
SELECT 
    CASE 
        WHEN rate >= 4.5 THEN 'Excellent (4.5 - 5.0)'
        WHEN rate >= 4.0 THEN 'Very Good (4.0 - 4.5)'
        WHEN rate >= 3.5 THEN 'Good (3.5 - 4.0)'
        WHEN rate >= 3.0 THEN 'Average (3.0 - 3.5)'
        ELSE 'Below Average (<3.0)'
    END AS rating_category,
    COUNT(*) AS restaurant_count
FROM zomato
GROUP BY rating_category;
```

### 9. Average cost for two people across all restaurants
```sql
SELECT AVG(`approx_cost(for two people)`) AS average_cost FROM zomato;
```

### 10. Percentage of restaurants offering online ordering in each listed_in(type) category
```sql
SELECT 
    listed_in(type), 
    SUM(CASE WHEN online_order = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS online_order_percentage
FROM zomato
GROUP BY listed_in(type);
```

### 11. Correlation between the number of votes and the rating of a restaurant
```sql
SELECT rate, votes 
FROM zomato
ORDER BY rate DESC;
```

Alternatively, for the correlation analysis:
```sql
SELECT rate, AVG(votes) AS average_votes 
FROM zomato 
GROUP BY rate
ORDER BY rate DESC;
```

---

## How to Run

1. **Clone this repository**:
   ```bash
   git clone https://github.com/your-username/zomato-dataset-analysis.git
   cd zomato-dataset-analysis
   ```

2. **Set up the database**:
   - Import the `zomato` dataset into your SQL database (MySQL, PostgreSQL, etc.).
   - Adjust the table and column names as per your dataset.

3. **Run the SQL queries**:
   - Use your preferred SQL client (e.g., MySQL Workbench, pgAdmin, etc.) to execute the queries above.
   - You can also use command-line tools to run the queries on your database.

4. **Analyze the results**:
   - Review the results of each query to gain insights into restaurant data trends.

---

## Contributing

Feel free to contribute by opening an issue or submitting a pull request if you have any improvements or suggestions.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
