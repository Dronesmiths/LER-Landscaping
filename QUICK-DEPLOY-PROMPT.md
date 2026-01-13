# 🚀 Quick Deployment Setup Prompt

## For New Websites

Copy and paste this prompt when starting a new website project:

---

**"Set up AWS deployment for this new site using the LER-Landscaping template. The bucket name should be `[your-site-name]`"**

---

## What This Does

The AI will automatically:

1. ✅ Copy deployment files from `LER-Landscaping` repo
2. ✅ Create S3 bucket: `[your-site-name]`
3. ✅ Configure static website hosting
4. ✅ Set up CloudFront distribution with HTTPS
5. ✅ Add all 5 GitHub secrets via browser automation
6. ✅ Test the deployment
7. ✅ Give you the live URLs

## Example Prompts

### For a new tree service site:
```
"Set up AWS deployment for this new site using the LER-Landscaping template. 
The bucket name should be av-tree-service"
```

### For a car wash site:
```
"Set up AWS deployment for this new site using the LER-Landscaping template. 
The bucket name should be premium-carwash"
```

### For a real estate site:
```
"Set up AWS deployment for this new site using the LER-Landscaping template. 
The bucket name should be la-homes-realty"
```

## What You Get

After running the prompt, you'll have:

- 🌐 **S3 Website URL:** `http://[bucket-name].s3-website-us-east-1.amazonaws.com`
- 🔒 **CloudFront HTTPS URL:** `https://[random-id].cloudfront.net`
- ⚡ **Automated Deployment:** Push to `main` → Auto-deploy in seconds
- 🌍 **Global CDN:** Fast loading worldwide

## AWS Credentials (Already Configured)

You don't need to provide these - they're stored in `github-deploy_accessKeys.csv`:

- **Access Key ID:** (stored in CSV file)
- **Secret Access Key:** (stored in CSV file)
- **Region:** `us-east-1`

These credentials work for ALL your sites!

## Files That Get Copied

```
.github/workflows/deploy.yml    ← GitHub Actions automation
scripts/deploy-s3.sh           ← Manual deployment script
scripts/setup-cloudfront.sh    ← CloudFront setup
.gitignore                     ← Security (prevents credential commits)
```

## After Setup

Just push to GitHub:

```bash
git add .
git commit -m "Initial deployment setup"
git push origin main
```

Your site deploys automatically! 🎉

## Bucket Naming Tips

✅ **Good names:**
- `company-name` (e.g., `ler-landscaping`)
- `service-location` (e.g., `av-tree-pros`)
- `brand-site` (e.g., `premium-carwash`)

❌ **Avoid:**
- Spaces or special characters
- Uppercase letters
- Very long names

## Need Help?

See full documentation:
- `DEPLOYMENT-TEMPLATE.md` - Complete guide
- `.agent/workflows/deploy-new-site.md` - Step-by-step workflow
- `GITHUB-SECRETS-SETUP.md` - Secrets configuration details

---

**That's it!** Just use the prompt above and you're ready to deploy! 🚀
