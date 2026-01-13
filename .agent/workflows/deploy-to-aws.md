---
description: Deploy website to AWS S3 and CloudFront
---

# Deploy to AWS S3 and CloudFront

This workflow guides you through deploying the LER Landscaping website to AWS S3 with CloudFront CDN distribution.

## Prerequisites

1. AWS Account with appropriate permissions
2. AWS CLI installed and configured
3. Domain name (optional, for custom domain setup)

## Choose Your Path

**Option A**: Connect to existing S3 bucket and CloudFront (if you already have a working site)
**Option B**: Create new AWS infrastructure from scratch

---

## Option A: Connect to Existing AWS Infrastructure

If you already have a working S3 bucket and CloudFront distribution:

### 1. Install AWS CLI (if not already installed)

```bash
# Check if AWS CLI is installed
aws --version

# If not installed, install via Homebrew
brew install awscli
```

### 2. Configure AWS Credentials

```bash
# Configure AWS CLI with your credentials
aws configure
```

You'll need to provide:
- AWS Access Key ID
- AWS Secret Access Key
- Default region (e.g., us-east-1)
- Default output format (json)

### 3. Connect to Your Existing Setup

```bash
# Run the connection script
./scripts/connect-existing-aws.sh
```

This script will:
- Prompt for your existing S3 bucket name
- Verify the bucket exists and you have access
- Optionally connect to your CloudFront distribution
- Save configuration to `scripts/aws-config.sh`

### 4. Deploy Updates

```bash
# Deploy your website to the existing S3 bucket
./scripts/deploy-s3.sh
```

### 5. Verify Deployment

```bash
# Test the deployment
./scripts/test-deployment.sh
```

---

## Option B: Create New AWS Infrastructure

If you're setting up AWS for the first time:

### 1. Install AWS CLI (if not already installed)

```bash
# Check if AWS CLI is installed
aws --version

# If not installed, install via Homebrew
brew install awscli
```

### 2. Configure AWS Credentials

```bash
# Configure AWS CLI with your credentials
aws configure
```

You'll need to provide:
- AWS Access Key ID
- AWS Secret Access Key
- Default region (e.g., us-east-1)
- Default output format (json)

### 3. Create S3 Bucket

```bash
# Run the S3 setup script
./scripts/setup-s3.sh
```

This script will:
- Create an S3 bucket with a unique name
- Configure it for static website hosting
- Set up appropriate bucket policies
- Enable versioning (optional)

### 4. Upload Website Files

```bash
# Deploy the website to S3
./scripts/deploy-s3.sh
```

This script will:
- Sync all website files to S3
- Set correct content types
- Configure cache headers
- Invalidate CloudFront cache (if distribution exists)

### 5. Create CloudFront Distribution

```bash
# Set up CloudFront distribution
./scripts/setup-cloudfront.sh
```

This script will:
- Create a CloudFront distribution
- Configure origin settings
- Set up SSL certificate (if using custom domain)
- Configure caching behaviors
- Set up error pages

### 6. Configure Custom Domain (Optional)

If you want to use a custom domain:

1. Update Route 53 or your DNS provider with CloudFront distribution domain
2. Request SSL certificate via AWS Certificate Manager
3. Update CloudFront distribution with custom domain and certificate

### 7. Verify Deployment

```bash
# Test the CloudFront distribution
./scripts/test-deployment.sh
```

## Continuous Deployment

For automated deployments on git push:

1. Set up GitHub Actions workflow (see `.github/workflows/deploy.yml`)
2. Add AWS credentials to GitHub Secrets
3. Push to main branch to trigger automatic deployment

## Useful Commands

```bash
# Check S3 bucket contents
aws s3 ls s3://your-bucket-name --recursive

# Invalidate CloudFront cache manually
aws cloudfront create-invalidation --distribution-id YOUR_DIST_ID --paths "/*"

# Check CloudFront distribution status
aws cloudfront get-distribution --id YOUR_DIST_ID
```
