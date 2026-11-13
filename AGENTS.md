# AGENTS.md

Guidance for AI coding agents working in this repository.

## Project

`rpcide` — website: <https://rpcide.vercel.app>. The repository is currently minimal (README only);
update this file as the stack, build, and test commands are added.

## Setup, build, and test

No build system exists yet. When one is added, document the exact commands here
(install, dev, build, lint, test) and run them before finishing a task.

## Versioning (required reading: `VERSIONING.md`)

- Semantic Versioning; the `VERSION` file is the single source of truth.
- Use Conventional Commits (`feat:`, `fix:`, `docs:`, `chore:`, ...; `!` or `BREAKING CHANGE:` for majors).
- Add every user-visible change to `## [Unreleased]` in `CHANGELOG.md`.
- Use `scripts/version.sh` for bumps and releases. Never edit `VERSION` by hand or create `v*` tags manually.
- Do not cut a release unless explicitly asked.

## Conventions

- Keep changes small, focused, and consistent with surrounding code.
- Write code, comments, commit messages, and docs in English.
- Do not commit secrets, tokens, or `.env` files.
- Update documentation (README, CHANGELOG, this file) when behavior or workflow changes.

## Git workflow

- Work on a feature branch; never push directly to the default branch.
- Do not open pull requests unless asked.
- Do not rewrite history on shared branches.
