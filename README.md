# Hevo Assessment I

## Overview
This repository contains the deliverables for **Hevo Assessment I**, demonstrating a data pipeline from PostgreSQL to Snowflake, including data transformations for orders and customers.

---

## Steps to Reproduce

### 1. Snowflake Signup
- Created a free trial account at [snowflake.com](https://www.snowflake.com) on AWS US East.

### 2. Hevo Signup
- Activated a Hevo trial via Snowflake Partner Connect.

### 3. PostgreSQL Setup
- Installed PostgreSQL using Docker:

```bash
docker run -d --name postgres-hevo \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=your_password \
  postgres:latest
```

- Configured **logical replication** by setting the following in `postgresql.conf`:

```bash
wal_level = logical
max_replication_slots = 4
max_wal_senders = 4
```

- Exposed the local DB to Hevo using ngrok:

```bash
./ngrok tcp 5432
```

### 4. Table Creation & Data Load
- Created tables `customers`, `orders`, and `feedback` in PostgreSQL (see `sql/postgres_schema.sql`).  
- Copy CSV files to the Docker container:

```bash
docker cp ~/path/customers.csv hevo-postgres:/customers.csv
```

- Load data from CSVs using `\copy`:

```sql
\copy customers(id, first_name, last_name, email, address) 
FROM '/customers.csv' DELIMITER ',' CSV HEADER;
```

### 5. Hevo Pipeline
- Set up pipeline:  
  - **Source:** PostgreSQL  
  - **Destination:** Snowflake  
  - **Mode:** Logical Replication  
- **Pipeline ID:** 1

### 6. Transformations
- **Hevo Model 5:** Generated `order_events` table from `orders` status.  
- **Hevo Model 6:** Added `username` column to the existing `customers` table.

### 7. Verification
- Validated transformed data in Snowflake (see `sql/validation.sql`).

---

## Assumptions
- `status` in `orders` is a VARCHAR with values: `'placed'`, `'shipped'`, `'delivered'`, `'cancelled'`.  
- Emails in `customers` are valid (contain '@') for `username` derivation.

---

## PostgreSQL → Hevo Connection
- Exposed local PostgreSQL instance (port 5432) via ngrok.  
- Configured Hevo pipeline with ngrok host and port, and PostgreSQL credentials (stored securely outside the repo).

---

## Choices Made for Transformations
- Added `username` to the existing `customers` table instead of creating a new table (Hevo Model 6).  
- Created `order_events` as a separate table to map `status` to `event_type` for event-based analytics.

---

## Issues / Workarounds
- **Ngrok URL Changes:** Free ngrok tier regenerates URLs; manually updated Hevo pipeline source configuration when URL changed.

---

## Hevo Details
- **Name:** varsha2808  
- **Pipeline ID:** 1  
- **Model Numbers:** 5 & 6

---

## Loom Video
https://www.loom.com/share/5e43f39f88d24d10bac62d162843d49f

---

## Files
- `sql/postgres_schema.sql` — PostgreSQL DDL for table creation.  
- `sql/transformations.sql` — Hevo Model transformation scripts.  
- `sql/validation.sql` — Snowflake validation queries.  
- `csv_datasets/customers.csv`, `csv_datasets/orders.csv`, `csv_datasets/feedback.csv`, — Sample CSV data.
