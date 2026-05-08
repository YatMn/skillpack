# AGENTS.md

Instructions for Codex and other coding agents working in this repository.

## Project Overview

`skillsman` is a personal agent skills manager. It stores first-party skills,
scenario definitions, and a Bash CLI that delegates real installation to
`npx skills` in the target project.

## Source of Truth

- [README.md](README.md): public usage, bundled skills, scenarios, and checks.
- [bin/skillsman](bin/skillsman): CLI behavior and argument handling.
- [scenarios/](scenarios/): one-layer scenario definitions.
- [skills/](skills/): bundled installable skills.
- If docs and code disagree, verify against `bin/skillsman` and update docs.

## Working Rules

- Keep `skills/` as the canonical source for bundled `skillsman-*` skills.
- Do not copy skill contents from `~/.codex/plugins/cache`.
- Do not add backwards-compatible aliases or legacy schema support unless the
  user explicitly changes the migration decision.
- Scenario commands install into the caller's project through `npx skills`.
- Keep scenario files as simple YAML: `includes` lists and `skills` entries with
  `source`, `why`, and optional `names`.
- If `names` is omitted for a `source`, Skillsman installs all skills from that
  source by calling `npx skills add <source>`.
- Install/add commands must use explicit `--target`; built-in target aliases are
  `codex`, `claude`, `claude-code`, `cursor`, `gemini`, `gemini-cli`,
  `openclaw`, `antigravity`, and `all`. Unknown targets pass through to
  `npx skills --agent`.
- Treat `scenarios/all.yaml` as an aggregate scenario for audit/testing only.
- Use Bash-compatible changes in `install.sh` and `bin/skillsman`.

## Commands

- Install local CLI symlink: `./install.sh`
- List scenarios: `./bin/skillsman list`
- Show expanded scenario: `./bin/skillsman show workflow`
- Install scenario: `./bin/skillsman init workflow --target codex`
- Add scenario: `./bin/skillsman add writing --target codex,cursor`
- Remove a skill: `./bin/skillsman remove skillsman-readme --target codex`
- Snapshot project skills: `./bin/skillsman snapshot --target codex`
- Apply a snapshot: `./bin/skillsman apply .skillsman/skills.snapshot.yaml --target codex`
- Check environment/project state: `./bin/skillsman doctor --target codex`
- Check scenario coverage: `./bin/skillsman coverage`

## Verification

- After shell changes, run `bash -n install.sh bin/skillsman`.
- After scenario changes, run `./bin/skillsman list`,
  `./bin/skillsman show <scenario>`, and `./bin/skillsman coverage`.
- After bundled skill changes, verify `skills/*/SKILL.md` names match directory
  names and run a temp-project install smoke when network is available.
- Run `git diff --check` and `npm pack --dry-run` before publishing.

## Repository Layout

- `bin/skillsman`: Bash CLI implementation.
- `scenarios/*.yaml`: one-layer scenario definitions and includes.
- `skills/*`: bundled installable skills.
- `install.sh`: installs `~/.local/bin/skillsman` as a symlink to this repo.
- `package.json`: GitHub-hosted `npx` metadata and package file list.
