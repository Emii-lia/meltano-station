#!/usr/bin/env bash

set -e

echo "Extracting and loading data..."
meltano run load_data