#!/bin/bash
# =============================================================================
# Metabase Import Script
# Run this to manually import content to a Metabase instance
# (The GitHub Action handles production imports automatically)
# =============================================================================

set -e

# Configuration - Update these values
METABASE_JAR_PATH="${METABASE_JAR_PATH:-./metabase.jar}"
IMPORT_PATH="${IMPORT_PATH:-./collections}"

# =============================================================================
# Script
# =============================================================================

echo "==================================="
echo "Metabase Import Script"
echo "==================================="

# Check if metabase.jar exists
if [ ! -f "$METABASE_JAR_PATH" ]; then
    echo "Error: Metabase JAR not found at $METABASE_JAR_PATH"
    echo "Please set METABASE_JAR_PATH environment variable or download metabase.jar"
    exit 1
fi

# Check if import path exists
if [ ! -d "$IMPORT_PATH" ]; then
    echo "Error: Import path not found: $IMPORT_PATH"
    exit 1
fi

# Build import command
IMPORT_CMD="java -jar $METABASE_JAR_PATH import $IMPORT_PATH"

echo "Running: $IMPORT_CMD"
echo "-----------------------------------"

# Run import
eval $IMPORT_CMD

echo "-----------------------------------"
echo "Import complete!"
echo "Content imported from: $IMPORT_PATH"
