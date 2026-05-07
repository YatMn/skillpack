# README Quality Rubric

Use this checklist when auditing or drafting a repository README.

## Mode Fit

- Create mode is used when no useful README exists or the current README is a placeholder.
- Update mode is used when the README already exists and needs to reflect code, config, command, API, dependency, or deployment changes.
- Update mode starts from existing README content and project diffs, not from a fresh template.
- Accurate existing sections are preserved; stale claims are revised or removed.

## Entry Point

- Project name is clear.
- First paragraph says what the project does, who it is for, and why it exists.
- Status is explicit: experimental, internal, production, deprecated, template, or unknown.
- Status describes the current usable state, not detailed plans, task progress, or milestone history.
- English `README.md` links to `README.zh-CN.md`; Chinese README links back.

## Quick Start

- Prerequisites are specific: runtime versions, package manager, databases, services, CLIs.
- Install command matches the repo.
- Configuration references `.env.example` or real config files when present.
- Run command is the shortest credible path to a working local instance.
- Commands are fenced, copyable, and not mixed with shell prompts unless the repo already uses that style.

## Usage

- Shows the primary user workflow, not every possible option.
- Includes concrete examples for CLI commands, API calls, UI flows, or library imports where relevant.
- Links to detailed docs instead of overloading the README.

## Development

- Lists real test/lint/build/dev scripts.
- Explains fixture, database, or service setup only as much as needed to begin.
- Notes destructive or production-affecting commands clearly.
- After code changes, development commands still match current manifests, Makefiles, CI, or scripts.

## Project Map

- Explains important directories and entrypoints.
- Avoids full recursive file trees.
- Calls out generated, ignored, or external directories only if they affect setup.

## Configuration and Security

- Names required environment variables without exposing secret values.
- Distinguishes required, optional, and environment-specific settings.
- Points to secret-management or deployment docs when they exist.

## Maintenance

- Provides support or maintainer route when known.
- Links to contribution, issue, changelog, release, or license files when present.
- Uses `TODO` for missing maintainer/license/support facts instead of inventing them.

## Scope Boundary

- README explains the current project, setup, usage, development, configuration, and support surface.
- README does not include detailed roadmaps, sprint progress, implementation plans, task trackers, or changelog-style histories.
- If planning or progress docs already exist, README may link to them briefly without summarizing them.

## Bilingual Consistency

- English is the source structure.
- Chinese keeps the same facts, commands, paths, and headings.
- Code identifiers, commands, env vars, file paths, package names, and API names stay in English.
- Localized prose should be natural Chinese, not literal machine translation.

## Final Checks

- Relative links resolve from each README file.
- Referenced files actually exist or are marked as planned/TODO.
- Commands are verified where cheap and safe, or clearly left unverified.
- In update mode, changed files have been mapped to the README sections they affect.
- English and Chinese README files reflect the same updates.
- The README remains an entrypoint; long explanations belong in linked docs.
