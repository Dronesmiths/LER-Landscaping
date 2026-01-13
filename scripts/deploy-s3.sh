#!/bin/bash

# AWS S3 Deployment Script for LER Landscaping Website
# This script syncs website files to S3 and invalidates CloudFront cache

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
echo "Deploying LER Landscaping Website to S3"
echo "=========================================="
echo ""
echo "Bucket: $BUCKET_NAME"
echo "Region: $AWS_REGION"
echo ""

# Sync files to S3 with appropriate cache headers
echo "📤 Uploading files to S3..."

# Upload HTML files with no-cache headers
aws s3 sync . "s3://$BUCKET_NAME" \
    --exclude "*" \
    --include "*.html" \
    --cache-control "public, max-age=0, must-revalidate" \
    --delete \
    --region "$AWS_REGION"

# Upload CSS files with long cache
aws s3 sync css/ "s3://$BUCKET_NAME/css/" \
    --content-type "text/css" \
    --cache-control "public, max-age=31536000, immutable" \
    --delete \
    --region "$AWS_REGION"

# Upload JS files with long cache
aws s3 sync js/ "s3://$BUCKET_NAME/js/" \
    --content-type "application/javascript" \
    --cache-control "public, max-age=31536000, immutable" \
    --delete \
    --region "$AWS_REGION"

# Upload images with long cache
aws s3 sync images/ "s3://$BUCKET_NAME/images/" \
    --cache-control "public, max-age=31536000, immutable" \
    --delete \
    --region "$AWS_REGION"

# Upload subdirectories (about, contact, locations, services)
for dir in about contact locations services; do
    if [ -d "$dir" ]; then
        echo "📁 Uploading $dir directory..."
        aws s3 sync "$dir/" "s3://$BUCKET_NAME/$dir/" \
            --cache-control "public, max-age=0, must-revalidate" \
            --delete \
            --region "$AWS_REGION"
    fi
done

echo "✅ Files uploaded successfully"
echo ""

# Invalidate CloudFront cache if distribution exists
if [ ! -z "$CLOUDFRONT_DISTRIBUTION_ID" ]; then
    echo "🔄 Invalidating CloudFront cache..."
    aws cloudfront create-invalidation \
        --distribution-id "$CLOUDFRONT_DISTRIBUTION_ID" \
        --paths "/*" \
        --region "$AWS_REGION" > /dev/null
    echo "✅ CloudFront cache invalidated"
    echo ""
fi

# Display summary
echo "=========================================="
echo "✅ Deployment Complete!"
echo "=========================================="
echo ""
echo "Website URL: $WEBSITE_URL"

if [ ! -z "$CLOUDFRONT_URL" ]; then
    echo "CloudFront URL: $CLOUDFRONT_URL"
fi

echo ""
echo "🌐 Your website is now live!"
echo ""
