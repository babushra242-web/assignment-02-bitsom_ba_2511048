# Part 2 — NoSQL Subjective

## Database Recommendation

## Scenario: A healthcare startup is building a patient management system. One engineer recommends MySQL; another recommends MongoDB. Given ACID vs BASE and the CAP theorem, which would you recommend? Would your answer change for a fraud detection module?

---

### Recommendation: MySQL (RDBMS) for the Core Patient Management System

Q1: For a healthcare startup building a patient management system, should we use MySQL or MongoDB?  
Answer: In this case, MySQL makes more sense. Patient records are sensitive and must always be correct. MySQL follows the ACID rules, which guarantee that every update is stored properly and consistently. If a doctor changes a prescription, you don’t want half the system showing the old data and half showing the new;that could be dangerous. MongoDB is great for flexibility and scaling, but it works on eventual consistency, which means there can be short delays before all copies of the data match. For healthcare, that risk is too high.

Q2: How does the CAP theorem influence this decision?  
Answer: The CAP theorem says you can only fully guarantee two out of three things: Consistency, Availability, and Partition tolerance. MySQL leans toward consistency, while MongoDB leans toward availability. In healthcare, consistency is the priority. It’s better to have the system unavailable for a short time than to show wrong patient information. That’s why MySQL is the safer choice for the core patient system.

Q3: Would the recommendation change if the startup also needed a fraud detection module?  
Answer: Yes, here MongoDB could play a role. Fraud detection usually means analyzing huge amounts of logs, transactions, and patterns that don’t fit neatly into tables. MongoDB’s flexible schema and ability to scale quickly make it well suited for this type of work. The best approach would be to use MySQL for patient records where accuracy is critical, and MongoDB for fraud detection where speed and scalability matter more. That way, each database is used for what it does best.