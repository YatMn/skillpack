# AGENTS.md

Instructions for Codex and other coding agents working in this repository.

## Project Overview

`skillsman` is a personal agent skills manager. It stores first-party skills,
scenario profiles, and a Bash CLI that delegates real installation to
`npx skills` in the target project.

## Source of Truth

- [README.md](README.md): public usage, bundled skills, profiles, and checks.
- [bin/skillsman](bin/skillsman): CLI behavior and argument handling.
- [profiles/](profiles/): one-layer functional profile definitions.
- [skills/](skills/): bundled installable skills.
- If docs and code disagree, verify against `bin/skillsman` and update docs.

## Working Rules

- Keep `skills/` as the canonical source for bundled `skillsman-*` skills.
- Do not copy skill contents from `~/.codex/plugins/cache`.
- Do not add backwards-compatible aliases or legacy schema support unless the
  user explicitly changes the migration decision.
- Profile commands install into the caller's project through `npx skills`.
- Keep profile files as simple YAML: `includes` lists and `skills` entries with
  `source`, `why`, and optional `names`.
- If `names` is omitted for a `source`, Skillsman installs all skills from that
  source by calling `npx skills add <source>`.
- Install/add commands must use explicit `--target`; supported targets are
  `codex`, `claude`, `cursor`, and `all`.
- Treat `profiles/all.yaml` as an aggregate profile for audit/testing only.
- Use Bash-compatible changes in `install.sh` and `bin/skillsman`.

## Commands

- Install local CLI symlink: `./install.sh`
- List profiles: `./bin/skillsman list`
- Show expanded profile: `./bin/skillsman show workflow`
- Install profile: `./bin/skillsman init workflow --target codex`
- Add profile: `./bin/skillsman add writing --target codex,cursor`
- Snapshot project skills: `./bin/skillsman snapshot --target codex`
- Apply a snapshot: `./bin/skillsman apply .skillsman/skills.snapshot.yaml --target codex`
- Check environment/project state: `./bin/skillsman doctor --target codex`
- Check profile coverage: `./bin/skillsman coverage`

## Verification

- After shell changes, run `bash -n install.sh bin/skillsman`.
- After profile changes, run `./bin/skillsman list`,
  `./bin/skillsman show <profile>`, and `./bin/skillsman coverage`.
- After bundled skill changes, verify `skills/*/SKILL.md` names match directory
  names and run a temp-project install smoke when network is available.
- Run `git diff --check` and `npm pack --dry-run` before publishing.

## Repository Layout

- `bin/skillsman`: Bash CLI implementation.
- `profiles/*.yaml`: one-layer functional profile definitions and includes.
- `skills/*`: bundled installable skills.
- `install.sh`: installs `~/.local/bin/skillsman` as a symlink to this repo.
- `package.json`: GitHub-hosted `npx` metadata and package file list.
