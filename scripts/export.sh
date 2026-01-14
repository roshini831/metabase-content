#!/bin/bash
# =============================================================================
# Metabase Export Script
# Run this from your DEVELOPMENT Metabase server to export content
# =============================================================================

set -e

# Configuration - Update these values
METABASE_JAR_PATH="${METABASE_JAR_PATH:-./metabase.jar}"
EXPORT_PATH="${EXPORT_PATH:-./collections}"
# Comma-separated list of collection IDs to export (e.g., "2,3,4")
COLLECTION_IDS="${COLLECTION_IDS:-}"

# =============================================================================
# Script
# =============================================================================

echo "==================================="
echo "Metabase Export Script"
echo "==================================="

# Check if metabase.jar exists
if [ ! -f "$METABASE_JAR_PATH" ]; then
    echo "Error: Metabase JAR not found at $METABASE_JAR_PATH"
    echo "Please set METABASE_JAR_PATH environment variable or download metabase.jar"
    exit 1
fi

# Build export command
EXPORT_CMD="java -jar $METABASE_JAR_PATH export $EXPORT_PATH"

# Add collection filter if specified
if [ -n "$COLLECTION_IDS" ]; then
    EXPORT_CMD="$EXPORT_CMD --collection $COLLECTION_IDS"
    echo "Exporting collections: $COLLECTION_IDS"
else
    echo "Exporting all collections"
fi

# Add flags to exclude data model and settings (only sync content)
EXPORT_CMD="$EXPORT_CMD --no-data-model --no-settings"

echo "Running: $EXPORT_CMD"
echo "-----------------------------------"

# Run export
eval $EXPORT_CMD

echo "-----------------------------------"
echo "Export complete!"
echo "Files exported to: $EXPORT_PATH"
echo ""
echo "Next steps:"
echo "  1. git add ."
echo "  2. git commit -m 'Update Metabase content'"
echo "  3. git push origin <your-branch>"
echo "  4. Create a PR and merge to main"
