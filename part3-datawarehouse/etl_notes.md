Part 3 — ETL Notes

ETL Decisions

Decision 1 — Standardizing Date Formats

Problem:
The raw transactional file had dates written in different formats — some as DD/MM/YYYY, others as YYYY-MM-DD, and even DD-MM-YYYY. This inconsistency made it impossible to join data reliably on dates or group sales by month.
Resolution: During ETL, I converted all dates into a single format (YYYY-MM-DD). This ensured that the dim_date table could be populated consistently, and queries like month‑over‑month trends would work correctly.

Decision 2 — Fixing Category Casing

Problem:
Product categories were written inconsistently. For example, “electronics” appeared in lowercase, while “Electronics” appeared in proper case. Similarly, “Grocery” and “Groceries” were both used. This inconsistency would split the same category into multiple groups in reports.
Resolution: I standardized all category names to a single, consistent format: “Electronics,” “Clothing,” and “Groceries.” This way, aggregation queries by category produce accurate totals without duplication.

Decision 3 — Handling Missing Store Information

Problem:
Some rows had missing values for store city, even though the store name was present. Without fixing this, the dim_store table would have incomplete records, and reports by city would be inaccurate.
Resolution: I filled in missing city values by mapping them from the store name (e.g., “Mumbai Central” → “Mumbai”). This ensured that every store record had both a name and a city, making the dimension table complete and reliable.