#!/bin/bash
# Metabase Export Script using Metabase Migration Toolkit (Open Source)
# This script exports Metabase content using the metabase-export CLI tool

set -e

# Configuration - can be overridden via environment variables
METABASE_HOST="${METABASE_HOST:-http://localhost:3000}"
METABASE_USER="${METABASE_USER:-}"
METABASE_PASSWORD="${METABASE_PASSWORD:-}"
OUTPUT_DIR="${OUTPUT_DIR:-./collections}"

echo "==================================="
echo "Metabase Export Script (Open Source)"
echo "==================================="
echo "Source: $METABASE_HOST"
echo "Output: $OUTPUT_DIR"
echo ""

# Check if credentials are provided
if [ -z "$METABASE_USER" ] || [ -z "$METABASE_PASSWORD" ]; then
    echo "Please set environment variables:"
    echo "  METABASE_USER=your-email@example.com"
    echo "  METABASE_PASSWORD=your-password"
    echo ""
    echo "Example:"
    echo "  METABASE_USER=admin@example.com METABASE_PASSWORD=secret ./scripts/export.sh"
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

echo "Running export..."
echo "-----------------------------------"

# Run the export using the correct CLI options
metabase-export \
    --source-url "$METABASE_HOST" \
    --source-username "$METABASE_USER" \
    --source-password "$METABASE_PASSWORD" \
    --export-dir "$OUTPUT_DIR" \
    --include-dashboards \
    --metabase-version v57

echo "-----------------------------------"
echo "Export complete!"
echo "Files saved to: $OUTPUT_DIR"
echo ""
echo "Next steps:"
echo "  1. Review the exported content"
echo "  2. git add . && git commit -m 'Update Metabase content'"
echo "  3. Push to GitHub and merge to main"
