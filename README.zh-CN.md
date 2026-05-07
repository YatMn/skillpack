# skillpack

[English](README.md) | 简体中文

面向 Codex、Claude Code 和 Cursor 的项目级 skill profile 安装器。

`skillpack` 只是 initializer。它把一层使用场景 profile 放在 `profiles/*.yaml`，然后在目标项目里
委托 `npx skills` 完成真实安装。它不保存真实 skill 内容，不安装全局 skills，也不把
`skills-lock.json` 当成 source of truth。

## 治理模型

- SkillPack 是本地项目 skills 的唯一分发入口。
- Codex 插件只保留工具能力，不作为 skill 分发来源。
- Profile 按使用场景命名，不按 vendor 或 skill source 命名。
- Vendor 和 package 名只出现在功能 profile 内部的 `source` 字段。
- `all` 只用于 audit 和测试覆盖，不用于真实项目。
- `skills-lock.json` 是 `npx skills` 生成物；git 忽略，SkillPack 安装判断也忽略它。

## 快速开始

安装到当前项目：

```bash
npx github:YatMn/skillpack init workflow --target codex
npx github:YatMn/skillpack add web-app --target codex
```

从任意目录安装到指定项目：

```bash
skillpack init workflow --target codex --project /Users/yatmn/Projects/ByteX/Trendiq
skillpack add web-app --target codex --project /Users/yatmn/Projects/ByteX/Trendiq
skillpack add database --target codex --project /Users/yatmn/Projects/ByteX/Trendiq
```

默认拒绝把 project skills 安装到 `skillpack` 仓库自己。只有明确测试时才传
`--allow-self-install`。

## Targets

安装命令必须显式传 `--target`。支持 `codex`、`claude`、`cursor` 和 `all`。

| Target | 项目 skills 目录 |
| --- | --- |
| `codex` | `.agents/skills` |
| `claude` | `.claude/skills` |
| `cursor` | `.cursor/skills` |
| `all` | 同时安装 `codex`、`claude` 和 `cursor`。 |

## Profiles

| Profile | 用途 |
| --- | --- |
| `workflow` | 规划、分支、review、CI 修复、README 和发布流程。 |
| `web-app` | Frontend、React、Next.js、UI 和浏览器应用测试。 |
| `deployment` | 托管 Web app 部署、env vars、functions、runtime 和验证。 |
| `database` | Supabase、Postgres 和数据库存储。 |
| `research` | 网络调研和知识提取。 |
| `writing` | 写作、文档、编辑、office 文件、脚本、会议、数据和 slides。 |
| `design` | 视觉设计、品牌资产、themes、artifacts 和 image generation。 |
| `all` | 仅 audit/test 聚合。 |

查看展开后的安装计划：

```bash
skillpack show workflow
skillpack show web-app
skillpack show deployment
```

## Profile 条目

每个 `skills` entry 必须有 `source` 和 `why`。`names` 可以省略：

```yaml
skills:
  - source: obra/superpowers
    why: Planning, TDD, debugging, review, verification, and branch workflow.
```

省略 `names` 表示安装这个 source 下全部 skills，对应调用：

```bash
npx skills add <source>
```

只有需要安装子集时才写 `names`：

```yaml
skills:
  - source: vercel/vercel-plugin
    why: Build React and Next.js apps with common UI and build tooling.
    names:
      - nextjs
      - react-best-practices
```

## 幂等安装

对每个 target，SkillPack 检查：

```text
<project>/<target-skill-dir>/<skill>/SKILL.md
```

已经存在的 skill 会 skip；缺失的 skill 会按 source 分组，每个 source 调一次
`npx skills add`。输出会包含：

```text
summary: installed 3, skipped 14
```

这个判断不依赖 `skills-lock.json`。

对于省略 `names` 的 entry，SkillPack 会把整个 source 交给
`npx skills add <source>`。因为 profile 没列 skill name，它不能逐个 skill 预先 skip
或逐个验证。

## 推荐安装矩阵

| 项目 | Profiles |
| --- | --- |
| `skillpack` | 默认不安装。只有显式测试才用 `--allow-self-install`。 |
| `yatmn-skills` | `workflow` |
| `Arcly` | `workflow` |
| `Trendiq` | `workflow + web-app + database + deployment + research` |
| `Codelet` | `workflow + web-app` |
| `career-ops` | `workflow + web-app + research + writing` |
| `x-crew` | `workflow` |

## 本地 CLI

```bash
git clone https://github.com/YatMn/skillpack.git
cd skillpack
./install.sh
```

然后在任意项目运行：

```bash
skillpack init workflow --target codex
skillpack add web-app --target codex,cursor
```

## 命令

```bash
skillpack list
skillpack show workflow
skillpack init workflow --target codex --project /path/to/project
skillpack add web-app --target codex,cursor --project /path/to/project
skillpack doctor --target codex --project /path/to/project
skillpack coverage
```

`restore` 只保留为 legacy `npx skills` passthrough。推荐重新运行需要的 profiles。

## 重建策略

本地重建时先备份，再移除生成物：

```text
~/.codex/skill-backups/YYYY-MM-DD-local-skill-reset/
```

先备份 `~/.codex/config.toml`、全局 loose skills、项目 `.agents/skills/` 和项目
`skills-lock.json`。然后清理生成目录，再按安装矩阵重新安装。

## 验证

```bash
bash -n install.sh bin/skillpack
./bin/skillpack list
./bin/skillpack show workflow
./bin/skillpack show web-app
./bin/skillpack show deployment
./bin/skillpack coverage
```
