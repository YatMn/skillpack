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
web          build and verify web apps and product UIs
deploy       deploy, operate, secure, and configure hosted apps
ai           build AI, LLM, chat, and generated-media apps
design       create visual design, UI direction, static assets, and motion
content      produce articles, social posts, video scripts, and creator assets
writing      write, edit, proofread, and shape communication
research     gather sources, extract knowledge, and verify references
office       handle documents, spreadsheets, presentations, and calendars
planning     turn ideas, product context, and specs into implementation work
repo         manage repositories, PRs, reviews, CI, releases, and repo guidance
personal     maintain personal agent setup, prompts, skills, and local workflows
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

Lines whose source starts with `!` are catalog-only entries. They are counted by
`skillpack coverage`, but skipped by `skillpack init` and `skillpack add`.
Use them for local, bundled, or plugin-cache-only skills that are visible on the
current machine but should not be installed from a public source.

## Commands

- `list`: list available profiles.
- `show <profile>`: print a profile with includes expanded.
- `init <profile> [--agent <agent>]`: create `.agents/skills` and install the profile.
- `add <profile> [--agent <agent>]`: install another profile into the current project.
- `update`: run `npx skills update -p -y`.
- `restore`: run `npx skills experimental_install`.
- `doctor`: check local prerequisites and current project state.
- `coverage`: compare local visible skills with the union of all profile skills.

## Boundaries

- No real skill content is stored in this repo.
- No skill content is copied from `~/.codex/plugins/cache`.
- No global skill installation is performed.
- `npx skills` is the only install/update/restore entry point.
