# Part 4 — Vector DB Reflection

## Vector DB Use Case
## Scenario: "A law firm wants to build a system where lawyers can search 500-page contracts by asking questions in plain English (e.g., 'What are the termination clauses?'). Would a traditional keyword-based database search suffice? Justify why or why not, and explain what role a vector database would play in this system."

------
### Would Keyword Search Suffice?

A traditional keyword based search would struggle in the scenario described. Contracts are long, complex documents where the same concept can be expressed in many different ways. For example, a termination clause might be written as “agreement may be dissolved under certain conditions” rather than using the exact word “termination.” A keyword search would miss this because it only matches literal words. Lawyers would then have to guess the right terms or manually scan hundreds of pages, which is inefficient and error‑prone.

### The Role of a Vector Database

This is where a vector database becomes valuable. Instead of storing just words, it stores embeddings — numerical representations of sentences that capture their meaning. When a lawyer asks a question in plain English, the system converts that query into an embedding and compares it to embeddings of contract passages. Even if the wording is different, the semantic similarity is recognized. So a query like “What are the termination clauses?” could match sections that talk about “ending the agreement” or “conditions for dissolution.”

The role of the vector database is to make this semantic search fast and scalable. It allows the system to handle thousands of pages and return the most relevant passages in seconds. In practice, this means lawyers spend less time digging through documents and more time analyzing the results. For a law firm, this is not just a convenience — it directly improves productivity and reduces the risk of missing critical clauses.