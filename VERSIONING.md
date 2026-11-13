# Versioning

This project follows [Semantic Versioning 2.0.0](https://semver.org/) (`MAJOR.MINOR.PATCH`).

## Source of truth

The `VERSION` file at the repository root holds the current version (e.g. `0.1.0`), with no `v` prefix.
Any other manifest that carries a version (e.g. `package.json`) must be kept in sync with it.
Git tags use the `v` prefix (e.g. `v0.1.0`).

## When to bump

| Change                                           | Bump  |
| ------------------------------------------------ | ----- |
| Breaking change to public behavior or API        | MAJOR |
| Backwards-compatible new feature                 | MINOR |
| Backwards-compatible bug fix, docs, internal fix | PATCH |

While the version is `0.x.y`, the project is in initial development: breaking changes may bump MINOR.

## Commit convention

Use [Conventional Commits](https://www.conventionalcommits.org/):

- `feat: ...` -> MINOR
- `fix: ...` -> PATCH
- `feat!: ...` or a `BREAKING CHANGE:` footer -> MAJOR
- `docs:`, `chore:`, `refactor:`, `test:`, `ci:`, `build:`, `perf:` -> no bump by themselves

## Changelog

Every user-visible change adds a line under `## [Unreleased]` in `CHANGELOG.md`, grouped as
`Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, or `Security`.

## Release process

```bash
scripts/version.sh show            # print the current version
scripts/version.sh bump patch      # or: minor | major | set X.Y.Z
scripts/version.sh release patch   # bump + update CHANGELOG + commit + tag
git push origin HEAD --follow-tags
```

`release` does the following:

1. Updates `VERSION`.
2. Moves the `[Unreleased]` entries into a new `[X.Y.Z] - YYYY-MM-DD` section and refreshes the compare links.
3. Creates the commit `chore(release): vX.Y.Z` and the annotated tag `vX.Y.Z`.

Releases must be made from a clean working tree.
