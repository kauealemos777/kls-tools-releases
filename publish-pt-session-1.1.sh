#!/bin/bash
# Publishes the already-built PT Session Toolkit 1.1 to this releases repo.
# Safe to re-run; touches only the pt-session-toolkit/ folder.
set -euo pipefail
cd "$(dirname "$0")"

DMG_SOURCE="$HOME/Projects/PTSessionToolkit/dist/PT Session Toolkit 1.1.dmg"
[ -f "$DMG_SOURCE" ] || { echo "Build missing: $DMG_SOURCE"; exit 1; }

git pull
SHA=$(shasum -a 256 "$DMG_SOURCE" | awk '{print $1}')
rm -f "pt-session-toolkit/PT Session Toolkit 1.0.dmg"
cp "$DMG_SOURCE" pt-session-toolkit/

python3 - "$SHA" <<'EOF'
import json, sys
m = json.load(open('pt-session-toolkit/manifest.json'))
m['latestVersion'] = '1.1'
m['downloadURL'] = "https://raw.githubusercontent.com/kauealemos777/kls-tools-releases/main/pt-session-toolkit/PT%20Session%20Toolkit%201.1.dmg"
m['sha256'] = sys.argv[1]
m['releasedAt'] = '2026-08-07'
json.dump(m, open('pt-session-toolkit/manifest.json', 'w'), indent=2)
EOF

git add pt-session-toolkit/
git commit -m "Publish PT Session Toolkit 1.1"
git push
echo
echo "Published. Waiting 30s for GitHub's cache, then verifying…"
sleep 30
curl -s "https://raw.githubusercontent.com/kauealemos777/kls-tools-releases/main/pt-session-toolkit/manifest.json" | python3 -c "import json,sys; m=json.load(sys.stdin); print('Served version:', m['latestVersion'])"
