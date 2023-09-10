#!/bin/sh -l
set -euo pipefail

# Check mirror target is set
if [ -z "$BUCKET_NAME" ]; then
  echo "BUCKET_NAME is not set."
  exit 1
fi

# Check if account ID is set
if [ -z "$ACCOUNT_ID" ]; then
  echo "ACCOUNT_ID is not set."
  exit 1
fi

# Set mc configuration
if [ -z "$AWS_SESSION_TOKEN" ]; then
  echo "This is for Cloudflare R2 buckets only."
  exit 1
else
  export MC_HOST_s3=https://${ACCESS_KEY_ID}:${SECRET_ACCESS_KEY}@${ACCOUNT_ID}.r2.cloudflarestorage.com
fi

# Execute mc mirror
mc mirror $* "." "s3/$BUCKET_NAME"
