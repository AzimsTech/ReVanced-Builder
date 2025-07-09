# ReVanced-Builder :hammer:

Automate the process of downloading, patching, and releasing a patched Revanced using [revanced/revanced-cli](https://github.com/revanced/revanced-cli) & [tanishqmanuja/apkmirror-downloader](https://github.com/tanishqmanuja/apkmirror-downloader).

| Script | Description |
|----------|---------|
| `get-stable-cli.sh` | Retrieves and downloads the latest [revanced-cli](https://github.com/revanced/revanced-cli) JAR URL from the Revanced API |
| `get-dev-rvp.sh` | Retrieves and downloads the latest pre-release of the [revanced-patches](https://github.com/revanced/revanced-patches) .RVP patch file. |
| `fetch-yt-ver.sh` | Uses [revanced-cli](https://github.com/revanced/revanced-cli) to extract and print the latest supported YT version from patch index 193 (com.google.android.YT). |
| `fetch-yt-ver.sh` | Fetch the latest apkmd binary release from the [tanishqmanuja/apkmirror-downloader](https://github.com/tanishqmanuja/apkmirror-downloader) GitHub repo , download it, save it as apkmd, and make it executable. |
| `start-patching.sh` | Run the revanced-cli to patch the yt.apk file using the specified .rvp patch bundle. |