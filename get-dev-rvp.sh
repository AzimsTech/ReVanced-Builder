#!/bin/bash
set -euo pipefail

API="https://api.github.com/repos/ReVanced/revanced-patches/releases?per_page=10"

# Get releases (no retry, just fail if broken)
releases=$(curl -s "$API" | jq '.')

# Latest prerelease by semantic version
latest_tag=$(echo "$releases" \
  | jq -r '[.[] | select(.prerelease == true)]
           | sort_by(.tag_name | sub("^v";"") | split(".") | map(tonumber? // 0))
           | last | .tag_name')

[ -n "$latest_tag" ] || { echo "❌ No prerelease found"; exit 1; }

# Version-only mode
if [[ "${1:-}" == "--version-only" ]]; then
  echo "ReVanced Patches dev version: $latest_tag" >&2 # log to console
  echo "$latest_tag"
  exit 0
fi

echo "Found prerelease: $latest_tag" >&2

# Download the .rvp file
download_url=$(echo "$releases" \
  | jq -r --arg tag "$latest_tag" '
    .[] | select(.tag_name == $tag) | .assets[]
    | select(.name | test("^patches-.*-dev\\..*\\.rvp$"))
    | .browser_download_url' | head -n1)

[ -n "$download_url" ] || { echo "❌ No .rvp found for $latest_tag"; exit 1; }

curl -L "$download_url" -o "${download_url##*/}"
echo "Downloaded: ${download_url##*/}"
