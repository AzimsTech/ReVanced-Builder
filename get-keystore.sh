#!/bin/bash
set -euo pipefail

API="https://api.github.com/repos/${{ github.repository }}/releases"

# Get latest tag
latest_tag=$(curl -s "$API" | jq -r '.[0].tag_name // empty')

if [ -z "$latest_tag" ]; then
    echo "No release found"
    echo "keystore_found=false" >> $GITHUB_OUTPUT
    exit 0
fi

echo "Found release: $latest_tag"

# Find keystore download URL
keystore_url=$(curl -s "$API" | jq -r \
--arg tag "$latest_tag" \
'.[] | select(.tag_name==$tag) | .assets[] | select(.name | endswith(".keystore")) | .browser_download_url' \
| head -n1)

if [ -n "$keystore_url" ]; then
    echo "Downloading keystore from: $keystore_url"
    curl -sL "$keystore_url" -o ${{ env.KEYSTORE_NAME }}
    echo "keystore_found=true" >> $GITHUB_OUTPUT
else
    echo "No keystore found in release"
    echo "keystore_found=false" >> $GITHUB_OUTPUT
fi