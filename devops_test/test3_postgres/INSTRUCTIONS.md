# DevOps Test 3 – Postgres Query & Index Optimization

## Goal

Start a Postgres environment, generate a realistic data set, and optimize a query that returns all addresses for a given user.

You will work with two tables:
- `users`
- `addresses`

The environment and base schema are already provided.

---

## 1. Start the environment

From the `test3_postgres` folder, start Postgres:

```bash
docker compose up --build
```

Postgres will be available on:

- Host: `localhost`
- Port: `5432`
- Database: `challenge`
- User: `challenge`
- Password: `challenge`

You can connect using `psql` or any SQL client.

---

## 2. Inspect the schema

The database is initialized from `init/schema.sql` and contains:

```sql
CREATE TABLE users (
  id         BIGSERIAL,
  email      TEXT        NOT NULL,
    full_name  TEXT        NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE addresses (
  id         BIGSERIAL,
  user_id    BIGINT      NOT NULL,
    street     TEXT        NOT NULL,
    city       TEXT        NOT NULL,
    country    TEXT        NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

---

## 3. Generate test data

Create a realistic data set using SQL running **inside** the database.

**Requirements:**

- Insert at least **10,000 users** into `users`.
- Insert at least **1,000,000 addresses** into `addresses`.
- Ensure that **each user has at least 1000 addresses**.

You can use patterns like the following as a starting point (you are free to USE or change them):

```sql
BEGIN;

-- Optional: clear existing data and reset sequences
TRUNCATE TABLE addresses, users RESTART IDENTITY;

-- 10,000 users
-- created_at randomized within the last 5 years
INSERT INTO users (email, full_name, created_at)
SELECT
    'user' || i || '@example.com' AS email,
    'User ' || i                   AS full_name,
    now() - (random() * interval '5 years') AS created_at
FROM generate_series(1, 10000) AS s(i);

-- 1,000,000 addresses
-- 100 addresses per user
-- created_at randomized within the last 5 years
INSERT INTO addresses (user_id, street, city, country, created_at)
SELECT
    u.id                                  AS user_id,
    'Street ' || gs.addr_id              AS street,
    'City '   || ((gs.addr_id % 100) + 1) AS city,
    'Country'                             AS country,
    now() - (random() * interval '5 years') AS created_at
FROM users AS u
JOIN LATERAL generate_series(1, 1000) AS gs(addr_id) ON true;

COMMIT;
```

Make sure the final data set satisfies the requirements above.

---

## 4. Baseline query

A starting query is provided in `bad_query.sql`:

```sql
SELECT a.*
FROM users u
RIGHT JOIN addresses a
  ON a.user_id = u.id
WHERE u.id = 42
ORDER BY a.created_at DESC;
```
---

## 5. Your tasks

### Optimize the query and schema

Rewrite the query so that it is clearer and more efficient for the goal:

> Return all addresses for a given user, ordered by the most recent address first.

You are free to change everything, filters, structure of the query, and the schema itself, as long as it returns the correct result.


---

## 6. What to deliver

Provide the following artifacts:

1. `optimized_query.sql` with your final query that returns all addresses for a given user.
2. A short `README.md` or notes that include:
   - Why you chose your final query shape.
  - A brief summary of any schema or performance-related changes you made, commands and sql executed.
  - A brief summary of the **before vs. after** behavior or performance. Explain what is better now or not.
  
This completes the Postgres query and index optimization test.
