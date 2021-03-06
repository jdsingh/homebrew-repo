#!/usr/bin/env bash

current_version() {
  CURRENT_VERSION=$(grep version ./Formula/jacoco-parser.rb | cut -d'"' -f2 | cut -d'v' -f2)
  printf "Current Version: %s\n" "$CURRENT_VERSION"
}

download_latest_release() {
  rm artifacts/*.zip
  gh release download -R jdsingh/jacoco-parser -p "*.zip" --dir artifacts
  tree
}

new_version_sha() {
  NEW_VERSION_SHA256=$(sha256sum ./artifacts/jacoco-parser-"$NEW_VERSION".zip | cut -d ' ' -f1)
  # shellcheck disable=SC2059
  printf "SHA256 $NEW_VERSION_SHA256 jacoco-parser-$NEW_VERSION.zip\n"
}

replace_version_and_sha() {
  sed -i '' "s/[0-9]\.[0.9]\.[0-9]/$NEW_VERSION/g" ./Formula/jacoco-parser.rb
  sed -i '' -E "s/[A-Fa-f0-9]{64}/$NEW_VERSION_SHA256/g" ./Formula/jacoco-parser.rb
}

update_homebrew_repo() {
  git add ./Formula/jacoco-parser.rb
  git commit -m "Update jacoco-parser version to v$NEW_VERSION"
  git push origin main
}

NEW_VERSION=$1
printf "New Version: %s\n" "$NEW_VERSION"

current_version
download_latest_release
new_version_sha
replace_version_and_sha
update_homebrew_repo
