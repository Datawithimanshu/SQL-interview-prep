# 🗄️ SQL JOIN Practice — Basic to Advanced

![SQL](https://img.shields.io/badge/SQL-MySQL-blue?style=for-the-badge&logo=mysql&logoColor=white)
![Level](https://img.shields.io/badge/Level-Beginner%20to%20Advanced-green?style=for-the-badge)
![Queries](https://img.shields.io/badge/Queries-20%2B-orange?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=for-the-badge)

A structured, hands-on SQL practice project covering **JOIN operations from Basic to Advanced** using realistic e-commerce data. Great for interview prep, portfolio building, and skill development.

---

## 📁 Project Structure

```
sql-join-practice/
│
├── sql_joins_practice.sql   ← All table creation, data & queries
└── README.md                ← This file
```

---

## 🗃️ Database Schema

### `customers` table
| Column | Type | Description |
|---|---|---|
| customer_id | INT (PK) | Unique customer identifier |
| customer_name | VARCHAR | Full name |
| email | VARCHAR | Email address |
| city | VARCHAR | City of residence |
| membership_tier | VARCHAR | Bronze / Silver / Gold |

### `orders` table
| Column | Type | Description |
|---|---|---|
| order_id | INT (PK) | Unique order identifier |
| customer_id | INT (FK) | References customers table |
| product_name | VARCHAR | Name of product ordered |
| category | VARCHAR | Electronics / Clothing / Appliances etc. |
| quantity | INT | Units ordered |
| unit_price | DECIMAL | Price per unit |
| order_date | DATE | Date of order |
| status | VARCHAR | Delivered / Shipped / Cancelled |

### `retail_sale` table
| Column | Type | Description |
|---|---|---|
| invoice_no | VARCHAR | Invoice identifier |
| stock_code | VARCHAR | Product stock code |
| description | VARCHAR | Product description |
| quantity | INT | Units sold |
| invoice_date | DATETIME | Date and time of sale |
| unit_price | DECIMAL | Price per unit |
| customer_id | INT | Customer identifier |
| country | VARCHAR | Country of sale |

---

## 📊 Sample Data

- **23 customers** across 8 cities (New York, London, Paris, Berlin, Tokyo, Sydney, Mumbai, Dubai)
- **40 orders** spanning Jan–Sep 2024
- **3 customers intentionally have no orders** — perfect for LEFT JOIN / Anti-Join practice
- Categories: Electronics, Clothing, Appliances, Sports, Health, Books
- Statuses: Delivered, Shipped, Cancelled

---

## 🧠 Concepts Covered

| Level | Topics |
|---|---|
| 🟢 Basic | INNER JOIN, LEFT JOIN, RIGHT JOIN, Anti-Join, WHERE filters |
| 🟡 Intermediate | GROUP BY + JOIN, HAVING, Self Join, Cross Join, Multi-table JOIN |
| 🔴 Advanced | Window Functions (RANK, PARTITION BY), Running Totals, CTEs, Correlated Subqueries, CASE statements |

---

## 📝 Query List

### 🟢 Basic
| # | Question |
|---|---|
| Q1 | Show all orders with customer name and city |
| Q2 | Show ALL customers including those with no orders |
| Q3 | Find customers who have NEVER placed an order |
| Q4 | List all Electronics orders with membership tier |
| Q5 | Show Delivered orders from London customers |

### 🟡 Intermediate
| # | Question |
|---|---|
| Q6 | Total amount spent by each customer |
| Q7 | Total orders and revenue per category |
| Q8 | Customers who spent more than $1000 |
| Q9 | Order count and revenue per membership tier |
| Q10 | All Cancelled orders with customer contact details |
| Q11 | Monthly revenue trend |
| Q12 | Self Join — customers from the same city |
| Q13 | Products bought by both Gold and Bronze tier customers |

### 🔴 Advanced
| # | Question |
|---|---|
| Q14 | Rank customers by total spending |
| Q15 | Rank customers by spending within each membership tier |
| Q16 | Each customer's most expensive single order |
| Q17 | Customers who spent above overall average |
| Q18 | Running total of revenue ordered by date |
| Q19 | First and latest order per customer using CTE |
| Q20 | Full report: spending label + rank + order count |

---

## 🚀 How to Run

1. Open your MySQL client (MySQL Workbench, DBeaver, or CLI)
2. Create a new database:
```sql
CREATE DATABASE sql_practice;
USE sql_practice;
```
3. Run the full `sql_joins_practice.sql` file
4. Start executing queries section by section

---

## 💡 Key Learnings

```sql
-- Anti Join Pattern (find customers with NO orders)
SELECT c.* FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Window Function (rank within group)
RANK() OVER (PARTITION BY membership_tier ORDER BY total_spent DESC)

-- CTE Pattern
WITH summary AS (
  SELECT customer_id, SUM(quantity * unit_price) AS total
  FROM orders GROUP BY customer_id
)
SELECT c.customer_name, s.total
FROM customers c JOIN summary s ON c.customer_id = s.customer_id;
```

---

## 🛠️ Tools Used

- **Database**: MySQL 8.0+
- **Concepts**: DDL, DML, JOIN operations, Aggregate Functions, Window Functions, CTEs, Subqueries

---

## 👤 Author

**[Your Name]**
- 💼 LinkedIn: [linkedin.com/in/yourprofile](https://linkedin.com/in/yourprofile)
- 🐙 GitHub: [github.com/yourusername](https://github.com/yourusername)

---

## ⭐ If this helped you

Give this repo a ⭐ and share it with others who are learning SQL!
