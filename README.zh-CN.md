# skillpack

[English](README.md) | 简体中文

面向 Codex、Claude Code 和 Cursor 的项目级 skill profile 安装器。

`skillpack` 不保存真实 skill 内容。它只展开 `profiles/*.yaml` 里的 profile，然后
通过 `npx skills` 把 skills 安装到当前项目。

## 快速开始

在需要 local agent skills 的项目里运行：

```bash
npx github:YatMn/skillpack dev --target codex
```

等价快捷写法：

```bash
npx github:YatMn/skillpack -dev --target codex
npx github:YatMn/skillpack --dev --target codex
```

把同一个 profile 安装给多个 agent：

```bash
npx github:YatMn/skillpack dev --target codex,cursor
npx github:YatMn/skillpack dev --target all
```

安装命令必须显式传 `--target`。支持的 target 是 `codex`、`claude`、
`cursor` 和 `all`。

Target 输出目录：

| Target | Project skills directory |
| --- | --- |
| `codex` | `.agents/skills` |
| `claude` | `.claude/skills` |
| `cursor` | `.cursor/skills` |
| `all` | 同时安装 `codex`、`claude` 和 `cursor`。 |

## Profiles

| Profile | 用途 |
| --- | --- |
| `dev` | 软件和 Web 开发。 |
| `design` | 视觉设计和创意素材。 |
| `writing` | 写作、编辑和创作者工作流。 |
| `research` | 网络调研和知识提取。 |
| `office` | 文档、表格、幻灯片和 PDF。 |
| `all` | 聚合 profile。 |

查看 profile 会安装什么：

```bash
npx github:YatMn/skillpack show dev
```

## Profile Skills

<details>
<summary><code>dev</code>：软件和 Web 开发</summary>

| Skill | Source | 用途 |
| --- | --- | --- |
| `brainstorming` | `obra/superpowers` | 在功能或创意工作前梳理意图和需求。 |
| `dispatching-parallel-agents` | `obra/superpowers` | 把独立任务拆给并行 agents。 |
| `executing-plans` | `obra/superpowers` | 按已有 implementation plan 执行并检查。 |
| `finishing-a-development-branch` | `obra/superpowers` | 在实现和验证后收尾开发分支。 |
| `receiving-code-review` | `obra/superpowers` | 处理 code review 反馈。 |
| `requesting-code-review` | `obra/superpowers` | 在较大改动后请求聚焦 review。 |
| `subagent-driven-development` | `obra/superpowers` | 用独立 subagent tasks 执行计划。 |
| `systematic-debugging` | `obra/superpowers` | 在修复前系统排查 bug 和失败测试。 |
| `test-driven-development` | `obra/superpowers` | 用 test-first 循环实现功能或修复。 |
| `using-git-worktrees` | `obra/superpowers` | 用 Git worktrees 隔离功能开发。 |
| `using-superpowers` | `obra/superpowers` | 建立 skill discovery 和工作流纪律。 |
| `verification-before-completion` | `obra/superpowers` | 完成声明前先验证。 |
| `writing-plans` | `obra/superpowers` | 把需求转成 implementation plan。 |
| `writing-skills` | `obra/superpowers` | 创建、编辑和验证 Codex skills。 |
| `context7` | `intellectronica/agent-skills` | 查询当前库文档和 API reference。 |
| `claude-api` | `anthropics/skills` | 构建或调试 Anthropic Claude API 应用。 |
| `mcp-builder` | `anthropics/skills` | 设计和实现 MCP servers。 |
| `frontend-design` | `anthropics/skills` | 构建精致 Web UI 和界面 artifacts。 |
| `webapp-testing` | `anthropics/skills` | 用浏览器自动化测试本地 Web app。 |
| `gh-address-comments` | `openai/skills` | 处理 GitHub PR review comments。 |
| `gh-fix-ci` | `openai/skills` | 调试和修复 GitHub checks。 |
| `notion-knowledge-capture` | `openai/skills` | 把对话和决策保存到 Notion。 |
| `notion-spec-to-implementation` | `openai/skills` | 把 Notion specs 转成实现计划。 |
| `openai-docs` | `openai/skills` | 使用当前官方 OpenAI 文档。 |
| `plugin-creator` | `openai/skills` | 搭建 Codex plugin。 |
| `skill-creator` | `openai/skills` | 设计新 skills 或更新已有 skills。 |
| `skill-installer` | `openai/skills` | 从 curated sources 或 GitHub 安装 skills。 |
| `yeet` | `openai/skills` | 通过 GitHub 发布本地改动。 |
| `supabase-postgres-best-practices` | `supabase/agent-skills` | Review 和优化 Supabase/Postgres 工作。 |
| `ai-gateway` | `vercel/vercel-plugin` | 配置 Vercel AI Gateway routing。 |
| `ai-sdk` | `vercel/vercel-plugin` | 用 Vercel AI SDK 构建 AI 功能。 |
| `auth` | `vercel/vercel-plugin` | 在 Vercel/Next.js app 中集成 auth。 |
| `bootstrap` | `vercel/vercel-plugin` | 设置 Vercel 关联项目资源。 |
| `chat-sdk` | `vercel/vercel-plugin` | 用 Vercel Chat SDK 构建 chat bots。 |
| `deployments-cicd` | `vercel/vercel-plugin` | 部署、promote、rollback 和检查 Vercel app。 |
| `env-vars` | `vercel/vercel-plugin` | 管理 Vercel environment variables。 |
| `marketplace` | `vercel/vercel-plugin` | 处理 Vercel Marketplace integrations。 |
| `next-forge` | `vercel/vercel-plugin` | 使用 `next-forge` SaaS starter。 |
| `nextjs` | `vercel/vercel-plugin` | 构建和调试 Next.js App Router app。 |
| `react-best-practices` | `vercel/vercel-plugin` | Review React/TSX component 质量。 |
| `routing-middleware` | `vercel/vercel-plugin` | 配置 Vercel Routing Middleware。 |
| `runtime-cache` | `vercel/vercel-plugin` | 使用 Vercel Runtime Cache。 |
| `shadcn` | `vercel/vercel-plugin` | 初始化和排查 `shadcn/ui`。 |
| `turbopack` | `vercel/vercel-plugin` | 配置和调试 Turbopack。 |
| `turborepo` | `vercel/vercel-plugin` | 设置和优化 Turborepo。 |
| `vercel-agent` | `vercel/vercel-plugin` | 使用 Vercel agent/review 指南。 |
| `vercel-cli` | `vercel/vercel-plugin` | 通过 CLI 操作 Vercel。 |
| `vercel-functions` | `vercel/vercel-plugin` | 配置和调试 Vercel Functions。 |
| `vercel-sandbox` | `vercel/vercel-plugin` | 在 Vercel Sandbox 中运行代码。 |
| `vercel-storage` | `vercel/vercel-plugin` | 选择和配置 Vercel storage。 |
| `verification` | `vercel/vercel-plugin` | 端到端验证完整应用流程。 |
| `workflow` | `vercel/vercel-plugin` | 构建 durable Vercel workflows。 |

</details>

<details>
<summary><code>design</code>：视觉设计和创意素材</summary>

| Skill | Source | 用途 |
| --- | --- | --- |
| `algorithmic-art` | `anthropics/skills` | 创建生成式和算法艺术。 |
| `brand-guidelines` | `anthropics/skills` | 应用品牌颜色、字体和视觉规则。 |
| `canvas-design` | `anthropics/skills` | 创建静态视觉设计作品。 |
| `slack-gif-creator` | `anthropics/skills` | 创建适合 Slack 的 animated GIF。 |
| `theme-factory` | `anthropics/skills` | 应用或生成视觉主题。 |
| `web-artifacts-builder` | `anthropics/skills` | 构建复杂交互 HTML artifacts。 |
| `huashu-design` | `alchaincyf/huashu-design` | 创建高保真原型、交互 demo、slides 和设计变体。 |
| `imagegen` | `openai/skills` | 生成或编辑 bitmap images。 |

</details>

<details>
<summary><code>writing</code>：写作、编辑和创作者工作流</summary>

| Skill | Source | 用途 |
| --- | --- | --- |
| `huashu-agent-swarm` | `alchaincyf/huashu-skills` | 用 multi-agent workflow 协调大型工作。 |
| `huashu-article-edit` | `alchaincyf/huashu-skills` | 按范围和变更记录编辑文章。 |
| `huashu-article-to-x` | `alchaincyf/huashu-skills` | 把长文转成短社交帖。 |
| `huashu-douyin-script` | `alchaincyf/huashu-skills` | 生成抖音风格脚本和分镜。 |
| `huashu-prompt-save` | `alchaincyf/huashu-skills` | 分类和保存 prompts。 |
| `huashu-proofreading` | `alchaincyf/huashu-skills` | 审校文章，让表达更自然。 |
| `huashu-script-polish` | `alchaincyf/huashu-skills` | 把脚本改成适合口播的语言。 |
| `huashu-speech-coach` | `alchaincyf/huashu-skills` | 准备演讲、分享和培训。 |
| `huashu-topic-gen` | `alchaincyf/huashu-skills` | 生成选题方向和大纲。 |
| `huashu-video-check` | `alchaincyf/huashu-skills` | 检查视频标题、封面、开头和留存风险。 |
| `huashu-video-outline` | `alchaincyf/huashu-skills` | 生成视频大纲方案。 |
| `huashu-image-upload` | `alchaincyf/huashu-skills` | 生成文章图片并插入 Markdown 链接。 |
| `huashu-wechat-image` | `alchaincyf/huashu-skills` | 生成微信公众号封面和正文图。 |
| `huashu-xhs-image` | `alchaincyf/huashu-skills` | 生成小红书笔记图片。 |
| `doc-coauthoring` | `anthropics/skills` | 协作撰写 docs、proposals 和 specs。 |
| `internal-comms` | `anthropics/skills` | 撰写内部更新、FAQ 和 incident notes。 |

</details>

<details>
<summary><code>research</code>：网络调研和知识提取</summary>

| Skill | Source | 用途 |
| --- | --- | --- |
| `dokobot` | `dokobot/skills` | 用 Chrome 读取和提取渲染后的网页。 |
| `huashu-research` | `alchaincyf/huashu-skills` | 进行结构化网络调研并保存结果。 |
| `huashu-info-search` | `alchaincyf/huashu-skills` | 搜索并交叉验证产品、技术和资料。 |
| `huashu-material-search` | `alchaincyf/huashu-skills` | 搜索个人素材库。 |
| `notion-research-documentation` | `openai/skills` | 在 Notion 中调研并综合成文档。 |

</details>

<details>
<summary><code>office</code>：文档、表格、幻灯片和 PDF</summary>

| Skill | Source | 用途 |
| --- | --- | --- |
| `pdf` | `anthropics/skills` | 读取、提取、拆分、合并、OCR 或创建 PDF。 |
| `docx` | `anthropics/skills` | 创建、读取、编辑和排版 Word 文档。 |
| `xlsx` | `anthropics/skills` | 创建、清理、分析和转换 spreadsheets。 |
| `pptx` | `anthropics/skills` | 创建、编辑、合并和检查 PowerPoint decks。 |
| `notion-meeting-intelligence` | `openai/skills` | 用 Notion context 准备会议材料。 |
| `huashu-data-pro` | `alchaincyf/huashu-skills` | 处理数据分析、报告、Excel、图表和 PPT。 |
| `huashu-md-to-pdf` | `alchaincyf/huashu-skills` | 把 Markdown 转成排版后的 PDF 文档。 |
| `huashu-slides` | `alchaincyf/huashu-skills` | 制作带设计支持的 PPTX 演示文稿。 |

</details>

`all` 包含 `dev`、`design`、`writing`、`research` 和 `office`。

## 本地 CLI

本地开发时安装 symlink：

```bash
git clone https://github.com/YatMn/skillpack.git
cd skillpack
./install.sh
```

然后在任意项目里运行：

```bash
skillpack dev --target codex
skillpack add writing --target codex,cursor
```

## 命令

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

## Profile 格式

Profiles 是可读 YAML 文件，CLI 只解析一个很小的 Bash-friendly 子集：

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

`profiles/all.yaml` 只做聚合。新增 skill 条目时，先放进具体场景 profile。

## 开发验证

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

## 结构

```text
bin/skillpack       Bash CLI
profiles/*.yaml     Profile definitions
install.sh          Local symlink installer
package.json        npx/GitHub 安装所需的 package metadata
```

## License

MIT. 见 [LICENSE](LICENSE)。
