# skillsman

English | [简体中文](README.zh-CN.md)

Skillsman manages reusable agent skills and project skill profiles for Codex,
Claude Code, Cursor, and other environments that install skills through
`npx skills`.

The repository contains installable `skillsman-*` skills, scenario-based
profiles, and a Bash CLI. The CLI expands a selected profile, checks the target
project, and delegates installation to `npx skills`.

Maintainer: YatMn <yatmn@outlook.com>

## What It Does

- Stores first-party agent skills under `skills/`.
- Defines install profiles under `profiles/`.
- Installs skills into project-local agent directories.
- Supports Codex, Claude Code, and Cursor targets.
- Captures and applies project skill snapshots.

Skillsman does not install global skills. Install commands write into the
selected project and refuse to install into this repository unless
`--allow-self-install` is passed explicitly.

## Quick Start

Install a profile in the current project:

```bash
npx github:YatMn/skillsman init workflow --target codex
npx github:YatMn/skillsman add web-app --target codex
```

Install profiles into another project:

```bash
npx github:YatMn/skillsman init workflow --target codex --project /path/to/project
npx github:YatMn/skillsman add database --target codex --project /path/to/project
```

Use a local checkout:

```bash
./bin/skillsman list
./bin/skillsman show workflow
./bin/skillsman init workflow --target codex --project /path/to/project
```

Install one bundled skill directly:

```bash
npx skills add YatMn/skillsman --skill skillsman-readme --agent codex
```

## Recommended Setup

For a new project, install only the bootstrap skill first:

```bash
npx skills add YatMn/skillsman --skill skillsman-init --agent codex
```

Then give Codex the target agent and project type:

```text
Use $skillsman-init to initialize project skills for this repository.

Target: codex
Project type: web app
Project path: current repository

Inspect the project briefly, recommend the matching Skillsman profiles, show the
install plan, and wait for confirmation before installing.
```

Use `Target: claude`, `Target: cursor`, or a comma list such as
`Target: codex,cursor` when installing for other agents. Change `Project type`
to match the project, for example `backend service`, `full-stack app`,
`research project`, `writing project`, or `design project`.

`skillsman-init` uses that context to recommend the right Skillsman profiles,
shows the install plan, asks for confirmation, and then runs `skillsman init`
or `skillsman add` to install the selected skills.

## Bundled Skills

| Skill | Purpose |
| --- | --- |
| `skillsman-agents-md` | Create or improve repository agent instruction files such as `AGENTS.md`. |
| `skillsman-branch` | Create, inspect, sync, and govern Git/GitHub branches using a main/develop/release model. |
| `skillsman-init` | Choose Skillsman profiles, show the install plan, confirm, and run the install. |
| `skillsman-next-prompt` | Create concise continuation, handoff, or fresh-session prompts for Codex. |
| `skillsman-readme` | Create or update practical software-repository README documentation. |

Each bundled skill lives under `skills/<skill-name>/`. The directory name,
`SKILL.md` frontmatter `name`, and `agents/openai.yaml` metadata should stay in
sync.

## Profiles

| Profile | Use case |
| --- | --- |
| `workflow` | Planning, branching, review, publish, README, and repository workflow skills. |
| `web-app` | Frontend, React, Next.js, UI, and browser app testing. |
| `deployment` | Hosted web app deployment, env vars, functions, runtime, and verification. |
| `database` | Supabase, Postgres, and storage. |
| `research` | Web research and knowledge extraction. |
| `writing` | Writing, docs, editing, office files, scripts, meetings, data, and slides. |
| `design` | Visual design, brand assets, themes, artifacts, and generated images. |
| `all` | Audit/test aggregate only. Do not use for real projects. |

Preview a profile before installing it:

```bash
skillsman show workflow
skillsman show web-app
```

Profile files are simple YAML:

```yaml
skills:
  - source: YatMn/skillsman
    why: Repository guidance, branch workflow, next prompt, and README helpers.
    names:
      - skillsman-branch
      - skillsman-readme
```

If `names` is omitted, Skillsman installs all skills from that source with
`npx skills add <source>`. If `names` is present, only the listed skills are
installed.

## Targets

| Target | Project skills directory |
| --- | --- |
| `codex` | `.agents/skills` |
| `claude` | `.claude/skills` |
| `cursor` | `.cursor/skills` |
| `all` | Installs `codex`, `claude`, and `cursor`. |

Install commands require `--target`. Use a comma-separated list such as
`--target codex,cursor`, or use `--target all`.

## Commands

```bash
skillsman list
skillsman show workflow
skillsman init workflow --target codex
skillsman add writing --target codex,cursor
skillsman snapshot --target codex
skillsman apply .skillsman/skills.snapshot.yaml --target codex --project /path/to/project
skillsman update --project /path/to/project
skillsman restore --project /path/to/project
skillsman doctor --target codex
skillsman coverage
```

`init`, `add`, and profile shorthand commands skip skills that already have a
`SKILL.md` file in the target directory. Missing skills are grouped by source
and installed through `npx skills add`.

`update` passes through to `npx skills update -p -y`. `restore` is a legacy
passthrough to `npx skills experimental_install`; profile installs are the
preferred repeatable path.

## Snapshots

Save installed project skills:

```bash
skillsman snapshot --target codex
skillsman snapshot --target codex --output /path/to/skills.snapshot.yaml
```

Default snapshot path:

```text
<project>/.skillsman/skills.snapshot.yaml
```

Apply a snapshot:

```bash
skillsman apply /old/project/.skillsman/skills.snapshot.yaml --target codex --project /new/project
skillsman apply /old/project/.skillsman/skills.snapshot.yaml --target codex --project /new/project --dry-run
```

Snapshots use schema `skillsman.snapshot.v1`. `snapshot` scans installed
`SKILL.md` files and resolves each skill's source from `skills-lock.json`. If a
source cannot be resolved, the command fails instead of writing an incomplete
snapshot.

## Development

Install the local CLI symlink:

```bash
./install.sh
```

Run local checks:

```bash
bash -n install.sh bin/skillsman
./bin/skillsman list
./bin/skillsman show workflow
./bin/skillsman coverage
git diff --check
npm pack --dry-run
```

## Repository Structure

```text
bin/skillsman
profiles/*.yaml
skills/*/SKILL.md
skills/*/agents/openai.yaml
skills/*/references/
install.sh
package.json
```

## License

MIT License. See [LICENSE](LICENSE).
