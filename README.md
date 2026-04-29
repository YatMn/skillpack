# skillpack

Small project-level skill initializer. `skillpack` keeps only profile definitions
and a CLI wrapper; real skill contents are installed by `npx skills` into the
current project's `.agents/skills/`.

## Install

```bash
git clone https://github.com/YatMn/skillpack.git
cd skillpack
./install.sh
```

This creates:

```text
~/.local/bin/skillpack -> <repo>/bin/skillpack
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
skillpack coverage
```

The default agent is `codex`.

```bash
skillpack init dev --agent claude-code
skillpack init dev --agent cursor
skillpack init dev --agent '*'
```

## Profiles

Profiles live in `profiles/*.txt` and are organized by usage scenario:

```text
dev          build, debug, refactor, and finish software projects
web          build, verify, deploy, and operate web apps and product UIs
design       create visual design, UI direction, static assets, and motion
writing      write, edit, proofread, and produce creator content
research     gather sources, extract knowledge, and verify references
office       handle documents, spreadsheets, presentations, and calendars
all          include every scenario profile
```

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
- `coverage`: check profile source/skill pairs and report scenario overlaps.

## Boundaries

- No real skill content is stored in this repo.
- No skill content is copied from `~/.codex/plugins/cache`.
- No global skill installation is performed.
- `npx skills` is the only install/update/restore entry point.
