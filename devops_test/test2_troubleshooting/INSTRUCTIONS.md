# DevOps Test 2 – Part 1 (Candidate Instructions)

## Goal

Start the Docker environment and verify that the backend application is running correctly.

When the backend is working as expected, an HTTP GET request to the root endpoint should return a JSON response similar to this:

```json
{
  "calculation_time_seconds": 2.07102404200009005,
  "message": "Welcome to Clawdbot",
  "pi": 3.1415916535897743
}
```

The exact values for `calculation_time_seconds` and `pi` may vary slightly between requests.

## Steps

1. From the `test2_troubleshooting` folder, start the services:

   ```bash
   docker compose up --build
   ```

2. Once the containers are running, call the backend root endpoint by opening this URL directly in your browser or using an HTTP client (Postman, Insomnia, etc.):

   http://localhost:8081/

3. Confirm that you receive a JSON response with:
  - A `message` field containing "Welcome to Clawdbot".
   - A `pi` field with a value close to π (around 3.14159...).
   - A `calculation_time_seconds` field indicating how long the calculation took.

This completes the first part of the test.

## Tips

- Open the frontend in your browser at:

  - http://localhost:8080

- The backend listens on:

  - http://localhost:8081

- After each code change you need to rebuild and restart the services so your changes take effect:

  ```bash
  docker compose up --build
  ```

# DevOps Test 2 – Part 2 (Performance / Resources)

## Goal

In this part, focus only on the **backend** service.
The PI calculation in the backend is intentionally slow.

Look tat this example:

```json
{
  "calculation_time_seconds": 2.07102404200009005,
  "message": "Welcome to Clawdbot",
  "pi": 3.1415916535897743
}
```

calculation_time_seconds is higher than 1s

Your goal is to **reduce the response time** of the backend endpoint that calculates PI.

## Take notes for what and why you did.
## We will discuss it later.