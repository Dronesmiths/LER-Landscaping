# LER Landscaping Website

Professional landscaping website deployed on AWS S3 and CloudFront.

## 🚀 Quick Start

**New to AWS deployment?** Start here: [`SETUP-CHECKLIST.md`](SETUP-CHECKLIST.md)

This checklist walks you through:
1. Installing AWS CLI
2. Configuring credentials
3. Creating S3 bucket
4. Deploying your website
5. Setting up CloudFront CDN
6. Enabling automated GitHub deployments

## 📁 Project Structure

```
LER-Landscaping/
├── index.html              # Homepage
├── about/                  # About page
├── contact/                # Contact page
├── locations/              # Location-specific pages
├── services/               # Service pages
├── css/                    # Stylesheets
├── js/                     # JavaScript files
├── images/                 # Image assets
├── 404.html               # Custom error page
│
├── scripts/               # Deployment scripts
│   ├── setup-s3.sh           # Create new S3 bucket
│   ├── deploy-s3.sh          # Deploy to S3
│   ├── setup-cloudfront.sh   # Create CloudFront distribution
│   ├── test-deployment.sh    # Test deployment
│   └── connect-existing-aws.sh # Connect to existing AWS setup
│
├── .github/workflows/     # GitHub Actions
│   └── deploy.yml            # Auto-deploy on push to main
│
└── Documentation/
    ├── SETUP-CHECKLIST.md       # Step-by-step setup guide
    ├── DEPLOYMENT.md            # Complete deployment guide
    ├── AWS-QUICK-START.md       # Quick reference
    └── GITHUB-SECRETS-SETUP.md  # GitHub Actions setup
```

## 🛠️ Deployment Scripts

All scripts are in the `scripts/` folder and ready to use:

| Script | Purpose | When to Use |
|--------|---------|-------------|
| `setup-s3.sh` | Create new S3 bucket | First time setup |
| `deploy-s3.sh` | Deploy website to S3 | Every time you make changes |
| `setup-cloudfront.sh` | Create CloudFront CDN | First time setup (after S3) |
| `test-deployment.sh` | Verify deployment | After deploying |
| `connect-existing-aws.sh` | Connect to existing AWS | If you already have S3/CloudFront |

## 📖 Documentation

- **[SETUP-CHECKLIST.md](SETUP-CHECKLIST.md)** - Start here! Complete setup guide
- **[DEPLOYMENT.md](DEPLOYMENT.md)** - Detailed deployment documentation
- **[AWS-QUICK-START.md](AWS-QUICK-START.md)** - Quick reference for common tasks
- **[GITHUB-SECRETS-SETUP.md](GITHUB-SECRETS-SETUP.md)** - GitHub Actions configuration

## 🔄 Automated Deployments

Once configured, every push to `main` branch automatically:
1. ✅ Deploys to S3
2. ✅ Invalidates CloudFront cache
3. ✅ Makes changes live within minutes

See [GITHUB-SECRETS-SETUP.md](GITHUB-SECRETS-SETUP.md) for setup instructions.

## 💻 Local Development

```bash
# Make changes to your files
# Then deploy manually:
./scripts/deploy-s3.sh

# Or commit and push for automated deployment:
git add .
git commit -m "Your changes"
git push origin main
```

## 🌐 Live URLs

After deployment, your site will be available at:

- **S3 Website**: `http://[bucket-name].s3-website-[region].amazonaws.com`
- **CloudFront**: `https://[distribution-id].cloudfront.net`
- **Custom Domain**: (optional) Configure in CloudFront settings

URLs are saved in `scripts/aws-config.sh` after setup.

## 📞 Support

For deployment issues:
1. Check the relevant documentation file
2. Verify AWS credentials: `aws sts get-caller-identity`
3. Run test script: `./scripts/test-deployment.sh`
4. Check AWS Console for resource status

## 📝 License

© 2026 LER Landscaping. All rights reserved.

---

**Ready to deploy?** Open [`SETUP-CHECKLIST.md`](SETUP-CHECKLIST.md) and follow the steps! 🚀
