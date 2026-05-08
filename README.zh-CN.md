# skillsman

[English](README.md) | 简体中文

Skillsman 用来管理可复用的 agent skills 和项目级 setup scenarios，适用于
Codex、Claude Code、Cursor，以及其他通过 `npx skills` 安装 skills 的环境。

这个仓库包含可安装的 `skillsman-*` skills、scenarios 定义，以及一个 Bash
CLI。CLI 会展开选中的 scenario，检查目标项目，然后把安装动作交给 `npx skills` 执行。

维护者：YatMn <yatmn@outlook.com>

## 功能

- 在 `skills/` 下保存第一方 agent skills。
- 在 `scenarios/` 下定义安装 scenarios。
- 把 skills 安装到项目本地的 agent 目录。
- 支持所有 `npx skills --agent` 接受的项目级 agent。
- 支持记录和应用项目 skills snapshot。

Skillsman 不安装全局 skills。安装命令会写入指定项目，并且默认拒绝把 skills
安装进本仓库；只有显式传 `--allow-self-install` 才允许。

## 快速开始

在当前项目安装一个 scenario：

```bash
npx github:YatMn/skillsman init workflow --target codex
npx github:YatMn/skillsman add web-app --target codex
```

把 scenarios 安装到其他项目：

```bash
npx github:YatMn/skillsman init workflow --target codex --project /path/to/project
npx github:YatMn/skillsman add database --target codex --project /path/to/project
```

使用本地 checkout：

```bash
./bin/skillsman list
./bin/skillsman show workflow
./bin/skillsman init workflow --target codex --project /path/to/project
```

直接安装一个内置 skill：

```bash
npx skills add YatMn/skillsman --skill skillsman-readme --agent codex
```

## 推荐用法

新项目可以先只安装管理入口 skill：

```bash
npx skills add YatMn/skillsman --skill skillsman-manage --agent codex
```

然后把目标 agent 和项目类型一起告诉 Codex：

```text
Use $skillsman-manage to initialize project skills for this repository.

Target: codex
Project type: web app
Project path: current repository

Inspect the project briefly, recommend the matching Skillsman scenarios, show the
install plan, and wait for confirmation before installing.
```

如果要安装给其他 agent，把 `Target` 改成 `claude-code`、`cursor`、
`gemini-cli`、`all`，或 `codex,cursor` 这样的逗号列表。`Project type`
按项目实际情况填写，例如 `backend service`、`full-stack app`、
`research project`、`writing project` 或 `design project`。

`skillsman-manage` 会根据这些信息推荐合适的 Skillsman scenarios，展示计划，等待确认，
然后按需要执行 `skillsman init`、`skillsman add`、`skillsman remove`、
`skillsman update`、`skillsman snapshot`、`skillsman apply` 或 `skillsman doctor`。

## 内置 Skills

| Skill | 用途 |
| --- | --- |
| `skillsman-agents-md` | 创建或改进仓库级 agent instruction 文件，例如 `AGENTS.md`。 |
| `skillsman-branch` | 按 main/develop/release 模型创建、检查、同步和治理 Git/GitHub branches。 |
| `skillsman-manage` | 管理项目 skills：inspect、initialize、add、remove、update、snapshot、apply 和 diagnose。 |
| `skillsman-next-prompt` | 为 Codex 创建简洁的 continuation、handoff 或 fresh-session prompt。 |
| `skillsman-readme` | 创建或更新实用的软件仓库 README 文档。 |

每个内置 skill 位于 `skills/<skill-name>/`。目录名、`SKILL.md` frontmatter
里的 `name`，以及 `agents/openai.yaml` metadata 应保持一致。

## Scenarios

| Scenario | 使用场景 |
| --- | --- |
| `workflow` | Planning、branching、review、publish、README 和 repository workflow skills。 |
| `web-app` | Frontend、React、Next.js、UI 和 browser app testing。 |
| `deployment` | Hosted web app deployment、env vars、functions、runtime 和 verification。 |
| `database` | Supabase、Postgres 和 storage。 |
| `research` | Web research 和 knowledge extraction。 |
| `writing` | Writing、docs、editing、office files、scripts、meetings、data 和 slides。 |
| `design` | Visual design、brand assets、themes、artifacts 和 generated images。 |
| `all` | 只用于 audit/test aggregate。不要用于真实项目。 |

安装前可以先预览 scenario：

```bash
skillsman show workflow
skillsman show web-app
```

Scenario 文件是简单 YAML：

```yaml
skills:
  - source: YatMn/skillsman
    why: Repository guidance, branch workflow, next prompt, and README helpers.
    names:
      - skillsman-branch
      - skillsman-readme
```

如果省略 `names`，Skillsman 会用 `npx skills add <source>` 安装该 source
里的全部 skills。如果写了 `names`，则只安装列出的 skills。

## Targets

| Target | 行为 |
| --- | --- |
| `codex` | 向 `npx skills` 传 `--agent codex`。 |
| `claude`, `claude-code` | 向 `npx skills` 传 `--agent claude-code`。 |
| `cursor` | 向 `npx skills` 传 `--agent cursor`。 |
| `gemini`, `gemini-cli` | 向 `npx skills` 传 `--agent gemini-cli`。 |
| `openclaw` | 向 `npx skills` 传 `--agent openclaw`。 |
| `antigravity` | 向 `npx skills` 传 `--agent antigravity`。 |
| `all` | 向 `npx skills` 传 `--agent '*'`。 |

安装命令必须传 `--target`。可以使用逗号分隔的列表，例如
`--target codex,cursor`，也可以使用 `--target all`。未知 target 会原样透传给
`npx skills --agent`。

## 命令

```bash
skillsman list
skillsman show workflow
skillsman status --target codex
skillsman init workflow --target codex
skillsman add writing --target codex,cursor
skillsman remove skillsman-readme --target codex
skillsman snapshot --target codex
skillsman apply .skillsman/skills.snapshot.yaml --target codex --project /path/to/project
skillsman update --project /path/to/project
skillsman restore --project /path/to/project
skillsman doctor --target codex
skillsman coverage
```

`init`、`add` 和 scenario shorthand 命令会跳过已知 target 目录里已经有 `SKILL.md`
或出现在 `npx skills list` 里的 skills。缺失的 skills 会按 source 合并，再通过
`npx skills add` 安装。

`status` 会通过 `npx skills list` 列出已安装的项目 skills。`remove` 会通过
`npx skills remove` 删除明确点名的项目 skills。`update` 会转交给
`npx skills update -p -y`。`restore` 是 `npx skills experimental_install` 的 legacy
passthrough；可重复执行的安装路径是重新运行对应的 scenario install。

## Snapshots

保存项目已安装的 skills：

```bash
skillsman snapshot --target codex
skillsman snapshot --target codex --output /path/to/skills.snapshot.yaml
```

默认 snapshot 路径：

```text
<project>/.skillsman/skills.snapshot.yaml
```

应用 snapshot：

```bash
skillsman apply /old/project/.skillsman/skills.snapshot.yaml --target codex --project /new/project
skillsman apply /old/project/.skillsman/skills.snapshot.yaml --target codex --project /new/project --dry-run
```

Snapshot 使用 `skillsman.snapshot.v1` schema。`snapshot` 会扫描已安装的
`SKILL.md`，并从 `skills-lock.json` 解析每个 skill 的 source。如果无法解析
source，命令会失败，不会写出不完整的 snapshot。

## 开发

安装本地 CLI symlink：

```bash
./install.sh
```

运行本地检查：

```bash
bash -n install.sh bin/skillsman
./bin/skillsman list
./bin/skillsman show workflow
./bin/skillsman coverage
git diff --check
npm pack --dry-run
```

## 仓库结构

```text
bin/skillsman
scenarios/*.yaml
skills/*/SKILL.md
skills/*/agents/openai.yaml
skills/*/references/
install.sh
package.json
```

## License

MIT License. See [LICENSE](LICENSE).
