# CLAUDE.md

Instructions for Claude Code in this repository. Also read `AGENTS.md` (shared agent guidance) and `VERSIONING.md`.

## Overview

`rpcide` — website: <https://rpcide.vercel.app>. The repository is currently minimal (README only).

## Layout

- `VERSION` — current SemVer version (source of truth)
- `CHANGELOG.md` — Keep a Changelog format
- `VERSIONING.md` — versioning and release policy
- `scripts/version.sh` — `show | bump | set | release`
- `AGENTS.md` — guidance for all AI agents

## Rules

- Everything in the repo is written in English: code, comments, docs, commit messages.
- Commit messages follow Conventional Commits.
- For any user-visible change, add an entry under `## [Unreleased]` in `CHANGELOG.md` in the same commit.
- Change versions only through `scripts/version.sh`; do not release unless the user asks.
- Do not create pull requests unless asked.
- Keep `CLAUDE.md` and `AGENTS.md` consistent; when you add build/test commands, record them in both.

## Common commands

```bash
scripts/version.sh show
scripts/version.sh release patch
```
