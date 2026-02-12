# DevOps Test 2 – Part 1 (Candidate Instructions)

## Goal

Start the Docker environment and verify that the backend application is running correctly.

When the backend is working as expected, an HTTP GET request to the root endpoint should return a JSON response similar to this:

```json
{
  "calculation_time_seconds": 2.07102404200009005,
  "message": "Welcome to the backend service",
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
  - A `message` field containing "Welcome to the backend service".
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

Look at this example:

```json
{
  "calculation_time_seconds": 2.07102404200009005,
  "message": "Welcome to the backend service",
  "pi": 3.1415916535897743
}
```

calculation_time_seconds is higher than 1s

Your goal is to **reduce the response time** of the backend endpoint that calculates PI.

## Take notes for what and why you did.

Before any optimization was done  a benchmark test was executed and the rsults are available at [`benchmark_results/baseline.txt`](./benchmark_results/baseline.txt).

**The pre-optimization test reached an average of 2.8867 secs in a sample of 100 requests.**

### #1 REMOVE `2 * i + 1` and the index (`i`) from the loop

Stop recalculating the odd number each time and just keep adding 2 to get the next one.

**Results:**
- **NEW AVG:** 2.5452 secs for 100 requests
- **IMPROVEMENT:** ~11.8% faster
- **Full Test:** [`benchmark_results/post-optimization-1.txt`](./benchmark_results/post-optimization-1.txt)
- **Single Request Response:** `{"calculation_time_seconds":1.7019320380004501,"message":"Welcome to the backend service","pi":3.1415916535897743}`

### #2 RUN TWO ITERATIONS at a time

Combine one positive and one negative term in the same loop to cut the loop count in half.

**Results:**
- **NEW AVG:** 1.9055 secs for 100 requests
- **IMPROVEMENT:** ~34.0% faster
- **Full Test:** [`post-optimization-2.txt`](./benchmark_results/post-optimization-2.txt)
- **Single Request Response:** `{"calculation_time_seconds":1.4014916229989467,"message":"Welcome to the backend service","pi":3.1415916535897743}`

### #3 REMOVE the multiplication by 4

Apply the 4 factor inside each step instead of multiplying once at the end to remove one extra operation.

**Results:**
- **NEW AVG:** 1.8055 secs for 100 requests
- **IMPROVEMENT:** ~37.5% faster
- **Full Test:** [`post-optimization-2.txt`](./benchmark_results/post-optimization-3.txt)
- **Single Request Response:** `{"calculation_time_seconds":1.2733595919999061,"message":"Welcome to the backend service","pi":3.1415916535899084}`

---

### A DIFFERENT APPROACH: REPLACE CPython Interpreter with PyPy - NO CODE CHANGES

Run the original code on PyPy so its JIT compiler makes the loop faster automatically.

**Results:**
- **NEW AVG:** 0.3879 secs for 100 requests
- **IMPROVEMENT:** ~86.6% faster
- **Full Test:** [`benchmark_results/post-optimization-pypy-1.txt`](./benchmark_results/post-optimization-pypy-1.txt)
- **Single Request Response:** `{"calculation_time_seconds":0.006822289000410819,"message":"Welcome to the backend service","pi":3.1415916535897743}`

### A DIFFERENT APPROACH: REPLACE CPython Interpreter with PyPy - WITH ALL CODE CHANGES

Use PyPy plus all of the code optimizations so both the code and the interpreter work together for maximum speed.

**Results:**
- **NEW AVG:** 0.2391 secs for 100 requests
- **IMPROVEMENT:** ~91.7% faster
- **Full Test:** [`benchmark_results/post-optimization-pypy-2.txt`](./benchmark_results/post-optimization-pypy-2.txt)
- **Single Request Response:** `{"calculation_time_seconds":0.003397180000320077,"message":"Welcome to the backend service","pi":3.1415916535899084}`

---

### Conclusion

Micro-optmizations provided a moderate improvement (~37%).

Switching to PyPy produced the largest performance gain (~86–92%).

Combining PyPy with optimized code reduced the average time from 2.89s to 0.24s, roughly a 12x overall speed increase.

---

### Another smaller fix

Whenever the request was made from the frontend the result would be:
`Error calling backend: TypeError: NetworkError when attempting to fetch resource.`

So to fix what seemed to be a CORS issue, two adjustments were done:

**app.py before**
```python
import time
from flask import Flask, jsonify, make_response, request

app = Flask(__name__)
```

**app.py after**
```python
import time
from flask import Flask, jsonify, make_response, request
from flask_cors import CORS

app = Flask(__name__)

CORS(app)
```

**flask-cors added to requirements.txt**
```text
flask-cors==6.0.2
```

To know which flask-cors version to use the command used was:
``pip index versions Flask-Cors``

The fixes seem to have fixed the issue.

## We will discuss it later.
