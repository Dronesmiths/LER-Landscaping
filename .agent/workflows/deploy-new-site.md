---
description: Deploy a new website to AWS with automated GitHub Actions
---

# Deploy New Website to AWS (Complete Setup)

Use this workflow to set up automated AWS deployment for a new website repository.

## Prerequisites

You already have:
- ✅ AWS CLI installed and configured
- ✅ AWS credentials (github-deploy user) - stored in `github-deploy_accessKeys.csv`
- ✅ AWS region: `us-east-1`

## What You'll Need

1. The new repository name (e.g., `my-new-site`)
2. The local directory path for the new site

## Step-by-Step Process

### Phase 1: Copy Deployment Files from LER-Landscaping Template

// turbo
1. Copy the `.github/workflows/deploy.yml` file to the new repository
2. Copy the `scripts/` directory (all deployment scripts) to the new repository
3. Copy the `.gitignore` file to ensure credentials aren't committed

### Phase 2: Create S3 Bucket and CloudFront

// turbo
4. Run: `aws s3 mb s3://[NEW-BUCKET-NAME] --region us-east-1`
   - Bucket name should match your site (e.g., `my-new-site`)

// turbo
5. Run: `aws s3 website s3://[NEW-BUCKET-NAME] --index-document index.html --error-document 404.html`

// turbo
6. Create bucket policy file and apply it:
   ```bash
   cat > /tmp/bucket-policy.json << 'EOF'
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Sid": "PublicReadGetObject",
         "Effect": "Allow",
         "Principal": "*",
         "Action": "s3:GetObject",
         "Resource": "arn:aws:s3:::NEW-BUCKET-NAME/*"
       }
     ]
   }
   EOF
   ```

// turbo
7. Run: `aws s3api put-public-access-block --bucket [NEW-BUCKET-NAME] --public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false"`

// turbo
8. Run: `aws s3api put-bucket-policy --bucket [NEW-BUCKET-NAME] --policy file:///tmp/bucket-policy.json`

// turbo
9. Run the CloudFront setup script: `./scripts/setup-cloudfront.sh`
   - This will create a CloudFront distribution and output the Distribution ID

### Phase 3: Configure GitHub Secrets

10. Navigate to: `https://github.com/Dronesmiths/[REPO-NAME]/settings/secrets/actions`

11. Add these 5 secrets (use the browser to add them):
    - `AWS_ACCESS_KEY_ID`: (from your AWS credentials CSV)
    - `AWS_SECRET_ACCESS_KEY`: (from your AWS credentials CSV)
    - `AWS_REGION`: `us-east-1`
    - `S3_BUCKET_NAME`: `[NEW-BUCKET-NAME]`
    - `CLOUDFRONT_DISTRIBUTION_ID`: `[FROM-STEP-9]`

### Phase 4: Test Deployment

// turbo
12. Commit and push the deployment files:
    ```bash
    git add .github/workflows/deploy.yml scripts/ .gitignore
    git commit -m "Add AWS deployment automation"
    git push origin main
    ```

13. Check GitHub Actions to verify the deployment succeeded

14. Test the live URLs:
    - S3: `http://[BUCKET-NAME].s3-website-us-east-1.amazonaws.com`
    - CloudFront: `https://[CLOUDFRONT-DOMAIN].cloudfront.net`

## Quick Command Summary

For a new site called `my-new-site`:

```bash
# 1. Create bucket
aws s3 mb s3://my-new-site --region us-east-1

# 2. Enable website hosting
aws s3 website s3://my-new-site --index-document index.html --error-document 404.html

# 3. Set public access
aws s3api put-public-access-block --bucket my-new-site --public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false"

# 4. Apply bucket policy (after creating the policy file)
aws s3api put-bucket-policy --bucket my-new-site --policy file:///tmp/bucket-policy.json

# 5. Create CloudFront distribution
./scripts/setup-cloudfront.sh

# 6. Deploy
git push origin main
```

## What to Tell the AI

Simply say:

**"Set up AWS deployment for this new site using the LER-Landscaping template. The bucket name should be `[your-bucket-name]`"**

The AI will:
1. Copy the deployment files from LER-Landscaping
2. Create the S3 bucket and configure it
3. Set up CloudFront
4. Add the GitHub secrets via browser automation
5. Test the deployment

## Files Included in Template

- `.github/workflows/deploy.yml` - GitHub Actions workflow
- `scripts/deploy-s3.sh` - Manual deployment script
- `scripts/setup-cloudfront.sh` - CloudFront setup script
- `.gitignore` - Prevents committing credentials

## Notes

- The same AWS credentials work for all sites (github-deploy user)
- Each site needs its own S3 bucket and CloudFront distribution
- GitHub secrets are per-repository, so you'll add them to each new repo
- CloudFront takes 15-20 minutes to deploy initially
