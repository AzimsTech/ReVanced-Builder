#!/bin/bash
set -euo pipefail

# Get the latest YT version from ReVanced patches
latest=$(java -jar revanced-cli-*-all.jar list-patches --with-packages --with-versions --with-options patches-*-dev.*.rvp | \
awk '
/^Index: 193$/ { in_block=1 }
/^Index: [0-9]+$/ && $2 != 193 { in_block=0 }
in_block && /^[[:space:]]+[0-9]+\.[0-9]+\.[0-9]+$/ { versions[$1] = 1 }
END {
  for (v in versions) print v
}' | sort -V | tail -n1)

[ -n "$latest" ] || { echo "❌ No YT version found"; exit 1; }

# Version-only mode
if [[ "${1:-}" == "--version-only" ]]; then
  echo "YouTube version: $latest" >&2  # log to console
  echo "$latest"
  exit 0
fi

echo "Found YT version: $latest" >&2
echo "$latest"