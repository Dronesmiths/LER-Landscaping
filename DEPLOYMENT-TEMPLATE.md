# LER Landscaping - AWS Deployment Template

This repository is configured with **automated AWS deployment** using GitHub Actions. Every push to `main` automatically deploys to S3 and CloudFront.

## 🚀 Live URLs

- **S3 Website:** http://ler-landscaping.s3-website-us-east-1.amazonaws.com
- **CloudFront (HTTPS):** https://dn5s9or0po4dd.cloudfront.net

## 📦 Deployment Setup

This repository includes everything needed for automated AWS deployment:

### Files Included

```
.github/workflows/deploy.yml    # GitHub Actions workflow
scripts/
  ├── deploy-s3.sh             # Manual deployment script
  └── setup-cloudfront.sh      # CloudFront setup script
.gitignore                      # Prevents committing credentials
```

### GitHub Secrets Configured

The following secrets are configured in GitHub Actions:

- `AWS_ACCESS_KEY_ID` - AWS access key
- `AWS_SECRET_ACCESS_KEY` - AWS secret key
- `AWS_REGION` - us-east-1
- `S3_BUCKET_NAME` - ler-landscaping
- `CLOUDFRONT_DISTRIBUTION_ID` - E3MZZL0M5BPOPU

## 🔄 How Automated Deployment Works

1. **Push to main branch** → Triggers GitHub Actions
2. **Sync files to S3** → Uploads all website files
3. **Invalidate CloudFront cache** → Ensures latest content is served
4. **Done!** → Your changes are live in seconds

## 📝 Using This as a Template for New Sites

To set up a new site with the same deployment automation:

### Quick Start

Just tell the AI:

```
"Set up AWS deployment for this new site using the LER-Landscaping template. 
The bucket name should be [your-new-bucket-name]"
```

### What Happens Automatically

The AI will:
1. ✅ Copy deployment files from LER-Landscaping
2. ✅ Create S3 bucket with proper configuration
3. ✅ Set up CloudFront distribution
4. ✅ Add GitHub secrets via browser automation
5. ✅ Test the deployment

### Manual Setup (if needed)

See the detailed workflow: `.agent/workflows/deploy-new-site.md`

## 🛠️ Manual Deployment

If you need to deploy manually (without pushing to GitHub):

```bash
./scripts/deploy-s3.sh
```

## 🔐 Security Notes

- AWS credentials are stored as GitHub Secrets (never in code)
- `.gitignore` prevents committing sensitive files
- Same AWS credentials work for all your sites
- Each site has its own S3 bucket and CloudFront distribution

## 📊 AWS Resources

### S3 Bucket
- **Name:** ler-landscaping
- **Region:** us-east-1
- **Website Hosting:** Enabled
- **Public Access:** Configured for static website

### CloudFront Distribution
- **ID:** E3MZZL0M5BPOPU
- **Domain:** dn5s9or0po4dd.cloudfront.net
- **HTTPS:** Enabled
- **Cache Invalidation:** Automated on deployment

## 🎯 Deployment Workflow Details

The GitHub Actions workflow (`.github/workflows/deploy.yml`) includes:

1. **Checkout code** - Gets latest code from repository
2. **Configure AWS credentials** - Uses GitHub Secrets
3. **Sync files to S3** - Uploads with optimized cache headers
   - HTML files: no-cache (always fresh)
   - CSS/JS/Images: long cache (1 year)
4. **Invalidate CloudFront** - Clears CDN cache
5. **Deployment summary** - Shows deployment status

## 📚 Additional Documentation

- `AWS-QUICK-START.md` - AWS setup guide
- `GITHUB-SECRETS-SETUP.md` - Detailed secrets configuration
- `DEPLOYMENT.md` - Full deployment documentation
- `.agent/workflows/deploy-new-site.md` - Template for new sites

## 🆘 Troubleshooting

### Deployment Failed
- Check GitHub Actions logs: https://github.com/Dronesmiths/LER-Landscaping/actions
- Verify all 5 GitHub secrets are configured
- Ensure AWS credentials are valid

### CloudFront Not Updating
- Cache invalidation takes 1-5 minutes
- Check invalidation status in AWS Console
- Verify `CLOUDFRONT_DISTRIBUTION_ID` secret is correct

### Website Not Loading
- S3 URL should work immediately
- CloudFront takes 15-20 minutes for initial deployment
- Check bucket policy allows public access

## 💡 Tips

- **Test locally first** before pushing to production
- **Use descriptive commit messages** - they appear in deployment logs
- **Monitor GitHub Actions** - watch deployments in real-time
- **CloudFront is global** - your site loads fast worldwide

---

**Need help?** Check the workflow guide or ask the AI to help with deployment issues.
