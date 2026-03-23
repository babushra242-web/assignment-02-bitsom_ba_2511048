
Part 1 — Relational Databases

## Anomaly Analysis

### Insert Anomaly
This scenario occurs when you can't add new data about a product unless it's linked to order. To put it simple, you can't record a product unless there's an order for it.

Example 1:
In row 45, CustomerName = "Ravi Kumar" but OrderID = NULL. The table structure won't let us store his details independently because everything needs to be tied to an order.

Example 2:
Say the company starts selling a Printer (P009) at ₹15,000 — there's literally nowhere to put that information until someone actually orders one. The table has no independent product information.

### Update Anomaly
This scenario is very frequently observed as the customer data like, address, contact no.,etc is changing everyday, sometimes even after the order is confirmed.
Here,When the same data is repeated across many rows, updating it becomes difficult and introduces errors. Updating one piece of information requires changes to many rows, and if some are missed, the data becomes inconsistent.

Example:
Sales rep SR01 (Deepak Joshi) has their office_address stored inconsistently across multiple rows:

At most places, his office address is stored as "Mumbai HQ, Nariman Point, Mumbai - 400021"
But rows for orders ORD1180 (row 39), ORD1173 (row 58), ORD1170 (row 91), etc. it is "Mumbai HQ, Nariman Pt, Mumbai - 400021" ( Point abbreviated as Pt).

Here, the address was partially updated or inconsistently entered across rows, and since the same rep's details repeat in every order they're linked to, a single address change requires updating dozens of rows.

### Delete Anomaly
This is when deleting a row to remove one piece of information destroys other unrelated information.
Example:
Product P008 (Webcam, Electronics, ₹2,100) appears in only once in the dataset at row 12, order ORD1185. If that order gets cancelled and someone deletes the row, all the information about the Webcam product is completely lost from the database, i.e., its name, category, and price would disappear entirely, even though the product itself still exists in the business.

## Normalization Justification

At first, keeping all information in one big table looks easy. You can see everything in one place and don’t have to think about links between tables. But when you look closely at the data in orders_flat.csv, the problems become clear. There are only a handful of customers, products, and sales reps, yet their details are repeated dozens of times. For example, Priya Sharma’s email and city are copied into 21 different rows. The Laptop product with code P001 and price ₹55,000 is written in 27 rows. This repetition is messy and risky.

The trouble starts when something changes. If Priya updates her email, you must edit 21 rows. If you miss even one, the file now shows two different emails for the same person. That is an update anomaly. The same happens with product prices: if the Laptop price changes, every row with that product must be updated.

Here,you cannot add a new product unless it is linked to an order. That means you cannot list items in your catalog before they are sold. This is an insert anomaly. And if you delete the only order for a customer, you lose all their details too, giving a case of delete anomaly.

Normalization fixes these issues by splitting the data into smaller tables like Customers, Products, Sales Representatives, Orders, and OrderDetails. Each piece of information is stored once and linked with keys. This avoids duplication, makes updates safe, and allows new records to be added without problems.Hence,Normalization is not over‑engineering; it is the practical way to keep data clean, consistent, and reliable.
