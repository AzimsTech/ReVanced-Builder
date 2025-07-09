#!/bin/bash
latest=$(java -jar revanced-cli-*-all.jar list-patches --with-packages --with-versions --with-options patches-*-dev.*.rvp | \
awk '
/^Index: 193$/ { in_block=1 }
/^Index: [0-9]+$/ && $2 != 193 { in_block=0 }
in_block && /^[[:space:]]+[0-9]+\.[0-9]+\.[0-9]+$/ { versions[$1] = 1 }
END {
  for (v in versions) print v
}' | sort -V | tail -n1)


echo "Suggested YT version: $latest "
