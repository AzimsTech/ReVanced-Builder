# ReVanced-Builder :hammer:

[![Downloads][downloads-shield]][downloads-url]
[![GitHub Workflow Status][ci-status-shield]][ci-url]
[![Release][release-shield]][downloads-url]

🤖 Automate the process of downloading, patching, and releasing a patched Revanced YT APK.

| Script | Description |
|----------|---------|
| `get-stable-cli.sh` | Retrieves and downloads the latest [revanced-cli](https://github.com/revanced/revanced-cli) JAR URL from the Revanced API |
| `get-dev-rvp.sh` | Retrieves and downloads the latest pre-release of the [revanced-patches](https://github.com/revanced/revanced-patches) .RVP patch file. |
| `fetch-yt-ver.sh` | Uses [revanced-cli](https://github.com/revanced/revanced-cli) to extract and print the latest supported YT version from patch index 193 (com.google.android.YT). |
| `fetch-yt-ver.sh` | Fetch the latest apkmd binary release from the [tanishqmanuja/apkmirror-downloader](https://github.com/tanishqmanuja/apkmirror-downloader) GitHub repo , download it, save it as apkmd, and make it executable. |
| `start-patching.sh` | Run the revanced-cli to patch the yt.apk file using the specified .rvp patch bundle. |

<!-- Shields -->

[ci-status-shield]: https://img.shields.io/github/actions/workflow/status/azimstech/revanced-builder/build-revanced.yml?style=for-the-badge
[ci-url]:https://github.com/AzimsTech/ReVanced-Builder/actions/workflows/build-revanced.yml
[downloads-shield]: https://img.shields.io/github/downloads/azimstech/revanced-builder/total?style=for-the-badge&logo=github
[downloads-url]: https://github.com/azimstech/revanced-builder/releases/latest
[release-shield]: https://img.shields.io/github/v/release/azimstech/revanced-builder?style=for-the-badge