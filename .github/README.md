![cover](cover.png)

# ReVanced-Builder :hammer:

[![Downloads][downloads-shield]][downloads-url]
[![GitHub Workflow Status][ci-status-shield]][ci-url]
[![Release][release-shield]][downloads-url]

🤖 Automate the process of downloading, patching, and releasing a patched Revanced YT APK.

| Script              | Description                                                                                                                                                         |
|:--------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `get-stable-cli.sh` | Retrieves and downloads the latest [revanced-cli][cli-url] JAR URL from the Revanced API                                                                            |
| `get-dev-rvp.sh`    | Retrieves and downloads the latest pre-release of the [revanced-patches][patches-url] .RVP patch file.                                                              |
| `fetch-yt-ver.sh`   | Uses [revanced-cli][cli-url] to extract and print the latest supported YT version from [revanced-patches][patches-url]                                              |
| `get-apkmd.sh`      | Fetch the latest apkmd binary release from the [tanishqmanuja/apkmirror-downloader][apkmd-url] GitHub repo , download it, save it as apkmd, and make it executable. |


<!-- Shields -->

[ci-status-shield]: https://img.shields.io/github/actions/workflow/status/azimstech/revanced-builder/build-revanced.yml?style=for-the-badge
[ci-url]:https://github.com/AzimsTech/ReVanced-Builder/actions/workflows/build-revanced.yml
[downloads-shield]: https://img.shields.io/github/downloads/azimstech/revanced-builder/total?style=for-the-badge&logo=github
[downloads-url]: https://github.com/azimstech/revanced-builder/releases/latest
[release-shield]: https://img.shields.io/github/v/release/azimstech/revanced-builder?style=for-the-badge

<!-- Urls -->

[patches-url]:https://github.com/revanced/revanced-patches
[apkmd-url]:https://github.com/tanishqmanuja/apkmirror-downloader
[cli-url]:https://github.com/revanced/revanced-cli