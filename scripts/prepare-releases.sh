#!/usr/bin/env bash
# Create missing GitHub pre-release entries and version tags for Lumen RT.
# Requires: GitHub CLI (gh), an authenticated GitHub account with write access,
# and a checkout of this repository.
set -euo pipefail

repository="rmiss1/LumenRT-Releases"
versions=(
  "0.1.0-alpha"
  "0.1.0-alpha.1"
  "0.1.0-alpha.2"
  "0.1.2-alpha"
  "0.1.2-alpha.1"
  "0.1.3-alpha"
  "0.1.4"
)

for version in "${versions[@]}"; do
  tag="v${version}"
  if gh release view "${tag}" --repo "${repository}" >/dev/null 2>&1; then
    echo "Already exists: ${tag}"
    continue
  fi
  gh release create "${tag}" \
    --repo "${repository}" \
    --title "Lumen RT ${version} — Early Alpha" \
    --notes-file "release-notes/${tag}.md" \
    --prerelease \
    --target main
  echo "Created: ${tag}"
done

echo "Release pages prepared. Upload the matching JAR files in GitHub Releases > Edit > Assets."
