#!/bin/bash
# Metabase Import Script using Metabase Migration Toolkit (Open Source)
# This script imports Metabase content using the metabase-import CLI tool

set -e

# Configuration - can be overridden via environment variables
METABASE_HOST="${METABASE_HOST:-http://localhost:3001}"
METABASE_USER="${METABASE_USER:-}"
METABASE_PASSWORD="${METABASE_PASSWORD:-}"
INPUT_DIR="${INPUT_DIR:-./collections}"

echo "==================================="
echo "Metabase Import Script (Open Source)"
echo "==================================="
echo "Target: $METABASE_HOST"
echo "Input:  $INPUT_DIR"
echo ""

# Check if credentials are provided
if [ -z "$METABASE_USER" ] || [ -z "$METABASE_PASSWORD" ]; then
    echo "Please set environment variables:"
    echo "  METABASE_USER=your-email@example.com"
    echo "  METABASE_PASSWORD=your-password"
    echo ""
    echo "Example:"
    echo "  METABASE_USER=admin@example.com METABASE_PASSWORD=secret ./scripts/import.sh"
    exit 1
fi

# Check if input directory exists
if [ ! -d "$INPUT_DIR" ]; then
    echo "Error: Input directory '$INPUT_DIR' not found"
    exit 1
fi

echo "Running import..."
echo "-----------------------------------"

# Run the import using correct CLI options
metabase-import \
    --target-url "$METABASE_HOST" \
    --target-username "$METABASE_USER" \
    --target-password "$METABASE_PASSWORD" \
    --import-dir "$INPUT_DIR" \
    --metabase-version v57

echo "-----------------------------------"
echo "Import complete!"
echo "Content imported to: $METABASE_HOST"
