# AWS Deployment Guide - LER Landscaping

This guide will help you deploy the LER Landscaping website to AWS using S3 for hosting and CloudFront for CDN distribution.

## 📋 Prerequisites

1. **AWS Account** - You'll need an AWS account with appropriate permissions
2. **AWS CLI** - Command-line tool for AWS services
3. **Git** - For version control and automated deployments

## 🚀 Quick Start

### Step 1: Install AWS CLI

```bash
# Check if AWS CLI is installed
aws --version

# If not installed, install via Homebrew (macOS)
brew install awscli
```

### Step 2: Configure AWS Credentials

```bash
aws configure
```

You'll be prompted for:
- **AWS Access Key ID**: Your AWS access key
- **AWS Secret Access Key**: Your AWS secret key
- **Default region**: `us-east-1` (recommended)
- **Default output format**: `json`

### Step 3: Create S3 Bucket

```bash
./scripts/setup-s3.sh
```

This will:
- ✅ Create a new S3 bucket with a unique name
- ✅ Configure it for static website hosting
- ✅ Set up public access policies
- ✅ Enable versioning
- ✅ Save configuration to `scripts/aws-config.sh`

### Step 4: Deploy Your Website

```bash
./scripts/deploy-s3.sh
```

This will:
- ✅ Upload all website files to S3
- ✅ Set appropriate cache headers
- ✅ Sync changes efficiently

### Step 5: Set Up CloudFront CDN (Optional but Recommended)

```bash
./scripts/setup-cloudfront.sh
```

This will:
- ✅ Create a CloudFront distribution
- ✅ Enable HTTPS
- ✅ Configure caching rules
- ✅ Set up custom error pages

**Note**: CloudFront deployment takes 15-20 minutes to complete.

### Step 6: Verify Deployment

```bash
./scripts/test-deployment.sh
```

This will test both S3 and CloudFront endpoints to ensure everything is working.

## 🔄 Automated Deployments with GitHub Actions

### Setup GitHub Secrets

1. Go to your GitHub repository
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Add the following secrets:

| Secret Name | Description | Example |
|------------|-------------|---------|
| `AWS_ACCESS_KEY_ID` | Your AWS access key | `AKIAIOSFODNN7EXAMPLE` |
| `AWS_SECRET_ACCESS_KEY` | Your AWS secret key | `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY` |
| `AWS_REGION` | AWS region | `us-east-1` |
| `S3_BUCKET_NAME` | Your S3 bucket name | `ler-landscaping-1234567890` |
| `CLOUDFRONT_DISTRIBUTION_ID` | CloudFront distribution ID | `E1234567890ABC` |

### How It Works

Once configured, every push to the `main` branch will automatically:
1. ✅ Deploy files to S3
2. ✅ Invalidate CloudFront cache
3. ✅ Make your changes live within minutes

You can also manually trigger deployments from the **Actions** tab in GitHub.

## 📁 Project Structure

```
LER-Landscaping/
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions workflow
├── scripts/
│   ├── setup-s3.sh            # S3 bucket setup
│   ├── deploy-s3.sh           # Deploy to S3
│   ├── setup-cloudfront.sh    # CloudFront setup
│   ├── test-deployment.sh     # Test deployment
│   └── aws-config.sh          # AWS configuration (auto-generated)
├── css/                        # Stylesheets
├── js/                         # JavaScript files
├── images/                     # Image assets
├── about/                      # About page
├── contact/                    # Contact page
├── locations/                  # Location pages
├── services/                   # Service pages
└── index.html                  # Homepage
```

## 🛠️ Useful Commands

### Deploy Changes
```bash
./scripts/deploy-s3.sh
```

### Check S3 Bucket Contents
```bash
aws s3 ls s3://your-bucket-name --recursive
```

### Invalidate CloudFront Cache
```bash
aws cloudfront create-invalidation \
  --distribution-id YOUR_DIST_ID \
  --paths "/*"
```

### Check CloudFront Status
```bash
aws cloudfront get-distribution \
  --id YOUR_DIST_ID \
  --query 'Distribution.Status'
```

### View Configuration
```bash
cat scripts/aws-config.sh
```

## 💰 Cost Estimation

### S3 Costs
- **Storage**: ~$0.023 per GB/month
- **Requests**: ~$0.0004 per 1,000 GET requests
- **Data Transfer**: First 1 GB free, then ~$0.09 per GB

### CloudFront Costs
- **Data Transfer**: First 1 TB free (12 months), then ~$0.085 per GB
- **Requests**: ~$0.0075 per 10,000 HTTP requests

**Estimated monthly cost for a small business website**: $1-5/month

## 🔒 Security Best Practices

1. **Never commit AWS credentials** to Git
2. **Use IAM roles** with minimal required permissions
3. **Enable CloudFront** for HTTPS encryption
4. **Enable S3 versioning** for backup and recovery
5. **Set up CloudWatch alarms** for monitoring

## 🌐 Custom Domain Setup (Optional)

To use your own domain (e.g., `www.lerlandscaping.com`):

1. **Request SSL Certificate** in AWS Certificate Manager (us-east-1)
2. **Update CloudFront** distribution with custom domain and certificate
3. **Configure DNS** in Route 53 or your DNS provider:
   - Create CNAME record pointing to CloudFront domain
   - Or use Route 53 Alias record

## 🆘 Troubleshooting

### "AWS CLI not found"
```bash
brew install awscli
```

### "Access Denied" errors
- Check your AWS credentials: `aws sts get-caller-identity`
- Verify IAM permissions for S3 and CloudFront

### CloudFront not updating
- Invalidations can take 5-15 minutes
- Check invalidation status in AWS Console

### 403 Forbidden errors
- Verify bucket policy allows public read access
- Check CloudFront origin settings

## 📞 Support

For issues or questions:
1. Check AWS documentation
2. Review CloudWatch logs
3. Contact AWS support

## 📝 License

This deployment configuration is part of the LER Landscaping website project.

---

**Last Updated**: January 2026
