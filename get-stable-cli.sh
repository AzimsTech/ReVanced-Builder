#!/bin/bash
set -euo pipefail

API="https://api.revanced.app/tools"

# Get latest revanced-cli jar url
jar_url=$(curl -s "$API" | jq -r '
  .tools[]
  | select(.repository=="revanced/revanced-cli")
  | select(.name | test("^revanced-cli-.*-all\\.jar$"))
  | .browser_download_url' | head -n1)

[ -n "$jar_url" ] || { echo "❌ No revanced-cli jar found" >&2; exit 1; }

filename="${jar_url##*/}"
version=$(echo "$filename" | sed -E 's/^revanced-cli-([0-9.]+)-all\.jar$/\1/')

# Version-only mode
if [[ "${1:-}" == "--version-only" ]]; then
  echo "ReVanced CLI stable version: $version" >&2
  echo "$version"
  exit 0
fi

echo "Downloading: $jar_url" >&2
curl -L "$jar_url" -o "$filename"
echo "✅ Saved as $filename" >&2
echo "$version"
