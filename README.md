# Metabase Content Version Control

This repository enables Git-based version control for Metabase dashboards, questions, and collections using the **open-source Metabase Migration Toolkit**.

## 📋 Project Structure

```
metabase-content/
├── collections/              # Exported Metabase content (JSON)
├── scripts/
│   ├── export.sh            # Export from dev Metabase
│   └── import.sh            # Manual import script
├── .github/workflows/
│   └── deploy-to-production.yml  # Auto-deploy on push to main
└── README.md
```

## ⚙️ Setup

### Prerequisites

- **Two Metabase instances** running:
  - Development: `http://localhost:3000`
  - Production: `http://localhost:3001`
- Python 3.8+ installed
- The Metabase Migration Toolkit: `pip install metabase-migration-toolkit`

### Configure GitHub Secrets

Add these secrets in **Settings → Secrets and variables → Actions**:

| Secret | Description |
|--------|-------------|
| `MB_PROD_HOST` | Production Metabase URL (e.g., `http://your-prod-metabase.com`) |
| `MB_PROD_USER` | Production Metabase admin email |
| `MB_PROD_PASSWORD` | Production Metabase admin password |

## 🚀 Workflow

### 1. Export from Development

```bash
cd metabase-content

# Set credentials
export METABASE_USER="your-email@example.com"
export METABASE_PASSWORD="your-password"

# Run export
./scripts/export.sh
```

### 2. Review & Commit Changes

```bash
git status
git add collections/
git commit -m "Update: Added new sales dashboard"
git push origin main
```

### 3. Auto-Deploy to Production

When you push to `main`, the GitHub Action automatically imports the content to production!

## 📝 Notes

- **Open Source Solution**: This uses the [Metabase Migration Toolkit](https://github.com/your-repo/metabase-migration-toolkit), which works with the free/open-source version of Metabase.
- **Local Testing**: For local GitHub Actions (where production runs on localhost), you may need a tunnel or self-hosted runner.
- **Password Security**: Update `MB_PROD_PASSWORD` in GitHub secrets with your actual production password.

## 🔧 Manual Import

To manually import to any Metabase instance:

```bash
export METABASE_HOST="http://localhost:3001"
export METABASE_USER="your-email@example.com"
export METABASE_PASSWORD="your-password"

./scripts/import.sh
```
