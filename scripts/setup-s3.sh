#!/bin/bash

# AWS S3 Bucket Setup Script for LER Landscaping Website
# This script creates and configures an S3 bucket for static website hosting

set -e

# Configuration
BUCKET_NAME="${BUCKET_NAME:-ler-landscaping-$(date +%s)}"
REGION="${AWS_REGION:-us-east-1}"
WEBSITE_INDEX="index.html"
WEBSITE_ERROR="404.html"

echo "=========================================="
echo "AWS S3 Bucket Setup for LER Landscaping"
echo "=========================================="
echo ""
echo "Bucket Name: $BUCKET_NAME"
echo "Region: $REGION"
echo ""

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "❌ Error: AWS CLI is not installed."
    echo "Install it with: brew install awscli"
    exit 1
fi

# Check if AWS credentials are configured
if ! aws sts get-caller-identity &> /dev/null; then
    echo "❌ Error: AWS credentials are not configured."
    echo "Run: aws configure"
    exit 1
fi

echo "✅ AWS CLI is configured"
echo ""

# Create S3 bucket
echo "📦 Creating S3 bucket: $BUCKET_NAME"
if [ "$REGION" = "us-east-1" ]; then
    aws s3api create-bucket \
        --bucket "$BUCKET_NAME" \
        --region "$REGION"
else
    aws s3api create-bucket \
        --bucket "$BUCKET_NAME" \
        --region "$REGION" \
        --create-bucket-configuration LocationConstraint="$REGION"
fi

echo "✅ Bucket created successfully"
echo ""

# Enable versioning (optional but recommended)
echo "🔄 Enabling versioning..."
aws s3api put-bucket-versioning \
    --bucket "$BUCKET_NAME" \
    --versioning-configuration Status=Enabled

echo "✅ Versioning enabled"
echo ""

# Configure bucket for static website hosting
echo "🌐 Configuring static website hosting..."
aws s3 website "s3://$BUCKET_NAME" \
    --index-document "$WEBSITE_INDEX" \
    --error-document "$WEBSITE_ERROR"

echo "✅ Static website hosting configured"
echo ""

# Create bucket policy for public read access
echo "🔓 Setting bucket policy for public access..."
cat > /tmp/bucket-policy.json <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::$BUCKET_NAME/*"
        }
    ]
}
EOF

# Disable block public access settings
aws s3api put-public-access-block \
    --bucket "$BUCKET_NAME" \
    --public-access-block-configuration \
    "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false"

# Apply bucket policy
aws s3api put-bucket-policy \
    --bucket "$BUCKET_NAME" \
    --policy file:///tmp/bucket-policy.json

rm /tmp/bucket-policy.json

echo "✅ Bucket policy applied"
echo ""

# Save bucket configuration
echo "💾 Saving configuration..."
cat > scripts/aws-config.sh <<EOF
#!/bin/bash
# AWS Configuration for LER Landscaping Website
export BUCKET_NAME="$BUCKET_NAME"
export AWS_REGION="$REGION"
export WEBSITE_URL="http://$BUCKET_NAME.s3-website-$REGION.amazonaws.com"
EOF

chmod +x scripts/aws-config.sh

echo "✅ Configuration saved to scripts/aws-config.sh"
echo ""

# Display summary
echo "=========================================="
echo "✅ S3 Bucket Setup Complete!"
echo "=========================================="
echo ""
echo "Bucket Name: $BUCKET_NAME"
echo "Region: $REGION"
echo "Website URL: http://$BUCKET_NAME.s3-website-$REGION.amazonaws.com"
echo ""
echo "Next steps:"
echo "1. Run ./scripts/deploy-s3.sh to upload your website"
echo "2. Run ./scripts/setup-cloudfront.sh to set up CloudFront CDN"
echo ""
