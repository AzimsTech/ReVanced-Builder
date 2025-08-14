#!/bin/bash

set -euo pipefail

REPO="ReVanced/revanced-patches"
API="https://api.github.com/repos/$REPO/releases?per_page=10"

# Step 1: Fetch releases with retry
for i in {1..3}; do
  releases=$(curl -s "$API")
  
  # Check if it's valid JSON - if yes, break out of loop
  if echo "$releases" | jq empty 2>/dev/null; then
    break
  fi
  
  echo "Attempt $i failed, retrying..." >&2
  sleep 2
done

# Final check - if still not JSON, exit
if ! echo "$releases" | jq empty 2>/dev/null; then
  echo "❌ Failed to get valid JSON from GitHub API after 3 attempts" >&2
  exit 1
fi

# Step 2: Pick the latest pre-release tag name
latest_tag=$(echo "$releases" \
  | jq -r '.[] | select(.prerelease == true) | .tag_name' \
  | head -n1)

if [ -z "$latest_tag" ]; then
  echo "❌ No prerelease version found!" >&2
  exit 1
fi
echo "Found prerelease: $latest_tag" >&2

# Step 3: Get the download URL for .rvp file
download_url=$(echo "$releases" \
  | jq -r --arg tag "$latest_tag" '
    .[] | select(.tag_name == $tag) | .assets[] |
    select(.name | test("^patches-.*-dev\\..*\\.rvp$")) |
    .browser_download_url
  ' | head -n1)

if [ -z "$download_url" ]; then
  echo "❌ No .rvp asset found for $latest_tag" >&2
  exit 1
fi

echo "Downloading: $download_url" >&2
curl -L "$download_url" -o "${download_url##*/}"

filename="${download_url##*/}"
version_name=$(echo "$filename" | sed -E 's/^patches-(.+)\.rvp$/v\1/')
echo "$version_name"