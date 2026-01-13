#!/bin/bash

# AWS Credentials Setup Helper
# This script will configure your AWS credentials

echo "=========================================="
echo "AWS Credentials Setup"
echo "=========================================="
echo ""

# Get credentials from user
echo "Please enter your AWS Access Key ID:"
read -r AWS_ACCESS_KEY_ID

echo ""
echo "Please enter your AWS Secret Access Key:"
read -r AWS_SECRET_ACCESS_KEY

echo ""
echo "Enter your preferred AWS region (default: us-east-1):"
read -r AWS_REGION
AWS_REGION=${AWS_REGION:-us-east-1}

# Create .aws directory if it doesn't exist
mkdir -p ~/.aws

# Create credentials file
cat > ~/.aws/credentials <<EOF
[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
EOF

# Create config file
cat > ~/.aws/config <<EOF
[default]
region = $AWS_REGION
output = json
EOF

echo ""
echo "✅ AWS credentials configured successfully!"
echo ""
echo "Verifying credentials..."
aws sts get-caller-identity

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Credentials verified! You're ready to deploy."
else
    echo ""
    echo "❌ Credential verification failed. Please check your keys and try again."
fi
