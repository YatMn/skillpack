---
name: skillsman-agents-md
description: Create or improve repository agent instruction files such as AGENTS.md, CLAUDE.md imports, or equivalent coding-agent guidance. Use when the user asks for a good AGENTS.md, wants to document agent working rules, wants Codex/Claude/Copilot/Gemini project instructions, or asks how agents should work in a repository.
---

# Skillsman AGENTS.md

## Goal

Produce a short, accurate, maintainable instruction file that helps coding agents work in the current repository without consuming unnecessary context or inventing project facts.

Treat `AGENTS.md` as an entry map for agents, not a full project manual. Prefer pointers to canonical docs over duplicating long explanations.

## Workflow

1. Determine the requested mode.
   - If the user asks for a proposal, plan, review, or recommendation, do not edit files.
   - If the user asks to create, update, write, or implement the file, edit the relevant instruction file.
   - If the user names `agent.md`, normalize to `AGENTS.md` unless the repository or tool explicitly requires another filename.

2. Inspect the repository before writing.
   - Read existing instruction files: `AGENTS.md`, `AGENTS.override.md`, `CLAUDE.md`, `.github/copilot-instructions.md`, `GEMINI.md`.
   - Read basic project anchors if present: `README.md`, package/build config, test config, `docs/`, `.github/workflows/`.
   - Use `rg --files` first. Do not infer commands, stack, or layout from filenames alone when config files can verify them.

3. Preserve truth and scope.
   - Keep existing correct rules.
   - Remove or rewrite stale, vague, duplicated, or unenforceable rules.
   - Do not invent build, test, lint, deploy, or layout details.
   - Mark unknown commands explicitly as not defined yet.

4. Write the smallest useful file.
   - Target under 100 lines for normal repos; stay under 200 lines unless the user explicitly wants more.
   - Use concrete bullets with paths and commands.
   - Put rarely needed procedures in `docs/` or existing runbooks and link to them.
   - Avoid generic advice that every competent coding agent already knows.

5. Verify the result.
   - Re-read the final file for contradictions, vague rules, and fake commands.
   - If commands were added, verify they exist in project config or workflow files.
   - If the repo has formatting or markdown lint commands, run the narrowest relevant check.

## Recommended Structure

Use this structure unless the existing repository has a stronger convention:

```markdown
# AGENTS.md

Instructions for Codex and other coding agents working in this repository.

## Project Overview

One short paragraph: what this repo is, current implementation stage, and any core boundary.

## Source of Truth

- Point to canonical docs/specs/runbooks.
- Say which files win when docs conflict.

## Working Rules

- Repository-specific rules that apply to almost every task.
- Human approval requirements for irreversible actions.
- Scope and change-control rules.

## Commands

- Install:
- Develop:
- Test:
- Lint/format:
- Typecheck:

## Verification

- What to run after common change types.
- What to report if checks cannot run.

## Repository Layout

- `path/`: purpose.

## Task-Specific Notes

- Link to deeper docs instead of expanding them here.
```

Delete empty sections if they add no value. For an empty project shell, it is acceptable to say that commands and layout are not defined yet.

## Quality Bar

A good agent instruction file is:

- Accurate: every command, path, and workflow can be verified.
- Specific: rules are concrete enough to follow and review.
- Short: the file helps agents navigate instead of crowding out task context.
- Stable: only durable project rules belong here.
- Layered: detailed or path-specific guidance lives closer to the relevant code or in linked docs.

Avoid:

- Long product background that belongs in `README.md` or specs.
- Aspirational rules such as "write clean code" or "use best practices".
- Personal preferences that are not project policy.
- Broad fallback logic, tool mandates, or process ceremony unrelated to the repository.
- Duplicating large docs into `AGENTS.md`.

## Cross-Agent Compatibility

- Codex reads `AGENTS.md` and supports nested `AGENTS.md` / `AGENTS.override.md` by directory scope.
- Claude Code reads `CLAUDE.md`; for shared instructions, create a short `CLAUDE.md` that imports `@AGENTS.md` when appropriate.
- GitHub Copilot and other tools may have their own instruction filenames. Prefer one source of truth and thin adapter files when multiple tools are used.

Only add adapter files when the user asks for cross-tool support or the repository already uses those tools.
