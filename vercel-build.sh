#!/usr/bin/env bash
set -euo pipefail

if command -v flutter >/dev/null 2>&1; then
  flutter_bin="$(command -v flutter)"
else
  sdk_dir="$(mktemp -d)"
  trap 'rm -rf "$sdk_dir"' EXIT

  releases_file="$sdk_dir/releases_linux.json"
  curl --fail --location --silent --show-error \
    https://storage.googleapis.com/flutter_infra_release/releases/releases_linux.json \
    --output "$releases_file"

  archive="$(node -e '
    const releases = require(process.argv[1]);
    const stable = releases.releases.find(
      (release) =>
        release.channel === "stable" &&
        release.version === releases.current_release.stable,
    );
    if (!stable) process.exit(1);
    process.stdout.write(stable.archive);
  ' "$releases_file")"

  curl --fail --location --silent --show-error \
    "https://storage.googleapis.com/flutter_infra_release/releases/$archive" |
    tar -xJ -C "$sdk_dir"
  flutter_bin="$sdk_dir/flutter/bin/flutter"
fi

"$flutter_bin" config --no-analytics
"$flutter_bin" pub get
"$flutter_bin" build web --release
