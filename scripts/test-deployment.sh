#!/bin/bash

# Test Deployment Script for LER Landscaping Website
# This script verifies the deployment is working correctly

set -e

# Load configuration
if [ -f scripts/aws-config.sh ]; then
    source scripts/aws-config.sh
else
    echo "❌ Error: Configuration file not found."
    exit 1
fi

echo "=========================================="
echo "Testing LER Landscaping Website Deployment"
echo "=========================================="
echo ""

# Test S3 website endpoint
echo "🧪 Testing S3 website endpoint..."
S3_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$WEBSITE_URL")

if [ "$S3_STATUS" = "200" ]; then
    echo "✅ S3 website is accessible (HTTP $S3_STATUS)"
else
    echo "❌ S3 website returned HTTP $S3_STATUS"
fi
echo ""

# Test CloudFront if configured
if [ ! -z "$CLOUDFRONT_URL" ]; then
    echo "🧪 Testing CloudFront distribution..."
    
    # Check distribution status
    DIST_STATUS=$(aws cloudfront get-distribution \
        --id "$CLOUDFRONT_DISTRIBUTION_ID" \
        --query 'Distribution.Status' \
        --output text 2>/dev/null || echo "Error")
    
    echo "Distribution Status: $DIST_STATUS"
    
    if [ "$DIST_STATUS" = "Deployed" ]; then
        # Test CloudFront URL
        CF_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$CLOUDFRONT_URL")
        
        if [ "$CF_STATUS" = "200" ]; then
            echo "✅ CloudFront distribution is accessible (HTTP $CF_STATUS)"
        else
            echo "❌ CloudFront returned HTTP $CF_STATUS"
        fi
    else
        echo "⏳ CloudFront distribution is still deploying..."
        echo "   This can take 15-20 minutes. Please check back later."
    fi
    echo ""
fi

# List S3 bucket contents
echo "📦 S3 Bucket Contents:"
aws s3 ls "s3://$BUCKET_NAME" --recursive --human-readable --summarize | tail -20
echo ""

# Display URLs
echo "=========================================="
echo "🌐 Website URLs"
echo "=========================================="
echo ""
echo "S3 Website: $WEBSITE_URL"

if [ ! -z "$CLOUDFRONT_URL" ]; then
    echo "CloudFront: $CLOUDFRONT_URL"
fi

echo ""
echo "✅ Testing complete!"
echo ""
