# Hevo Data Assessment I

## Overview
This repository contains deliverables for **Hevo Assessment I**, demonstrating a data pipeline from PostgreSQL to Snowflake with basic transformations using Hevo Data.

## Steps to Reproduce

1. **Snowflake Setup**
   - Created a free trial account on Snowflake (AWS region).
   - Set up a database/schema for this assessment.

2. **Hevo Setup**
   - Activated free Hevo trial via Snowflake Partner Connect.
   - Logged in and created a new pipeline.

3. **PostgreSQL Setup**
   - Installed PostgreSQL locally (Docker):
     ```bash
     docker run -d --name hevo-postgres -p 5432:5432 -e POSTGRES_PASSWORD=your_password postgres
     ```
   - Exposed local database to Hevo using `ngrok`:
     ```bash
     ./ngrok tcp 5432
     ```

4. **Schema & Data Load**
   - Created tables `customers`, `orders`, and `feedback` using provided DDL files.
   - Loaded CSV data with `\copy` commands.

5. **Hevo Pipeline**
   - Set PostgreSQL as source (Logical Replication).
   - Snowflake as destination.
   - Pipeline executed and data loaded.

6. **Transformations**
   - Created Hevo Model for `order_events` mapping statuses to event types.
   - Added derived `username` to `customers` extracted from `email`.

7. **Verification**
   - Validated transformed tables in Snowflake using SQL queries.

## Assumptions
- `status` column in `orders` was implemented as `varchar`.
- All emails contain an “@” for username extraction.
- Dates and enums were handled with fallback defaults.

## How Postgres Was Connected to Hevo
- Used ngrok to expose the local Postgres instance on a public host.
- Configured Hevo source with host, port, user, and password securely.

## Transformations & Choices
- Created `order_events` model in Hevo using SQL SELECT logic.
- Derived `username` from `email` via `SPLIT_PART`.
- Used Snowflake `COALESCE` and string operations for cleaning.

## Issues & Workarounds
- Ngrok dynamic URLs required updating source configuration.
- Initially set Primary Key caused dropped duplicates — removed PK and reloaded.

## Hevo Details
- Hevo Account Name: *YOUR NAME*
- Pipeline ID: *PIPELINE ID*
- Models: 5 & 6

## Files Included
- `sql/postgres_schema.sql` — Postgres DDL files.
- `data/` — CSV sample data or links.
- `sql/transformations.sql` — Hevo Model SQL scripts.
- `sql/validation.sql` — Verification queries.

## Loom Video

