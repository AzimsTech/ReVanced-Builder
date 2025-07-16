#!/bin/bash

set -euo pipefail

# Fetch the API data
json=$(curl -s "https://api.revanced.app/tools")

# Extract latest revanced-cli .jar URL safely
jar_url=$(echo "$json" | jq -r '
  .tools[]
  | select(.repository == "revanced/revanced-cli")
  | select(.name != null and (.name | type == "string") and (.name | endswith(".jar")))
  | .browser_download_url
  ' | head -n1)

if [ -n "$jar_url" ]; then
  filename="${jar_url##*/}"
  echo "Downloading: $jar_url" >&2
  curl -L "$jar_url" -o "$filename"
  echo "✅ Saved as $filename" >&2

  version=$(echo "$filename" | sed -n 's/^revanced-cli-\([0-9.]\+\)-all\.jar$/\1/p')
  if [ -n "$version" ]; then
    echo "$version"
  else
    echo "❌ Error: Could not extract version from filename." >&2
    exit 1
  fi
else
  echo "❌ Error: Could not find revanced-cli jar in API response." >&2
  exit 1
fi
