---
name: skillsman-manage
description: Manage project-level agent skills through Skillsman. Use when the user asks to initialize, add, remove, update, snapshot, apply, migrate, inspect, diagnose, or recommend project skills for any agent supported by npx skills.
---

# Skillsman Manage

## Overview

Manage project skills through Skillsman scenarios and the local `skillsman` CLI.
Use this skill as the single lifecycle entrypoint for project-level skills:
inspect, initialize, add, remove, update, snapshot, apply, migrate, and diagnose.

Do not copy skill contents manually, do not install global skills, and do not
call `npx skills` directly. Skillsman delegates real installation and removal
to `npx skills`.

## Workflow

1. Identify the target project path:
   - Use the current working directory unless the user gives a project path.
   - Refuse to modify the Skillsman repository itself unless the user explicitly asks for self-install behavior.

2. Identify the requested action:
   - `status` or `list`: inspect installed project skills.
   - `init`: recommend scenarios for the project type and install after confirmation.
   - `add`: add a scenario or explicit skill set after confirmation.
   - `remove`: remove explicitly named skills only after snapshot guidance and confirmation.
   - `update`: update project skills after confirmation.
   - `snapshot`: save the installed project skill set.
   - `apply` or `migrate`: apply a snapshot to a target project or agent.
   - `doctor`: diagnose environment, target, source, and installed-skill state.

3. Identify the target agent before planning any change:
   - Ask which target to use if the user did not specify one.
   - Accept `codex`, `claude`, `claude-code`, `cursor`, `gemini`, `gemini-cli`, `openclaw`, `antigravity`, `all`, comma lists, or another `npx skills --agent` value.
   - Treat `all` as all agents supported by `npx skills`, not as the `scenarios/all.yaml` audit scenario.

4. For `init`, map project type to Skillsman scenarios:
   - Read `references/scenario-mapping.md`.
   - Use the closest project-type mapping.
   - Use the narrowest scenario set that covers the request.
   - Do not use the `all` scenario for real projects.

5. Show the plan before changing anything:
   - Use `skillsman show <scenario>` for selected scenarios.
   - For removal, list the exact skill names and targets to remove.
   - For update, snapshot, apply, or doctor, list the exact command to run.
   - If `skillsman` is unavailable but `/Users/yatmn/Projects/skillsman/bin/skillsman` exists, use that local binary.
   - If no Skillsman command is available, stop and report the missing command instead of calling `npx skills`.

6. Ask for explicit confirmation before any mutating action:
   - Do not install, remove, update, apply, or restore until the user confirms.
   - For `remove`, recommend taking a snapshot first.
   - Do not run interactive `npx skills remove`; Skillsman remove requires explicit skill names.

7. Execute with Skillsman:
   - `init`: `skillsman init <scenario> --target <target> --project <project-path>`
   - Additional scenarios: `skillsman add <scenario> --target <target> --project <project-path>`
   - `remove`: `skillsman remove <skill...> --target <target> --project <project-path>`
   - `update`: `skillsman update --project <project-path>`
   - `snapshot`: `skillsman snapshot --target <target> --project <project-path>`
   - `apply`: `skillsman apply <snapshot> --target <target> --project <project-path>`
   - `doctor`: `skillsman doctor --target <target> --project <project-path>`

8. Verify:
   - Use the Skillsman command output and targeted file/list checks to confirm the requested change.
   - Run `skillsman doctor --target <target> --project <project-path>` only when the user asks for diagnostics or when troubleshooting a failed/unclear operation.
   - Report installed, skipped, removed, failed, and any targeted verification items from command output.

## User-Facing Confirmation Format

Use concise language:

```text
Action: init
Project: /path/to/project
Target: codex,cursor
Scenarios: workflow, web-app

Planned commands:
- skillsman show workflow
- skillsman show web-app
- skillsman init workflow --target codex,cursor --project /path/to/project
- skillsman add web-app --target codex,cursor --project /path/to/project

Confirm?
```

For removal:

```text
Action: remove
Project: /path/to/project
Target: codex
Skills: skillsman-readme

Recommended first:
- skillsman snapshot --target codex --project /path/to/project

Planned command:
- skillsman remove skillsman-readme --target codex --project /path/to/project

Confirm?
```

## Guardrails

- Do not mutate project skills without an explicit target and confirmation.
- Do not use `scenarios/all.yaml` for real projects; it is audit/test aggregate only.
- Do not invent scenario names. Use only scenarios that exist in Skillsman.
- Do not install source/vendor names as scenarios directly.
- Do not copy real skill contents into the target project manually.
- Do not use global `npx skills` operations.
- Do not treat `skills-lock.json` as the source of truth for selecting scenarios.
- Unknown targets are allowed only as pass-through `npx skills --agent` values; do not guess their local directory layout.
