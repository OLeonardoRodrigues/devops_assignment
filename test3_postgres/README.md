# DevOps Assignment – Overview

This assignment is composed of three independent tests. You do not need to solve them in a specific order, but each one focuses on a different area.

## Test 1 – Terraform

- Work with infrastructure-as-code using Terraform.
- Understand and modify a simple cloud/infrastructure definition.
- Show how you structure and reason about infrastructure changes.

See the instructions in the `test1_terraform` folder for full details.

## Test 2 – Docker Troubleshooting

- Work with a small Docker-based frontend/backend setup.
- Start the environment, verify that the backend behaves as expected, and then improve its behavior.
- Show how you investigate and fix issues in a containerized application.

See the instructions in the `test2_troubleshooting` folder for full details.

## Test 3 – Postgres Query & Index Optimization

This test focuses on working with a real Postgres instance, a non-trivial amount of data.

### What this test is about

- Spinning up and using a containerized Postgres database.
- Understanding and using a given schema (`users` and `addresses`).
- Generating a realistic data set with meaningful volume.
- Working with a query that returns all addresses for a given user.
- Making changes so that this query behaves better when the data set grows.

### What we are measuring

- Your ability to read and understand existing SQL and schema.
- How you reason about data volume and its impact on query behavior.
- How you evolve a query and schema to better match a concrete goal.
- How you validate that your changes make sense.
- How clearly you explain the changes you made and why.

There is no single "correct" solution in any of the tests. We are interested in your thought process, the trade-offs you consider, and how you communicate them.
