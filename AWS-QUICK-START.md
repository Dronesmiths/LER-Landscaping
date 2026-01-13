# AWS Deployment - Quick Reference

## 🚀 First Time Setup

```bash
# 1. Install AWS CLI (if needed)
brew install awscli

# 2. Configure AWS credentials
aws configure

# 3. Create S3 bucket
./scripts/setup-s3.sh

# 4. Deploy website
./scripts/deploy-s3.sh

# 5. Set up CloudFront (optional)
./scripts/setup-cloudfront.sh

# 6. Test deployment
./scripts/test-deployment.sh
```

## 🔄 Regular Deployments

```bash
# Deploy changes to S3
./scripts/deploy-s3.sh
```

## 📋 Available Scripts

| Script | Purpose |
|--------|---------|
| `setup-s3.sh` | Create and configure S3 bucket (one-time) |
| `deploy-s3.sh` | Deploy website files to S3 |
| `setup-cloudfront.sh` | Create CloudFront distribution (one-time) |
| `test-deployment.sh` | Test S3 and CloudFront endpoints |

## 🔧 Useful Commands

```bash
# View your AWS configuration
cat scripts/aws-config.sh

# List S3 bucket contents
aws s3 ls s3://your-bucket-name --recursive

# Invalidate CloudFront cache
aws cloudfront create-invalidation --distribution-id YOUR_ID --paths "/*"

# Check CloudFront status
aws cloudfront get-distribution --id YOUR_ID --query 'Distribution.Status'
```

## 🤖 GitHub Actions (Automated Deployment)

### Required Secrets
Add these in GitHub Settings → Secrets and variables → Actions:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`
- `S3_BUCKET_NAME`
- `CLOUDFRONT_DISTRIBUTION_ID`

### Trigger Deployment
- **Automatic**: Push to `main` branch
- **Manual**: Go to Actions tab → Deploy to AWS → Run workflow

## 📁 Important Files

- `DEPLOYMENT.md` - Full deployment guide
- `.github/workflows/deploy.yml` - GitHub Actions workflow
- `scripts/aws-config.sh` - AWS configuration (auto-generated, not in git)
- `404.html` - Custom error page

## 💡 Tips

- CloudFront deployment takes 15-20 minutes
- Cache invalidations take 5-15 minutes
- S3 changes are instant
- Always test with `./scripts/test-deployment.sh`

## 🆘 Troubleshooting

**AWS CLI not found?**
```bash
brew install awscli
```

**Access denied?**
```bash
aws sts get-caller-identity  # Verify credentials
aws configure                 # Reconfigure if needed
```

**CloudFront not updating?**
- Wait 5-15 minutes for invalidation
- Check AWS Console for status

---

For detailed information, see `DEPLOYMENT.md`
