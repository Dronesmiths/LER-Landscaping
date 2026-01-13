#!/bin/bash

# AWS CloudFront Setup Script for LER Landscaping Website
# This script creates and configures a CloudFront distribution

set -e

# Load configuration
if [ -f scripts/aws-config.sh ]; then
    source scripts/aws-config.sh
else
    echo "❌ Error: Configuration file not found."
    echo "Run ./scripts/setup-s3.sh first to create the S3 bucket."
    exit 1
fi

echo "=========================================="
echo "CloudFront Distribution Setup"
echo "=========================================="
echo ""
echo "Bucket: $BUCKET_NAME"
echo "Region: $AWS_REGION"
echo ""

# Create CloudFront distribution configuration
echo "☁️  Creating CloudFront distribution..."

# Generate a unique caller reference
CALLER_REFERENCE="ler-landscaping-$(date +%s)"

# Create distribution config JSON
cat > /tmp/cloudfront-config.json <<EOF
{
    "CallerReference": "$CALLER_REFERENCE",
    "Comment": "LER Landscaping Website CDN",
    "DefaultRootObject": "index.html",
    "Origins": {
        "Quantity": 1,
        "Items": [
            {
                "Id": "S3-$BUCKET_NAME",
                "DomainName": "$BUCKET_NAME.s3-website-$AWS_REGION.amazonaws.com",
                "CustomOriginConfig": {
                    "HTTPPort": 80,
                    "HTTPSPort": 443,
                    "OriginProtocolPolicy": "http-only"
                }
            }
        ]
    },
    "DefaultCacheBehavior": {
        "TargetOriginId": "S3-$BUCKET_NAME",
        "ViewerProtocolPolicy": "redirect-to-https",
        "AllowedMethods": {
            "Quantity": 2,
            "Items": ["GET", "HEAD"],
            "CachedMethods": {
                "Quantity": 2,
                "Items": ["GET", "HEAD"]
            }
        },
        "Compress": true,
        "ForwardedValues": {
            "QueryString": false,
            "Cookies": {
                "Forward": "none"
            }
        },
        "MinTTL": 0,
        "DefaultTTL": 86400,
        "MaxTTL": 31536000
    },
    "CustomErrorResponses": {
        "Quantity": 2,
        "Items": [
            {
                "ErrorCode": 404,
                "ResponsePagePath": "/404.html",
                "ResponseCode": "404",
                "ErrorCachingMinTTL": 300
            },
            {
                "ErrorCode": 403,
                "ResponsePagePath": "/index.html",
                "ResponseCode": "200",
                "ErrorCachingMinTTL": 300
            }
        ]
    },
    "Enabled": true,
    "PriceClass": "PriceClass_100"
}
EOF

# Create the distribution
DISTRIBUTION_OUTPUT=$(aws cloudfront create-distribution \
    --distribution-config file:///tmp/cloudfront-config.json \
    --region us-east-1 2>&1)

if [ $? -eq 0 ]; then
    # Extract distribution ID and domain name
    DISTRIBUTION_ID=$(echo "$DISTRIBUTION_OUTPUT" | grep -o '"Id": "[^"]*"' | head -1 | cut -d'"' -f4)
    CLOUDFRONT_DOMAIN=$(echo "$DISTRIBUTION_OUTPUT" | grep -o '"DomainName": "[^"]*"' | head -1 | cut -d'"' -f4)
    
    echo "✅ CloudFront distribution created successfully"
    echo ""
    
    # Update configuration file
    cat >> scripts/aws-config.sh <<EOF

# CloudFront Configuration
export CLOUDFRONT_DISTRIBUTION_ID="$DISTRIBUTION_ID"
export CLOUDFRONT_URL="https://$CLOUDFRONT_DOMAIN"
EOF
    
    echo "💾 Configuration updated"
    echo ""
    
    # Display summary
    echo "=========================================="
    echo "✅ CloudFront Setup Complete!"
    echo "=========================================="
    echo ""
    echo "Distribution ID: $DISTRIBUTION_ID"
    echo "CloudFront URL: https://$CLOUDFRONT_DOMAIN"
    echo ""
    echo "⏳ Note: It may take 15-20 minutes for the distribution to be fully deployed."
    echo ""
    echo "Check status with:"
    echo "aws cloudfront get-distribution --id $DISTRIBUTION_ID --query 'Distribution.Status'"
    echo ""
    echo "Once deployed, your website will be available at:"
    echo "https://$CLOUDFRONT_DOMAIN"
    echo ""
else
    echo "❌ Error creating CloudFront distribution:"
    echo "$DISTRIBUTION_OUTPUT"
    exit 1
fi

rm /tmp/cloudfront-config.json
