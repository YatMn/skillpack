# Skillsman Scenario Mapping

Use this reference to map a user-described project type to Skillsman scenarios.

## Mappings

| Project type | Scenarios | Notes |
| --- | --- | --- |
| Development management | `workflow` | Planning, branching, review, README, verification, and project workflow management. |
| Backend development | `workflow` | Server/API work gets development workflow support. Add `database` or `deployment` only when the request names those responsibilities. |
| Frontend or web app | `web-app` | UI/app work gets frontend and browser-testing support. Add `workflow` or `deployment` only when the request names those responsibilities. |
| Full-stack development | `workflow`, `web-app`, `database`, `deployment` | Covers UI, backend/data, deployment, and workflow. |
| Database work | `database` | Use when the project is primarily Supabase, Postgres, schema, migration, or storage work. |
| Deployment or operations | `deployment` | Use for hosting, environment variables, runtime inspection, releases, or production checks. |
| Research | `research` | Use for source gathering, evidence review, web research, or knowledge extraction. |
| Writing or documentation | `writing` | Use for docs, editing, office content, README-heavy work, or structured writing. |
| Design | `design` | Use for visual design, brand assets, themes, generated images, or design prototypes. |

## Selection Rules

- Prefer the narrowest scenario set that covers the user request.
- Include `workflow` when the request involves planning, branching, review, README, verification, or general development management. Otherwise keep the mapped scenario set narrow.
- Do not use `all` as a project type mapping. The Skillsman `all` scenario is for audit and test coverage only.
- If the user describes a stack rather than a project type, infer the project type conservatively:
  - API server, service, worker, CLI backend: backend development.
  - React, Next.js, browser UI, dashboard: frontend or web app.
  - App with both frontend and database/backend responsibilities: full-stack development.
  - Supabase, Postgres, SQL, migration-only work: database work.
  - Vercel, Cloudflare, runtime, env vars, production release: deployment or operations.
