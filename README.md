# skillpack

Small project-level skill initializer. `skillpack` keeps only profile definitions
and a CLI wrapper; real skill contents are installed by `npx skills` into the
current project's `.agents/skills/`.

## Install

```bash
/Users/yatmn/Projects/skillpack/install.sh
```

This creates:

```text
/Users/yatmn/.local/bin/skillpack -> /Users/yatmn/Projects/skillpack/bin/skillpack
```

## Usage

```bash
skillpack list
skillpack show dev
skillpack init dev
skillpack add writing
skillpack update
skillpack restore
skillpack doctor
```

The default agent is `codex`.

```bash
skillpack init dev --agent claude-code
skillpack init dev --agent cursor
skillpack init dev --agent '*'
```

## Profiles

Profiles live in `profiles/*.txt`.

```text
# source | skill names
obra/superpowers | writing-plans systematic-debugging verification-before-completion
anthropics/skills | webapp-testing
```

Profiles can include another profile with `@name`:

```text
@dev
anthropics/skills | frontend-design
```

## Commands

- `list`: list available profiles.
- `show <profile>`: print a profile with includes expanded.
- `init <profile> [--agent <agent>]`: create `.agents/skills` and install the profile.
- `add <profile> [--agent <agent>]`: install another profile into the current project.
- `update`: run `npx skills update -p -y`.
- `restore`: run `npx skills experimental_install`.
- `doctor`: check local prerequisites and current project state.

## Boundaries

- No real skill content is stored in this repo.
- No skill content is copied from `~/.codex/plugins/cache`.
- No global skill installation is performed.
- `npx skills` is the only install/update/restore entry point.
