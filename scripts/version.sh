#!/usr/bin/env bash
# Version management for rpcide. See VERSIONING.md.
# Usage: scripts/version.sh show | bump <major|minor|patch> | set <X.Y.Z> | release <major|minor|patch|X.Y.Z>
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION_FILE="$ROOT/VERSION"
CHANGELOG="$ROOT/CHANGELOG.md"
REPO_URL="https://github.com/rpcide/rpcide"
SEMVER_RE='^[0-9]+\.[0-9]+\.[0-9]+$'

current() { tr -d '[:space:]' < "$VERSION_FILE"; }

next_version() {
  local cur="$1" kind="$2" major minor patch
  IFS=. read -r major minor patch <<< "$cur"
  case "$kind" in
    major) echo "$((major + 1)).0.0" ;;
    minor) echo "$major.$((minor + 1)).0" ;;
    patch) echo "$major.$minor.$((patch + 1))" ;;
    *) [[ "$kind" =~ $SEMVER_RE ]] || { echo "Invalid version or bump kind: $kind" >&2; exit 1; }
       echo "$kind" ;;
  esac
}

update_changelog() {
  local old="$1" new="$2" date; date="$(date +%Y-%m-%d)"
  grep -q '^## \[Unreleased\]' "$CHANGELOG" || { echo "CHANGELOG.md has no [Unreleased] section" >&2; exit 1; }
  local tmp; tmp="$(mktemp)"
  awk -v new="$new" -v date="$date" '
    /^## \[Unreleased\]/ { print; print ""; print "## [" new "] - " date; next }
    { print }
  ' "$CHANGELOG" > "$tmp"
  # Refresh compare links.
  sed -i "s|^\[Unreleased\]:.*|[Unreleased]: $REPO_URL/compare/v$new...HEAD|" "$tmp"
  if ! grep -q "^\[$new\]:" "$tmp"; then
    sed -i "/^\[Unreleased\]:/a [$new]: $REPO_URL/compare/v$old...v$new" "$tmp"
  fi
  mv "$tmp" "$CHANGELOG"
}

cmd="${1:-show}"
case "$cmd" in
  show) current ;;
  set)
    [[ "${2:-}" =~ $SEMVER_RE ]] || { echo "Usage: $0 set X.Y.Z" >&2; exit 1; }
    echo "$2" > "$VERSION_FILE"; echo "$2" ;;
  bump)
    new="$(next_version "$(current)" "${2:?Usage: $0 bump <major|minor|patch>}")"
    echo "$new" > "$VERSION_FILE"; echo "$new" ;;
  release)
    [ -z "$(git -C "$ROOT" status --porcelain)" ] || { echo "Working tree is not clean" >&2; exit 1; }
    old="$(current)"; new="$(next_version "$old" "${2:?Usage: $0 release <major|minor|patch|X.Y.Z>}")"
    echo "$new" > "$VERSION_FILE"
    update_changelog "$old" "$new"
    git -C "$ROOT" add VERSION CHANGELOG.md
    git -C "$ROOT" commit -m "chore(release): v$new"
    git -C "$ROOT" tag -a "v$new" -m "v$new"
    echo "Released v$new. Push with: git push origin HEAD --follow-tags" ;;
  *) echo "Usage: $0 show | bump <kind> | set <X.Y.Z> | release <kind>" >&2; exit 1 ;;
esac
