# KL's Tools — Releases

Built binaries and update feeds for the KL's Tools family, published
here so Sparkle, the Toolbox's own installer, and anyone with a link
can fetch them over plain HTTPS without authentication.

**This repo contains no source code, and never will.** Every tool's
actual source lives in its own private repo:

- [LKLicenseKit](https://github.com/kauealemos777/LKLicenseKit)
- [KLsAudioLocalizationToolbox](https://github.com/kauealemos777/KLsAudioLocalizationToolbox) — the Toolbox
- [PTSessionToolkit](https://github.com/kauealemos777/PTSessionToolkit)
- [AudioDistributionToolkit](https://github.com/kauealemos777/AudioDistributionToolkit)
- [AudioQAToolkit](https://github.com/kauealemos777/AudioQAToolkit)
- [ASRECToolkit](https://github.com/kauealemos777/ASRECToolkit)
- [EarthMergeStemsToolkit](https://github.com/kauealemos777/EarthMergeStemsToolkit)

## Layout

Each tool gets its own folder here, holding its versioned release
archive plus two parallel feeds that read the same underlying release
for two different consumers:

```
audio-qa-toolkit/
  Audio QA Toolkit 1.3.dmg
  manifest.json     — read by the Toolbox's own "Install" button
  appcast.xml        — read by that app's own Sparkle self-updater (once wired up)
```

- **`manifest.json`** is the simple format the Toolbox uses to offer
  installing/updating a sibling tool from inside its own UI, without
  that tool needing to be installed (or running) first:
  ```json
  {
    "displayName": "Audio QA Toolkit",
    "latestVersion": "1.3",
    "installedAppName": "Audio QA Toolkit.app",
    "downloadURL": "https://raw.githubusercontent.com/kauealemos777/kls-tools-releases/main/audio-qa-toolkit/Audio%20QA%20Toolkit%201.3.dmg",
    "sha256": "<the dmg's sha256>",
    "releasedAt": "2026-08-06"
  }
  ```
  The Toolbox downloads `downloadURL`, verifies it against `sha256`,
  mounts the `.dmg`, and copies `installedAppName` into
  `~/Applications`.

- **`appcast.xml`** is Sparkle's own format, EdDSA-signed, read by
  that tool's *own* already-running copy to check for updates on
  itself. Not every tool has this wired up yet.

Each tool's `SUFeedURL` (once Sparkle is added) points at its own
folder's `appcast.xml` via this repo's raw GitHub URL, same pattern as
`manifest.json` above.
