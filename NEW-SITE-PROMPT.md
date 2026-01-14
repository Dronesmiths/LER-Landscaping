# 🚀 New Site Deployment - Copy/Paste Prompt

## When You Start a New Conversation with a Cloned Repo

After you've cloned a new repo and opened it in Antigravity, just copy and paste this:

---

## 📋 THE PROMPT (Copy This!)

```
Set up AWS deployment for this site using the LER-Landscaping template.

Bucket name: [YOUR-SITE-NAME]

Please:
1. Copy deployment files from LER-Landscaping repo
2. Create S3 bucket and configure it
3. Set up CloudFront distribution
4. Add all GitHub secrets automatically
5. Test the deployment
6. Give me the live URLs
```

---

## ✏️ How to Customize

Just replace `[YOUR-SITE-NAME]` with your actual bucket name.

### Examples:

#### For a car wash site:
```
Set up AWS deployment for this site using the LER-Landscaping template.

Bucket name: premium-carwash

Please:
1. Copy deployment files from LER-Landscaping repo
2. Create S3 bucket and configure it
3. Set up CloudFront distribution
4. Add all GitHub secrets automatically
5. Test the deployment
6. Give me the live URLs
```

#### For a tree service:
```
Set up AWS deployment for this site using the LER-Landscaping template.

Bucket name: elite-tree-service

Please:
1. Copy deployment files from LER-Landscaping repo
2. Create S3 bucket and configure it
3. Set up CloudFront distribution
4. Add all GitHub secrets automatically
5. Test the deployment
6. Give me the live URLs
```

#### For a real estate site:
```
Set up AWS deployment for this site using the LER-Landscaping template.

Bucket name: downtown-realty

Please:
1. Copy deployment files from LER-Landscaping repo
2. Create S3 bucket and configure it
3. Set up CloudFront distribution
4. Add all GitHub secrets automatically
5. Test the deployment
6. Give me the live URLs
```

---

## 🎯 What Happens Next

After you paste that prompt, I will automatically:

1. ✅ **Copy files** from LER-Landscaping:
   - `.github/workflows/deploy.yml`
   - `scripts/deploy-s3.sh`
   - `scripts/setup-cloudfront.sh`
   - `.gitignore`

2. ✅ **Create S3 bucket** with your chosen name

3. ✅ **Configure S3**:
   - Enable static website hosting
   - Set public access permissions
   - Apply bucket policy

4. ✅ **Set up CloudFront**:
   - Create distribution
   - Configure HTTPS
   - Set up custom error pages

5. ✅ **Add GitHub Secrets** (via browser automation):
   - AWS_ACCESS_KEY_ID
   - AWS_SECRET_ACCESS_KEY
   - AWS_REGION
   - S3_BUCKET_NAME
   - CLOUDFRONT_DISTRIBUTION_ID

6. ✅ **Test deployment** and give you URLs

**Total time: ~5 minutes**

---

## 📝 Bucket Naming Rules

✅ **Good names:**
- Lowercase letters
- Numbers
- Hyphens (-)
- Example: `my-awesome-site`

❌ **Avoid:**
- Uppercase letters
- Spaces
- Underscores
- Special characters (!@#$%^&*)

---

## 🔑 AWS Credentials

You don't need to provide credentials! They're stored in:
- `~/Documents/GitHub/LER-Landscaping/github-deploy_accessKeys.csv`

I'll use the same credentials for all your sites.

---

## 💡 Even Simpler Version

If you want the absolute shortest prompt:

```
Deploy this site to AWS using LER-Landscaping template. Bucket: [YOUR-SITE-NAME]
```

That's it! I'll know what to do! 😊

---

## 🆘 If Something Goes Wrong

Just say:
- "Check my AWS setup"
- "Verify AWS credentials are configured"
- "Help me troubleshoot deployment"

---

## 📚 What You Get

After the setup completes, you'll have:

- 🌐 **S3 URL:** `http://[bucket-name].s3-website-us-east-1.amazonaws.com`
- 🔒 **CloudFront URL:** `https://[random-id].cloudfront.net`
- ⚡ **Auto-deployment:** Push to `main` → deploys automatically
- 🌍 **Global CDN:** Fast loading worldwide

---

## 🎯 Quick Reference

| What You Want | Bucket Name Example |
|---------------|---------------------|
| Car wash site | `premium-carwash` |
| Tree service | `av-tree-pros` |
| HVAC company | `working-class-hvac` |
| Real estate | `la-homes-realty` |
| Landscaping | `ler-landscaping` |
| Barbershop | `elite-cuts-barber` |

---

## ✨ Pro Tips

1. **Choose bucket name first** - it must be globally unique
2. **Keep it short** - easier to remember
3. **Use company/brand name** - professional
4. **Test locally first** - make sure site works before deploying

---

**That's it! Just copy the prompt, change the bucket name, and paste it to me!** 🚀
