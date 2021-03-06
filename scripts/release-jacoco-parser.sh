#!/usr/bin/env bash

APP_VERSION="0.0.1"

print_info() {
  # shellcheck disable=SC2059
  printf "$1\n"
}

print_warning() {
  YELLOW='\033[0;33m'
  NC='\033[0m'
  # shellcheck disable=SC2059
  printf "${YELLOW}$1${NC}\n"
}

print_success() {
  GREEN='\033[0;32m'
  NC='\033[0m'
  # shellcheck disable=SC2059
  printf "${GREEN}$1${NC}\n"
}

print_error() {
  RED='\033[0;31m'
  NC='\033[0m'
  # shellcheck disable=SC2059
  printf "${RED}$1${NC}\n"
}

print_help() {
  print_info "Usage: ./script/release-jacoco-parser.sh [OPTIONS] [Version]\n"
  print_info "  Release new version of jacoco-parser\n"
  print_info "Options:"
  print_info "  -h, --help                        Show this message and exit"
  print_info "  -v, --version                     Show the app version and exit"
  exit 0
}

options() {
  option_check_for_help
  option_check_for_version
}

option_check_for_help() {
  if [ "$OPTIONS" == "-h" ] || [ "$OPTIONS" == "--help" ]; then
    print_help
  fi
}

option_check_for_version() {
  if [ "$OPTIONS" == "-v" ] || [ "$OPTIONS" == "--version" ]; then
    print_info "Version: $APP_VERSION"
    exit 0
  fi
}

validations() {
  validate_new_version
  validate_current_branch_is_main
}

validate_new_version() {
  if [ "$NEW_VERSION" == "" ]; then
    print_help
  fi

  if [[ $NEW_VERSION =~ ^[0-9].[0-9].[0-9]$ ]]; then
    print_info "Releasing jacoco-parser v$NEW_VERSION"
  else
    print_error "Invalid version $NEW_VERSION\n"
    exit 1
  fi
}

validate_current_branch_is_main() {
  local current_branch
  current_branch=$(git branch --show-current)

  if [ "$current_branch" != "main" ]; then
    print_error "\nYou are on $current_branch branch"
    print_error "Make sure your are on 'main' git branch"
    exit 1
  fi
}

get_current_version() {
  CURRENT_VERSION=$(grep version ./Formula/jacoco-parser.rb | cut -d'"' -f2 | cut -d'v' -f2)
  print_info "Current Version: v$CURRENT_VERSION"
}

download_latest_release() {
  rm artifacts/*.zip
  gh release download -R jdsingh/jacoco-parser -p "*.zip" --dir artifacts
  tree

  local found
  found=$(find artifacts -type f -iname "jacoco-parser-$NEW_VERSION.zip")
  if [ -z "$found" ]; then
    print_error "Failed to download release artifact jacoco-parser-$NEW_VERSION.zip"
    exit 1
  fi
}

get_new_version_sha256() {
  NEW_VERSION_SHA256=$(sha256sum ./artifacts/jacoco-parser-"$NEW_VERSION".zip | cut -d ' ' -f1)
  # shellcheck disable=SC2059
  print_info "SHA256 $NEW_VERSION_SHA256 jacoco-parser-$NEW_VERSION.zip"
}

update_new_version_and_sha() {
  sed -i '' "s/[0-9]\.[0.9]\.[0-9]/$NEW_VERSION/g" ./Formula/jacoco-parser.rb
  sed -i '' -E "s/[A-Fa-f0-9]{64}/$NEW_VERSION_SHA256/g" ./Formula/jacoco-parser.rb
  print_success "Updated ./Formula/jacoco-parser.rb"
}

publish_new_version_to_github() {
  git add ./Formula/jacoco-parser.rb
  git commit -m "Update jacoco-parser version to v$NEW_VERSION"
  git push origin main
  print_success "Released jacoco-parser-v$NEW_VERSION"
}

OPTIONS=$1
NEW_VERSION=$1

options
validations

get_current_version
download_latest_release
get_new_version_sha256

update_new_version_and_sha
publish_new_version_to_github
