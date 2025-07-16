#!/bin/bash

set -euo pipefail

REPO="tanishqmanuja/apkmirror-downloader"
API="https://api.github.com/repos/$REPO/releases?per_page=10"

# Step 1: Fetch releases
releases=$(curl -s "$API")

# Step 2: Get the latest release tag (no prerelease filtering)
latest_tag=$(echo "$releases" \
  | jq -r '.[0].tag_name')

if [ -z "$latest_tag" ]; then
  echo "❌ No release found!" >&2
  exit 1
fi
echo "Found latest release: $latest_tag" >&2

# Step 3: Get the download URL for the 'apkmd' asset (no extension)
download_url=$(echo "$releases" \
  | jq -r --arg tag "$latest_tag" '
    .[] | select(.tag_name == $tag) | .assets[] |
    select(.name == "apkmd") |
    .browser_download_url
  ' | head -n1)

if [ -z "$download_url" ]; then
  echo "❌ No apkmd asset found for $latest_tag" >&2
  exit 1
fi

echo "Downloading: $download_url" >&2
curl -L "$download_url" -o apkmd
chmod +x apkmd
echo "✅ Saved and made executable: apkmd" >&2

# Output version tag without the leading "v"
echo "${latest_tag#v}"
