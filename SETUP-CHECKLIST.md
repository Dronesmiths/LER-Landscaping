# 🚀 Complete Setup Checklist for LER Landscaping AWS Deployment

Follow these steps in order to deploy your new LER Landscaping website to AWS.

## ✅ Step 1: Install AWS CLI

```bash
# Install AWS CLI using Homebrew
brew install awscli

# Verify installation
aws --version
```

**Expected output**: `aws-cli/2.x.x Python/3.x.x Darwin/...`

---

## ✅ Step 2: Configure AWS Credentials

You'll need AWS credentials first. If you don't have them:

### Get AWS Credentials:
1. Log into AWS Console: https://console.aws.amazon.com
2. Go to **IAM** (Identity and Access Management)
3. Click **Users** → **Add users**
4. Create a user with **Programmatic access**
5. Attach policies: `AmazonS3FullAccess` and `CloudFrontFullAccess`
6. Save the **Access Key ID** and **Secret Access Key**

### Configure AWS CLI:
```bash
aws configure
```

Enter when prompted:
- **AWS Access Key ID**: [Your access key]
- **AWS Secret Access Key**: [Your secret key]
- **Default region name**: `us-east-1`
- **Default output format**: `json`

### Verify Configuration:
```bash
aws sts get-caller-identity
```

**Expected output**: Your AWS account details

---

## ✅ Step 3: Create S3 Bucket for LER Landscaping

```bash
# Run the S3 setup script
./scripts/setup-s3.sh
```

**What this does**:
- Creates a new S3 bucket with unique name
- Configures it for static website hosting
- Sets up public access policies
- Enables versioning
- Saves configuration to `scripts/aws-config.sh`

**Save the bucket name** from the output! You'll need it for GitHub secrets.

Example output:
```
Bucket Name: ler-landscaping-1705171234
Website URL: http://ler-landscaping-1705171234.s3-website-us-east-1.amazonaws.com
```

---

## ✅ Step 4: Deploy Website to S3

```bash
# Deploy your website files
./scripts/deploy-s3.sh
```

**What this does**:
- Uploads all HTML, CSS, JS, and images to S3
- Sets appropriate cache headers
- Makes your site live on S3

**Test it**: Open the Website URL from Step 3 in your browser

---

## ✅ Step 5: Set Up CloudFront CDN (Recommended)

```bash
# Create CloudFront distribution
./scripts/setup-cloudfront.sh
```

**What this does**:
- Creates a CloudFront CDN distribution
- Enables HTTPS
- Configures caching for better performance
- Sets up custom error pages

**Note**: This takes 15-20 minutes to fully deploy

**Save the distribution ID** from the output! You'll need it for GitHub secrets.

Example output:
```
Distribution ID: E1234567890ABC
CloudFront URL: https://d1234567890abc.cloudfront.net
```

---

## ✅ Step 6: Test Your Deployment

```bash
# Run the test script
./scripts/test-deployment.sh
```

**What this does**:
- Checks S3 website is accessible
- Checks CloudFront distribution status
- Lists uploaded files
- Shows all URLs

---

## ✅ Step 7: Set Up GitHub Automated Deployments

### Add GitHub Secrets:

1. Go to: `https://github.com/Dronesmiths/LER-Landscaping/settings/secrets/actions`
2. Click **New repository secret** for each:

| Secret Name | Value | Where to Find |
|------------|-------|---------------|
| `AWS_ACCESS_KEY_ID` | Your AWS access key | From Step 2 |
| `AWS_SECRET_ACCESS_KEY` | Your AWS secret key | From Step 2 |
| `AWS_REGION` | `us-east-1` | From Step 2 |
| `S3_BUCKET_NAME` | Your bucket name | From Step 3 output |
| `CLOUDFRONT_DISTRIBUTION_ID` | Your distribution ID | From Step 5 output |

### Test Automated Deployment:

```bash
# Make a test change
echo "<!-- Automated deployment test -->" >> index.html

# Commit and push
git add .
git commit -m "Test automated deployment"
git push origin main
```

Then check: `https://github.com/Dronesmiths/LER-Landscaping/actions`

---

## ✅ Step 8: Verify Everything Works

- [ ] S3 website URL loads correctly
- [ ] CloudFront URL loads correctly (after 15-20 min)
- [ ] GitHub Actions workflow runs successfully
- [ ] Changes pushed to `main` branch deploy automatically

---

## 📋 Quick Reference

### Your Configuration File
```bash
# View your AWS settings
cat scripts/aws-config.sh
```

### Deploy Updates
```bash
# Manual deployment
./scripts/deploy-s3.sh
```

### Check Status
```bash
# Test deployment
./scripts/test-deployment.sh
```

---

## 🎯 Current Status

Track your progress:

- [ ] AWS CLI installed
- [ ] AWS credentials configured
- [ ] S3 bucket created
- [ ] Website deployed to S3
- [ ] CloudFront distribution created
- [ ] GitHub secrets configured
- [ ] Automated deployment tested

---

## 📚 Additional Resources

- **Full deployment guide**: `DEPLOYMENT.md`
- **Quick reference**: `AWS-QUICK-START.md`
- **GitHub secrets setup**: `GITHUB-SECRETS-SETUP.md`
- **Workflow documentation**: `.agent/workflows/deploy-to-aws.md`

---

## 🆘 Need Help?

If you run into issues:
1. Check the error message carefully
2. Verify AWS credentials: `aws sts get-caller-identity`
3. Check AWS Console for resource status
4. Review the relevant documentation file

**Ready to start?** Begin with Step 1! 🚀
