#!/bin/bash
# Run after every publish to this repo: tells the family Worker to
# re-copy all manifests from GitHub's API (no CDN cache), so running
# Toolboxes see the new release in seconds instead of minutes.
# Public and unauthenticated by design — the Worker only ever copies
# from this repo itself, so the call can't inject anything.
set -euo pipefail
curl -s -X POST https://kls-usage.kls-tools.workers.dev/manifest/refresh
echo
