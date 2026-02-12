# Test 3 - Postgres - Solution

The initial setup was done in the following order:

1. `sudo docker-compose --build` to setup the database.
2. `sudo docker exec -i postgres_final_test psql -U challenge -d challenge < populate.sql` to populate the database
3. `sudo docker exec -it postgres_final_test psql -U challenge -d challenge` to connect to the database

The strategy above keeps the environment self-contained, so there's no configuration done outside the container, but the external connectivity was validated using the following command and providing the `challenge` password:
`psql --host=localhost --port=5432 --username=challenge --password`

## Query Performance Baseline

Once the database was already populated and running the following script was executed to establish a baseline performance:

```sql
challenge=# \timing
challenge=# DO $$
BEGIN
  FOR i IN 1..100 LOOP
    PERFORM *
    FROM users u
    RIGHT JOIN addresses a
      ON a.user_id = u.id
    WHERE u.id = 42
    ORDER BY a.created_at DESC;
  END LOOP;
END;
$$;
```

The above ran for ~21.8 seconds total for 100 executions, which **averages 218 ms per execution**.

This performance suggests:

- The query is scanning far more data than necessary;
- The execution plan is not efficiently leveraging selectivity on user_id.
- The join and/or sort operations are expensive under current schema conditions (no supporting indexes).

## Query Performance Issues

Focusing on the query itself and ignoring issues with the schema for now, the main issue seem to be that the `RIGHT JOIN` is unnecessary since the `user_id` is already known so the join does not add information.

After the `RIGHT JOIN` runs the filter on the resulting joined table.

This query seems to be overcomplicated.

### Query Optimization

The goal of the query is clearly to return all addresses where user_id = 42, ordered by newest first.

To achieve the goal of the query the `RIGHT JOIN` can be entirely removed from the query.

The optimized version is available at [optimized_query.sql](optimized_query.sql).

### Optimized Query Performance Benchmark

The test with the already optimized query was done this way:

```sql
challenge=# \timing
challenge=# DO $$
BEGIN
  FOR i IN 1..100 LOOP
    PERFORM *
    FROM addresses
    WHERE user_id = 42
    ORDER BY created_at DESC;
  END LOOP;
END;
$$;
```

The above ran for ~21.7 seconds total for 100 executions, which **averages 217 ms per execution**.

This result is underwhelming, but there's still room for improvement on the schema.

## Schema Issues

The original schema provided seems to have a number of issues such as:

1. Neither table defines a PRIMARY KEY.
2. No Foreign Key Constraint;
3. No Index on addresses.user_id

### #1 Schema Optimization: Primary Keys

Even though BIGSERIAL exists, there is no PK.

To apply it to the existing database and to both tables, the script executed was this:

```sql
ALTER TABLE users
ADD CONSTRAINT users_pkey PRIMARY KEY (id);

ALTER TABLE addresses
ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);
```

Primary Keys are important enforce uniquenness, to improve planning on the postgresql side and to improve integrity.

A new test was executed after the PKs were configured but there's no visible gain so far (~21.7 secs for 100 executions).

### #2 Schema Optimization: Foreing Keys

This enforces referential integrity.

To apply it to the existing database , the script executed was this:

```sql
ALTER TABLE addresses
ADD CONSTRAINT addresses_user_id_fkey
FOREIGN KEY (user_id)
REFERENCES users(id)
ON DELETE CASCADE;
```

Cascade makes sure no orphan addresses remain upon user deletion.

A new test was executed after the FKs were configured but there's no visible gain so far (~21.7 secs for 100 executions).

### #3 Schema Optimization: Index on `user_id`

This should actually have the biggest performance gain.

To apply it to the existing database , the script executed was this:

```sql
CREATE INDEX idx_addresses_user_id
ON addresses (user_id);
```

A new test was executed after the index was configured and there's a massive improvement (~80 ms for 100 executions, AVG ~0.8 ms per request).

## Conclusion

The initial implementation performed poorly because the query structure and schema did not support the actual access pattern. Removing the unnecessary join simplified the query but did not significantly improve performance, as the main bottleneck was the lack of indxing on `addresses.user_id`.

The decisive improvement came from aligning the schema with the workload by adding an index on `user_id`. This reduced average execution time from ~218 ms per request to ~0.8 ms per request, demonstrating that proper indexing is the key factor in achieving scalable performance for highly selective queries on large datasets.
