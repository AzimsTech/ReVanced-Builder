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

# Download if URL was found
if [ -n "$jar_url" ]; then
  filename="${jar_url##*/}"
  echo "Downloading: $jar_url"
  curl -L "$jar_url" -o "$filename"
  echo "✅ Saved as $filename"
else
  echo "❌ Error: Could not find revanced-cli jar in API response."
  exit 1
fi
