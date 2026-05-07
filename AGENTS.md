# AGENTS.md

Instructions for Codex and other coding agents working in this repository.

## Project Overview

`skillpack` is a small multi-agent project-level skill initializer. It stores
profile definitions and a Bash CLI wrapper that delegates real skill
installation to `npx skills` in the current project.

## Source of Truth

- [README.md](README.md): user-facing install, usage, profiles, and boundaries.
- [bin/skillpack](bin/skillpack): CLI behavior and argument handling.
- [profiles/](profiles/): one-layer functional profile definitions.
- If docs and code disagree, verify against `bin/skillpack` and update the docs.

## Working Rules

- Keep this repo as an initializer only; do not vendor or copy real skill
  contents into it.
- Do not copy skill contents from `~/.codex/plugins/cache`.
- Do not add global skill installation behavior. Profile commands should install
  into the caller's current project through `npx skills`.
- Keep profile files as simple YAML: `includes` lists and `skills` entries with
  `source`, `why`, and optional `names`.
- If `names` is omitted for a `source`, SkillPack installs all skills from that
  source by calling `npx skills add <source>`.
- If `names` is present, put one skill name per line and SkillPack installs only
  those skills.
- Install/add commands must use explicit `--target`; do not restore a default
  agent or the old `--agent` CLI contract.
- Supported targets are `codex`, `claude`, `cursor`, and `all`. Target-specific
  project skill directories are `.agents/skills`, `.claude/skills`, and
  `.cursor/skills`.
- Profile IDs are one-layer use cases such as `workflow`, `web-app`,
  `writing`, and `research`; do not create vendor/source profiles such as
  `openai`, `anthropic`, `vercel`, or `supabase`.
- Treat `profiles/all.yaml` as an aggregate profile; avoid adding skill entries
  there when a scenario-specific profile is the right home.
- Use Bash-compatible changes in `install.sh` and `bin/skillpack`; this repo
  does not currently have a package manager or compiled build step.

## Commands

- Install local CLI symlink: `./install.sh`
- List profiles: `./bin/skillpack list`
- Show expanded profile: `./bin/skillpack show workflow`
- Install profile into current project: `./bin/skillpack init workflow --target codex`
- Add another profile into current project: `./bin/skillpack add writing --target codex,cursor`
- Update project skills: `./bin/skillpack update`
- Restore project skills from lock/state: `./bin/skillpack restore`
- Check environment/project state: `./bin/skillpack doctor`
- Check target-specific project state: `./bin/skillpack doctor --target codex,cursor`
- Check profile coverage and duplicates: `./bin/skillpack coverage`

## Verification

- After shell changes, run `bash -n install.sh bin/skillpack`.
- After profile changes, run `./bin/skillpack list`,
  `./bin/skillpack show <profile>`, and `./bin/skillpack coverage`.
- `init`, `add`, `update`, `restore`, and part of `doctor` call `npx skills`;
  run them only when the task needs real local skill installation or update.
- If a check cannot run because `npx` or `npx skills` is unavailable, report the
  exact command and failure.

## Repository Layout

- `bin/skillpack`: Bash CLI implementation.
- `profiles/*.yaml`: one-layer functional profile definitions and includes.
- `install.sh`: installs `~/.local/bin/skillpack` as a symlink to this repo.
- `README.md`: public usage guide.
