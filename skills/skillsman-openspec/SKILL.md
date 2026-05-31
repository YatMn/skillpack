---
name: skillsman-openspec
description: Use OpenSpec for spec-driven development workflows in a project. Use when the user asks to install, initialize, update, or use OpenSpec, or wants lightweight proposal/spec/design/tasks guidance for coding work.
---

# Skillsman OpenSpec

Use OpenSpec as a lightweight spec-driven development layer for project work.
OpenSpec is distributed as the `@fission-ai/openspec` npm CLI and generates
project-local `openspec-*` skills and slash-command guidance for supported
agents.

## Workflow

1. Check whether OpenSpec is available:
   - Run `openspec --version` when the command may already be installed.
   - If it is missing, ask before installing the npm package globally.

2. Install or update OpenSpec when approved:
   - Use `npm install -g @fission-ai/openspec@latest`.
   - Confirm the installed version with `openspec --version`.

3. Initialize OpenSpec in the target project:
   - Run `openspec init --tools <tool>` for a known target tool, for example
     `openspec init --tools codex`.
   - Use `openspec init --tools all` only when the user explicitly wants all
     supported tools.
   - Use `openspec init --tools none` when only the `openspec/` project
     structure is needed.

4. Refresh generated agent guidance after profile or package updates:
   - Run `openspec update`.
   - If the user wants the expanded workflow, run `openspec config profile`
     first, then `openspec update`.

5. Use OpenSpec commands for change work:
   - Start with `/opsx:propose <change>` for a new change.
   - Use `/opsx:apply` when implementing an accepted change.
   - Use `/opsx:archive` after the change is complete and specs should be
     folded back into the project.

## Guardrails

- Do not run global npm installs without explicit user approval.
- Do not treat OpenSpec as a replacement for repository requirements,
  verification commands, or user approval gates.
- Do not run `openspec init` in a repository until the target project path is
  clear.
- Keep generated OpenSpec files project-local; do not copy them into
  Skillsman bundled skills manually.
