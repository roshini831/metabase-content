# Metabase Content Repository

This repository manages Metabase content (dashboards, questions, models, collections) using a git-based workflow for syncing between development and production environments.

## 🏗️ Architecture

```
Development Metabase → Export → Git Repo → GitHub Action → Production Metabase
```

## 📁 Repository Structure

```
├── .github/workflows/
│   └── deploy-to-production.yml  # Auto-deploys on merge to main
├── collections/                   # Serialized Metabase content (YAML)
├── scripts/
│   ├── export.sh                  # Export from dev Metabase
│   └── import.sh                  # Manual import script
└── README.md
```

## ⚙️ Setup

### Prerequisites

- Metabase Pro or Enterprise plan (serialization required)
- Development and Production Metabase instances (same version)
- Both instances connected to databases with **same schema and display name**

### 1. Configure GitHub Secrets

Add these secrets to your repository (Settings → Secrets and variables → Actions):

| Secret | Description |
|--------|-------------|
| `MB_PROD_DB_TYPE` | Database type: `postgres` or `mysql` |
| `MB_PROD_DB_CONNECTION_URI` | Connection string for production Metabase app database |

Example connection URI:
```
postgresql://user:password@host:5432/metabase_prod
```

### 2. Update Workflow Version

Edit `.github/workflows/deploy-to-production.yml` and update the Metabase version to match your instances:
```yaml
curl -L -o metabase.jar https://downloads.metabase.com/v0.49.6/metabase.jar
```

## 🔄 Workflow

### Exporting from Development

1. SSH to your development Metabase server
2. Run the export script:
   ```bash
   # Export specific collections
   COLLECTION_IDS="2,3,4" ./scripts/export.sh
   
   # Or export all collections
   ./scripts/export.sh
   ```
3. Commit and push changes:
   ```bash
   git add .
   git commit -m "Update dashboards"
   git push origin feature-branch
   ```

### Deploying to Production

1. Create a Pull Request from your feature branch
2. Review the YAML changes
3. Merge to `main` branch
4. GitHub Action automatically imports to production

## 🔍 Finding Collection IDs

In Metabase, go to the collection and check the URL:
```
https://your-metabase.com/collection/42
                                    ^^
                                    Collection ID
```

## ⚠️ Important Notes

- **Never edit production directly** - always go through this workflow
- Keep dev and prod Metabase versions in sync
- Avoid dashboard subscriptions/alerts in collections you serialize
- Don't use model caching in development (conflicts with production)

## 📚 Resources

- [Metabase Serialization Docs](https://www.metabase.com/docs/latest/installation-and-operation/serialization)
- [Git Workflow Tutorial](https://www.metabase.com/learn/metabase-basics/administration/administration-and-operation/git-based-workflow)
