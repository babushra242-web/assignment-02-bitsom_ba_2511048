# Part 6 — Capstone Design Justification

## Storage Systems
To support the hospital’s four goals, I chose a mix of specialized storage systems tailored to each data type and use case:

1.Predicting readmission risk relies on structured historical treatment data. For this, I used a Data Warehouse (e.g., Snowflake or BigQuery) because it supports clean, schema-enforced data and integrates well with machine learning pipelines.

2.Doctor queries in plain English require semantic search across patient records. I used a Vector Database to store embeddings of patient history and enable natural language search.

3.Monthly reports for management are built from operational data like bed occupancy and department costs. This also fits well in the Data Warehouse, which supports OLAP-style queries and BI tools like Power BI or Tableau.

4.Real-time ICU vitals are streamed from monitoring devices. I used a Streaming Platform to ingest data, and a Time-Series Database to store and visualize vitals for dashboards and alerts.

This combination ensures each goal is supported by the most appropriate storage layer, balancing performance, scalability, and reliability.

## OLTP vs OLAP Boundary
The OLTP boundary ends at the hospital’s operational systems — EHRs, billing systems, and ICU monitors. These systems handle real-time transactions like patient check-ins, medication updates, and vitals streaming.

The OLAP boundary begins once data is extracted and transformed for analysis. Historical treatment data, operational metrics, and vitals are moved into the warehouse or lakehouse for reporting and modeling. The vector database also sits on the OLAP side, enabling semantic search over processed patient records.

This separation ensures transactional systems remain fast and reliable, while analytical systems can scale and support complex queries without affecting day-to-day operations.

## Trade-offs
One major trade-off in this design is latency vs consistency in real-time vitals monitoring. Streaming platforms prioritize speed, but may not guarantee immediate consistency across all systems. For example, a vitals alert might appear in the dashboard before it’s fully written to the time-series database.

To mitigate this, I recommend using event buffering and alert thresholds. Instead of triggering alerts on every data point, the system can wait for a short window (e.g., 5 seconds) and confirm anomalies across multiple readings. This reduces false positives and ensures alerts are based on stable data.

Additionally, using streaming connectors with exactly-once delivery (e.g., Kafka with transactional guarantees) helps maintain data integrity across systems.
By designing with these trade-offs in mind, the architecture remains both responsive and reliable which is highly critical for a hospital environment.