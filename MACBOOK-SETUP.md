# 💻 MacBook Air Setup Checklist

## What You Need on Your MacBook Air

When you open this repo on your MacBook Air, here's what you'll need installed to work with AWS deployments.

---

## ✅ Required Software

### 1. **Git** (for cloning repos)
**Check if installed:**
```bash
git --version
```
**Expected output:** `git version 2.x.x`

**If not installed:** macOS will prompt you to install Xcode Command Line Tools

---

### 2. **AWS CLI** (for AWS deployments)
**Check if installed:**
```bash
aws --version
```
**Expected output:** `aws-cli/2.x.x`

**If not installed:**
```bash
# Install using Homebrew (recommended)
brew install awscli

# OR download from AWS
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
```

---

### 3. **Homebrew** (package manager - optional but recommended)
**Check if installed:**
```bash
brew --version
```

**If not installed:**
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

---

## 🔧 Configuration Needed

### Configure AWS CLI with Your Credentials

Once AWS CLI is installed, configure it with your credentials:

```bash
aws configure
```

**Enter these values:**
- **AWS Access Key ID:** (from `github-deploy_accessKeys.csv`)
- **AWS Secret Access Key:** (from `github-deploy_accessKeys.csv`)
- **Default region name:** `us-east-1`
- **Default output format:** `json`

---

## 📋 Quick Setup Script

Run this on your MacBook Air to check everything:

```bash
# Check Git
echo "Checking Git..."
git --version || echo "❌ Git not installed"

# Check AWS CLI
echo "Checking AWS CLI..."
aws --version || echo "❌ AWS CLI not installed"

# Check Homebrew
echo "Checking Homebrew..."
brew --version || echo "⚠️  Homebrew not installed (optional)"

# Check AWS configuration
echo "Checking AWS credentials..."
aws sts get-caller-identity || echo "❌ AWS not configured"
```

---

## 🚀 First-Time Setup on MacBook Air

### Step 1: Clone the Repo
```bash
cd ~/Documents/GitHub
git clone https://github.com/Dronesmiths/LER-Landscaping.git
cd LER-Landscaping
```

### Step 2: Verify AWS CLI
```bash
aws --version
```

### Step 3: Configure AWS (if needed)
```bash
aws configure
# Enter the credentials from above
```

### Step 4: Test AWS Connection
```bash
aws sts get-caller-identity
```

**Expected output:**
```json
{
    "UserId": "AIDA2CFB3WHJ5LU2QOLJJ",
    "Account": "691829191123",
    "Arn": "arn:aws:iam::691829191123:user/github-deploy"
}
```

### Step 5: You're Ready!
```bash
# Test deployment (optional)
./scripts/deploy-s3.sh
```

---

## 🎯 What You DON'T Need

You **DON'T** need to install on your MacBook Air:
- ❌ Node.js (unless your website uses it)
- ❌ Python (AWS CLI includes it)
- ❌ Docker
- ❌ Any other build tools

**Just Git + AWS CLI is enough!**

---

## 💡 Quick Test When You Switch Computers

When you open this repo on your MacBook Air, just ask me:

**"Check if I have everything installed for AWS deployment"**

I'll run the checks and tell you what's missing!

---

## 🔐 Security Note

Your AWS credentials will be stored in:
```
~/.aws/credentials
~/.aws/config
```

These files are **local only** and won't sync between computers. You'll need to run `aws configure` on each computer you use.

---

## 📝 Summary

### Minimum Requirements:
1. ✅ **Git** - Clone repos
2. ✅ **AWS CLI** - Deploy to AWS
3. ✅ **AWS Credentials** - Configured via `aws configure`

### Optional but Helpful:
- Homebrew - Easy package management
- VS Code - Code editor

---

## 🆘 If Something's Missing

Just tell me:
- **"Install AWS CLI on my MacBook Air"**
- **"Configure AWS credentials"**
- **"Check my AWS setup"**

I'll guide you through it! 😊
