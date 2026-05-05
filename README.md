# skillpack

English | [简体中文](README.zh-CN.md)

Project-level skill profile installer for Codex, Claude Code, and Cursor.

`skillpack` does not store real skill contents. It expands a profile from
`profiles/*.yaml`, then installs those skills into the current project through
`npx skills`.

## Quick Start

In a project that needs local agent skills:

```bash
npx github:YatMn/skillpack dev --target codex
```

Equivalent shortcuts:

```bash
npx github:YatMn/skillpack -dev --target codex
npx github:YatMn/skillpack --dev --target codex
```

Install the same profile for multiple agents:

```bash
npx github:YatMn/skillpack dev --target codex,cursor
npx github:YatMn/skillpack dev --target all
```

`--target` is required for install commands. Supported targets are `codex`,
`claude`, `cursor`, and `all`.

Target output directories:

| Target | Project skills directory |
| --- | --- |
| `codex` | `.agents/skills` |
| `claude` | `.claude/skills` |
| `cursor` | `.cursor/skills` |
| `all` | Installs `codex`, `claude`, and `cursor`. |

## Profiles

| Profile | Use case |
| --- | --- |
| `dev` | Software and web development. |
| `design` | Visual design and creative assets. |
| `writing` | Writing, editing, and creator workflows. |
| `research` | Web research and knowledge extraction. |
| `office` | Documents, spreadsheets, slides, and PDFs. |
| `all` | Aggregate profile. |

Show what a profile installs:

```bash
npx github:YatMn/skillpack show dev
```

## Profile Skills

<details>
<summary><code>dev</code>: software and web development</summary>

| Skill | Source | What it is for |
| --- | --- | --- |
| `brainstorming` | `obra/superpowers` | Explore intent and requirements before feature or creative work. |
| `dispatching-parallel-agents` | `obra/superpowers` | Split independent tasks across parallel agents. |
| `executing-plans` | `obra/superpowers` | Execute a written implementation plan with checkpoints. |
| `finishing-a-development-branch` | `obra/superpowers` | Finish a branch after implementation and verification. |
| `receiving-code-review` | `obra/superpowers` | Handle review feedback before applying changes. |
| `requesting-code-review` | `obra/superpowers` | Request focused code review after substantial work. |
| `subagent-driven-development` | `obra/superpowers` | Run implementation plans through independent subagent tasks. |
| `systematic-debugging` | `obra/superpowers` | Investigate bugs and failing tests before fixing. |
| `test-driven-development` | `obra/superpowers` | Implement features or fixes with a test-first loop. |
| `using-git-worktrees` | `obra/superpowers` | Use Git worktrees for isolated feature work. |
| `using-superpowers` | `obra/superpowers` | Establish skill discovery and workflow discipline. |
| `verification-before-completion` | `obra/superpowers` | Verify before claiming work is complete. |
| `writing-plans` | `obra/superpowers` | Turn requirements into implementation plans. |
| `writing-skills` | `obra/superpowers` | Create, edit, and verify Codex skills. |
| `context7` | `intellectronica/agent-skills` | Look up current library docs and API references. |
| `claude-api` | `anthropics/skills` | Build or debug Anthropic Claude API apps. |
| `mcp-builder` | `anthropics/skills` | Design and implement MCP servers. |
| `frontend-design` | `anthropics/skills` | Build polished web interfaces and UI artifacts. |
| `webapp-testing` | `anthropics/skills` | Test local web apps with browser automation. |
| `gh-address-comments` | `openai/skills` | Address GitHub PR review comments. |
| `gh-fix-ci` | `openai/skills` | Debug and fix failing GitHub checks. |
| `notion-knowledge-capture` | `openai/skills` | Save conversations and decisions into Notion. |
| `notion-spec-to-implementation` | `openai/skills` | Turn Notion specs into implementation plans. |
| `openai-docs` | `openai/skills` | Use current official OpenAI docs. |
| `plugin-creator` | `openai/skills` | Scaffold Codex plugins. |
| `skill-creator` | `openai/skills` | Design new skills or update existing ones. |
| `skill-installer` | `openai/skills` | Install skills from curated sources or GitHub. |
| `yeet` | `openai/skills` | Publish local changes through GitHub. |
| `supabase-postgres-best-practices` | `supabase/agent-skills` | Review and optimize Supabase/Postgres work. |
| `ai-gateway` | `vercel/vercel-plugin` | Configure Vercel AI Gateway routing. |
| `ai-sdk` | `vercel/vercel-plugin` | Build AI features with the Vercel AI SDK. |
| `auth` | `vercel/vercel-plugin` | Integrate auth providers in Vercel/Next.js apps. |
| `bootstrap` | `vercel/vercel-plugin` | Set up Vercel-linked project resources. |
| `chat-sdk` | `vercel/vercel-plugin` | Build chat bots with the Vercel Chat SDK. |
| `deployments-cicd` | `vercel/vercel-plugin` | Deploy, promote, roll back, and inspect Vercel apps. |
| `env-vars` | `vercel/vercel-plugin` | Manage Vercel environment variables. |
| `marketplace` | `vercel/vercel-plugin` | Work with Vercel Marketplace integrations. |
| `next-forge` | `vercel/vercel-plugin` | Work with the `next-forge` SaaS starter. |
| `nextjs` | `vercel/vercel-plugin` | Build and debug Next.js App Router apps. |
| `react-best-practices` | `vercel/vercel-plugin` | Review React/TSX component quality. |
| `routing-middleware` | `vercel/vercel-plugin` | Configure Vercel Routing Middleware. |
| `runtime-cache` | `vercel/vercel-plugin` | Use Vercel Runtime Cache. |
| `shadcn` | `vercel/vercel-plugin` | Initialize and troubleshoot `shadcn/ui`. |
| `turbopack` | `vercel/vercel-plugin` | Configure and debug Turbopack. |
| `turborepo` | `vercel/vercel-plugin` | Set up and optimize Turborepo. |
| `vercel-agent` | `vercel/vercel-plugin` | Use Vercel's agent/review guidance. |
| `vercel-cli` | `vercel/vercel-plugin` | Operate Vercel from the CLI. |
| `vercel-functions` | `vercel/vercel-plugin` | Configure and debug Vercel Functions. |
| `vercel-sandbox` | `vercel/vercel-plugin` | Run code in Vercel Sandbox. |
| `vercel-storage` | `vercel/vercel-plugin` | Choose and configure Vercel storage. |
| `verification` | `vercel/vercel-plugin` | Verify full application flows end to end. |
| `workflow` | `vercel/vercel-plugin` | Build durable Vercel workflows. |

</details>

<details>
<summary><code>design</code>: visual design and creative assets</summary>

| Skill | Source | What it is for |
| --- | --- | --- |
| `algorithmic-art` | `anthropics/skills` | Create generative and algorithmic art. |
| `brand-guidelines` | `anthropics/skills` | Apply brand colors, typography, and visual rules. |
| `canvas-design` | `anthropics/skills` | Create static visual art and design pieces. |
| `slack-gif-creator` | `anthropics/skills` | Create animated GIFs optimized for Slack. |
| `theme-factory` | `anthropics/skills` | Apply or generate visual themes. |
| `web-artifacts-builder` | `anthropics/skills` | Build complex interactive HTML artifacts. |
| `huashu-design` | `alchaincyf/huashu-design` | Create high-fidelity prototypes, demos, slides, and variants. |
| `imagegen` | `openai/skills` | Generate or edit bitmap images. |

</details>

<details>
<summary><code>writing</code>: writing, editing, and creator workflows</summary>

| Skill | Source | What it is for |
| --- | --- | --- |
| `huashu-agent-swarm` | `alchaincyf/huashu-skills` | Coordinate large work with a multi-agent workflow. |
| `huashu-article-edit` | `alchaincyf/huashu-skills` | Edit articles with scope and change tracking. |
| `huashu-article-to-x` | `alchaincyf/huashu-skills` | Turn long articles into short social posts. |
| `huashu-douyin-script` | `alchaincyf/huashu-skills` | Generate Douyin-style scripts and shot plans. |
| `huashu-prompt-save` | `alchaincyf/huashu-skills` | Classify and save prompts. |
| `huashu-proofreading` | `alchaincyf/huashu-skills` | Proofread writing to make it more natural. |
| `huashu-script-polish` | `alchaincyf/huashu-skills` | Polish scripts into spoken language. |
| `huashu-speech-coach` | `alchaincyf/huashu-skills` | Prepare speeches, talks, and training sessions. |
| `huashu-topic-gen` | `alchaincyf/huashu-skills` | Generate topic directions with outlines. |
| `huashu-video-check` | `alchaincyf/huashu-skills` | Review video titles, covers, hooks, and retention. |
| `huashu-video-outline` | `alchaincyf/huashu-skills` | Create video outline options. |
| `huashu-image-upload` | `alchaincyf/huashu-skills` | Generate article images and insert Markdown links. |
| `huashu-wechat-image` | `alchaincyf/huashu-skills` | Generate WeChat article covers and inline images. |
| `huashu-xhs-image` | `alchaincyf/huashu-skills` | Generate Xiaohongshu note images. |
| `doc-coauthoring` | `anthropics/skills` | Co-author docs, proposals, and specs. |
| `internal-comms` | `anthropics/skills` | Write internal updates, FAQs, and incident notes. |

</details>

<details>
<summary><code>research</code>: web research and knowledge extraction</summary>

| Skill | Source | What it is for |
| --- | --- | --- |
| `dokobot` | `dokobot/skills` | Read and extract rendered web pages with Chrome. |
| `huashu-research` | `alchaincyf/huashu-skills` | Run structured web research with saved results. |
| `huashu-info-search` | `alchaincyf/huashu-skills` | Search and cross-check products, tech, and references. |
| `huashu-material-search` | `alchaincyf/huashu-skills` | Search a personal material library. |
| `notion-research-documentation` | `openai/skills` | Research across Notion and synthesize documentation. |

</details>

<details>
<summary><code>office</code>: documents, spreadsheets, slides, and PDFs</summary>

| Skill | Source | What it is for |
| --- | --- | --- |
| `pdf` | `anthropics/skills` | Read, extract, split, merge, OCR, or create PDFs. |
| `docx` | `anthropics/skills` | Create, read, edit, and format Word documents. |
| `xlsx` | `anthropics/skills` | Create, clean, analyze, and convert spreadsheets. |
| `pptx` | `anthropics/skills` | Create, edit, combine, and inspect PowerPoint decks. |
| `notion-meeting-intelligence` | `openai/skills` | Prepare meeting materials with Notion context. |
| `huashu-data-pro` | `alchaincyf/huashu-skills` | Handle data analysis, reports, Excel, charts, and PPTs. |
| `huashu-md-to-pdf` | `alchaincyf/huashu-skills` | Convert Markdown into formatted PDF documents. |
| `huashu-slides` | `alchaincyf/huashu-skills` | Build PPTX presentations with design support. |

</details>

`all` includes `dev`, `design`, `writing`, `research`, and `office`.

## Local CLI

For local development, install the symlink:

```bash
git clone https://github.com/YatMn/skillpack.git
cd skillpack
./install.sh
```

Then from any project:

```bash
skillpack dev --target codex
skillpack add writing --target codex,cursor
```

## Commands

```bash
skillpack list
skillpack show dev
skillpack dev --target codex
skillpack -dev --target codex
skillpack init dev --target codex,cursor
skillpack add writing --target all
skillpack update
skillpack restore
skillpack doctor
skillpack doctor --target codex,cursor
skillpack coverage
```

## Profile Format

Profiles are readable YAML files with a small, Bash-parsed subset:

```yaml
name: dev
title: Development
summary: Build, debug, test, review, and ship software projects.

includes: []

skills:
  - source: obra/superpowers
    why: Planning and disciplined development workflow.
    names:
      - writing-plans
      - systematic-debugging
```

Keep `profiles/all.yaml` as an aggregate. Add real skill entries to the
specific scenario profile first.

## Development

```bash
bash -n install.sh bin/skillpack
./bin/skillpack list
./bin/skillpack show dev
./bin/skillpack show all
./bin/skillpack coverage
./bin/skillpack doctor
./bin/skillpack doctor --target codex,cursor
npm --cache /private/tmp/skillpack-npm-cache pack --dry-run
```

## Layout

```text
bin/skillpack       Bash CLI
profiles/*.yaml     Profile definitions
install.sh          Local symlink installer
package.json        Package metadata for npx/GitHub installs
```

## License

MIT. See [LICENSE](LICENSE).
