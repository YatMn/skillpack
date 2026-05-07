---
name: skillsman-init
description: Initialize project-level agent skills through Skillsman. Use when the user asks to initialize, install, set up, add, or recommend project skills for Codex, Claude Code, Cursor, or all targets, especially when they describe a project type such as backend development, frontend app, full-stack app, development management, research, writing, design, database, or deployment work.
---

# Skillsman Init

## Overview

Initialize project skills by selecting Skillsman profiles, showing the planned sources and skill names, asking for explicit user confirmation, then running Skillsman in the target project.

This skill is only an interactive selector and confirmation workflow. Do not copy skill contents, do not install global skills, and do not call `npx skills` directly.

## Workflow

1. Identify the target project path:
   - Use the current working directory unless the user gives a project path.
   - Refuse to install into the Skillsman repository itself unless the user explicitly asks for self-install behavior.

2. Identify the project type:
   - If the user gives a clear type, use it.
   - If the type is unclear, inspect repo files briefly and propose one profile set.
   - If inspection is still ambiguous, ask the user to choose a project type before continuing.

3. Ask for the target before planning installation:
   - Do not default to `codex`.
   - Ask which target to install: `codex`, `claude`, `cursor`, `all`, or a comma list such as `codex,cursor`.
   - Continue only after the user answers.

4. Map the project type to Skillsman profiles:
   - Read `references/profile-mapping.md`.
   - Use the closest project-type mapping.
   - If more than one mapping fits, recommend one profile set and state why.

5. Show the installation plan:
   - Run `skillsman show <profile>` for every selected profile.
   - If `skillsman` is unavailable but `/Users/yatmn/Projects/skillsman/bin/skillsman` exists, use that local binary.
   - If no Skillsman command is available, stop and report the missing command instead of calling `npx skills`.

6. Ask for confirmation:
   - Summarize the project type, target, profiles, sources, and skill names.
   - Ask whether to install.
   - Do not run install commands until the user confirms.

7. Install with Skillsman:
   - Use `init` for the first profile.
   - Use `add` for every remaining profile.
   - Always pass `--target <target>` and `--project <project-path>`.

8. Verify:
   - Run `skillsman doctor --target <target> --project <project-path>`.
   - Report the installed, skipped, or failed items from command output.

## Command Pattern

For a backend project with target `codex,cursor`:

```bash
skillsman show workflow
```

After user confirmation:

```bash
skillsman init workflow --target codex,cursor --project /path/to/project
skillsman doctor --target codex,cursor --project /path/to/project
```

## User-Facing Confirmation Format

Use concise language:

```text
This looks like a backend development project.
Target: codex,cursor
Profiles: workflow

Planned installs:
- workflow: <source and skills from skillsman show>

Confirm install?
```

If the user says no or changes the project type/target, revise the plan and ask again.

## Guardrails

- Do not install without a target answer and explicit confirmation.
- Do not use the `all` profile for real projects; `all` is audit/test aggregate only.
- Do not invent profile names. Use only profiles that exist in Skillsman.
- Do not install source/vendor profiles directly.
- Do not copy real skill contents into the target project manually.
- Do not treat `skills-lock.json` as the source of truth for selecting profiles.
