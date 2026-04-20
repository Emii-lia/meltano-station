#!/usr/bin/env bash

set -e

echo "Extracting and loading data..."
meltano run load_data
echo "Transforming data..."
meltano run dbt_transform
echo "Running tests..."
meltano run dbt_test
echo "All done!"