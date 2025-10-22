# GitHub Actions Terraform Pipeline

This repository contains GitHub Actions workflows for deploying and managing Azure infrastructure using Terraform with OIDC authentication.

## Workflows

### 1. Deploy Terraform to Azure (`azure-oidc-login.yml`)

Deploys infrastructure to Azure using Terraform.

**Features:**
- OIDC authentication (no long-lived credentials)
- Terraform format validation
- Terraform validation
- Plan creation with change detection
- Plan artifact upload for review
- Automatic apply only when changes are detected
- Comprehensive deployment summary
- Concurrency control to prevent parallel deployments

**Usage:**
1. Navigate to Actions tab
2. Select "Deploy Terraform to Azure with OIDC"
3. Click "Run workflow"

### 2. Destroy Terraform Infrastructure (`destroy.yml`)

Safely destroys all Terraform-managed infrastructure.

**Features:**
- Manual confirmation required (type "destroy")
- Shows current infrastructure state before destruction
- Creates and uploads destroy plan
- 5-second final confirmation checkpoint
- Post-destruction verification
- Environment protection (production-destroy)
- Concurrency control

**Usage:**
1. Navigate to Actions tab
2. Select "Destroy Terraform Infrastructure"
3. Click "Run workflow"
4. Type "destroy" in the confirmation field
5. Review the plan in the workflow summary before final destruction

## Required Secrets

Configure these secrets in your GitHub repository:

| Secret | Description |
|--------|-------------|
| `AZURE_CLIENT_ID` | Azure service principal client ID |
| `AZURE_TENANT_ID` | Azure tenant ID |
| `AZURE_SUBSCRIPTION_ID` | Azure subscription ID |
| `STORAGE_ACCOUNT` | Azure storage account for Terraform state |
| `CONTAINER_NAME` | Container name in storage account |
| `RESOURCE_GROUP_NAME` | Resource group containing the storage account |
| `VM_ADMIN_PASSWORD` | VM administrator password (min 8 characters) |

## Security Improvements

### Implemented:
- Removed hardcoded passwords from Terraform code
- Using GitHub Secrets for sensitive values
- OIDC authentication (no stored credentials)
- Concurrency controls to prevent race conditions
- Plan artifacts for audit trails
- Validation steps before apply/destroy
- Environment protection for destroy operations

### Recommended GitHub Settings:
1. **Enable Environment Protection for destroy:**
   - Go to Settings > Environments
   - Create "production-destroy" environment
   - Add required reviewers
   - Add deployment protection rules

2. **Enable Branch Protection:**
   - Require pull request reviews
   - Require status checks to pass
   - Enable "Dismiss stale pull request approvals"

## Infrastructure

The Terraform configuration deploys:
- Resource Group (rg-kgeek-tst)
- Virtual Network with 3 subnets
- Network Interface
- Ubuntu 22.04 LTS VM (Standard_DS1_v2)

## Workflow Improvements Summary

### Fixed Critical Issues:
1. ✅ Removed hardcoded VM password
2. ✅ Fixed broken apply conditional logic
3. ✅ Added concurrency controls
4. ✅ Added terraform validate step
5. ✅ Fixed continue-on-error usage

### Added Features:
6. ✅ Terraform format checking
7. ✅ Plan artifact uploads
8. ✅ Detailed workflow summaries
9. ✅ Pre-destroy state display
10. ✅ Post-destroy verification
11. ✅ Environment protection for destroy
12. ✅ Better error handling and reporting

## Next Steps

Consider implementing:
- [ ] Drift detection workflow (scheduled runs)
- [ ] Cost estimation with Infracost
- [ ] Security scanning with tfsec/checkov
- [ ] Pull request plan comments
- [ ] Slack/Teams notifications
- [ ] State locking with Azure Blob Storage
