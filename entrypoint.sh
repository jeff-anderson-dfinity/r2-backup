#!/bin/sh -l
set -euo pipefail

if [ -z "$BUCKET_NAME" ]; then
  echo "BUCKET_NAME is not set."
  exit 1
fi

if [ -z "$ACCOUNT_ID" ]; then
  echo "ACCOUNT_ID is not set."
  exit 1
fi

if [ -z "$ACCESS_KEY_ID" ]; then
  echo "ACCESS_KEY_ID is not set."
  exit 1
fi

if [ -z "$SECRET_ACCESS_KEY" ]; then
  echo "SECRET_ACCESS_KEY is not set."
  exit 1
fi

export MC_HOST_s3=https://${ACCESS_KEY_ID}:${SECRET_ACCESS_KEY}@${ACCOUNT_ID}.r2.cloudflarestorage.com

mc mirror $* "." "s3/$BUCKET_NAME"
