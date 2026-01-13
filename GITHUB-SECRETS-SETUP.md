# GitHub Secrets Setup Guide

## 📋 Required GitHub Secrets for Automated Deployment

To enable automated deployments to AWS S3 and CloudFront when you push to the `main` branch, you need to add the following secrets to your GitHub repository.

## 🔐 How to Add Secrets

1. Go to your GitHub repository: `https://github.com/Dronesmiths/LER-Landscaping`
2. Click **Settings** (top menu)
3. In the left sidebar, click **Secrets and variables** → **Actions**
4. Click **New repository secret** for each secret below

## 🔑 Secrets to Add

### 1. AWS_ACCESS_KEY_ID
- **Name**: `AWS_ACCESS_KEY_ID`
- **Value**: Your AWS Access Key ID (from AWS IAM)
- **How to get it**: 
  - Go to AWS Console → IAM → Users → Your User → Security Credentials
  - Click "Create access key"
  - Copy the Access Key ID

### 2. AWS_SECRET_ACCESS_KEY
- **Name**: `AWS_SECRET_ACCESS_KEY`
- **Value**: Your AWS Secret Access Key (from AWS IAM)
- **How to get it**: 
  - This is shown only once when you create the access key
  - Copy it immediately and save it securely

### 3. AWS_REGION
- **Name**: `AWS_REGION`
- **Value**: `us-east-1` (or your preferred region)
- **Common regions**:
  - `us-east-1` (US East - N. Virginia)
  - `us-west-2` (US West - Oregon)
  - `eu-west-1` (Europe - Ireland)

### 4. S3_BUCKET_NAME
- **Name**: `S3_BUCKET_NAME`
- **Value**: Your S3 bucket name (will be created when you run setup script)
- **Example**: `ler-landscaping-1234567890`
- **Note**: Add this AFTER running `./scripts/setup-s3.sh`

### 5. CLOUDFRONT_DISTRIBUTION_ID (Optional)
- **Name**: `CLOUDFRONT_DISTRIBUTION_ID`
- **Value**: Your CloudFront distribution ID
- **Example**: `E1234567890ABC`
- **Note**: Add this AFTER running `./scripts/setup-cloudfront.sh`
- **How to get it**: Check the output of the setup script or AWS Console

## 📝 Step-by-Step Setup Process

### Phase 1: Local Setup (Do This First)

```bash
# 1. Configure AWS CLI locally
aws configure

# 2. Create S3 bucket
./scripts/setup-s3.sh

# 3. Note the bucket name from the output
# Example: ler-landscaping-1705171234

# 4. Create CloudFront distribution (optional but recommended)
./scripts/setup-cloudfront.sh

# 5. Note the distribution ID from the output
# Example: E1234567890ABC
```

### Phase 2: GitHub Secrets Setup

After running the local setup scripts, you'll have:
- ✅ S3 bucket name
- ✅ CloudFront distribution ID (if you set it up)

Now add all 5 secrets to GitHub:

1. `AWS_ACCESS_KEY_ID` - From AWS IAM
2. `AWS_SECRET_ACCESS_KEY` - From AWS IAM
3. `AWS_REGION` - e.g., `us-east-1`
4. `S3_BUCKET_NAME` - From setup-s3.sh output
5. `CLOUDFRONT_DISTRIBUTION_ID` - From setup-cloudfront.sh output

### Phase 3: Test Automated Deployment

```bash
# Make a small change to test
echo "<!-- Test deployment -->" >> index.html

# Commit and push
git add .
git commit -m "Test automated deployment"
git push origin main
```

Then:
1. Go to your GitHub repository
2. Click the **Actions** tab
3. You should see a workflow running
4. Wait for it to complete (usually 1-2 minutes)
5. Your changes will be live on S3 and CloudFront!

## 🔒 Security Best Practices

- ✅ **Never commit AWS credentials** to your repository
- ✅ **Use IAM user** with minimal required permissions (S3 and CloudFront only)
- ✅ **Rotate access keys** periodically
- ✅ **Delete unused access keys** from AWS IAM
- ✅ **Enable MFA** on your AWS account

## 🎯 Required IAM Permissions

Your AWS IAM user needs these permissions:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::your-bucket-name",
        "arn:aws:s3:::your-bucket-name/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "cloudfront:CreateInvalidation",
        "cloudfront:GetInvalidation"
      ],
      "Resource": "*"
    }
  ]
}
```

## ✅ Verification Checklist

Before pushing to GitHub, verify:

- [ ] AWS CLI is configured locally
- [ ] S3 bucket is created and working
- [ ] CloudFront distribution is created (optional)
- [ ] All 5 GitHub secrets are added
- [ ] GitHub Actions workflow file exists (`.github/workflows/deploy.yml`)
- [ ] You've tested local deployment with `./scripts/deploy-s3.sh`

## 🆘 Troubleshooting

### "Access Denied" in GitHub Actions
- Check that AWS credentials are correct
- Verify IAM permissions include S3 and CloudFront access

### Workflow not running
- Check that `.github/workflows/deploy.yml` exists
- Verify you're pushing to the `main` branch
- Check Actions tab for error messages

### CloudFront not updating
- Verify `CLOUDFRONT_DISTRIBUTION_ID` is correct
- Invalidations can take 5-15 minutes
- Check AWS Console for invalidation status

---

**Need help?** Check the main `DEPLOYMENT.md` file or AWS documentation.
