#!/usr/bin/env bash

set -e

echo "Extracting, loading and transforming data..."
meltano run tap_csv_load_transform