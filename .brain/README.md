# 🧠 Project Brain

> **This folder is the brain of the project.**
> Every AI tool — Claude, Cursor, Copilot, Windsurf, Gemini — can read this folder and instantly understand the project.

## Domain-Isolated Structure

Knowledge is organized into **domain-isolated subtrees**. Each domain is self-contained — Backend rules never mix with Frontend rules.

```
.brain/
├── INDEX.md                   ← Master index — start here
├── README.md                  ← You are here
├── agents/                    ← Agent definitions (framework-agnostic)
├── brain/                     ← Core system files (MISSION, PRINCIPLES, RULES, SYSTEM)
├── templates/                 ← Summary & testing templates
├── shared/skills/             ← Cross-domain skills (27 skills from 6 repos)
│
├── backend/                   ← Backend domain
│   ├── memory/                ← guidelines, decisions, lessons, sessions, tests, tasks
│   ├── skills/                ← Code templates (service, controller, resource, crud)
│   ├── rules/                 ← Project conventions (8 rule files)
│   ├── plans/                 ← Project plans
│   └── connections/           ← DB schema (gitignored)
│
├── frontend/                  ← Frontend domain
│   ├── INDEX.md               ← Frontend index
│   ├── FRONTEND_BEST_PRACTICES.md ← Human-readable guide
│   ├── skills/                ← 7 skills (Mantine, UI eng, design, animations)
│   ├── rules/                 ← 11 frontend engineering rules
│   ├── reference/             ← Mantine UI integration guide
│   └── memory/                ← Decisions, lessons, tests, tasks
│
├── mobile-ios/                ← iOS domain (for future projects)
├── mobile-android/            ← Android domain (for future projects)
└── devops/                    ← DevOps domain
    └── skills/                ← DevOps patterns
```

## What's Inside Each Domain

| Path | What It Tells the AI |
|------|----------------------|
| `{domain}/memory/guidelines.md` | Architecture, tech stack, conventions |
| `{domain}/memory/decisions/` | Why past decisions were made |
| `{domain}/memory/lessons/` | What went wrong and how to avoid it |
| `{domain}/memory/tasks/` | What work was done and how |
| `{domain}/memory/tests/` | Test results per feature |
| `{domain}/skills/` | How to write code in this project |
| `{domain}/rules/` | Project-specific conventions (8-11 files per domain) |
| `{domain}/plans/` | Active and past plans |
| `{domain}/reference/` | External reference docs (Mantine, etc.) |

## For AI Tools

When you start working on this project:

1. **Identify the domain** — Backend, Frontend, Mobile, or DevOps?
2. **Read** `.brain/INDEX.md` — full map
3. **Read** `.brain/{domain}/memory/guidelines.md` — architecture & conventions
4. **Check** `.brain/{domain}/skills/` — code patterns
5. **Check** `.brain/{domain}/rules/` — engineering rules
6. **Check** `.brain/{domain}/plans/` — active plans

## For Humans

- Commit this folder to your repo
- Every team member's AI tool reads the same knowledge
- Nothing is lost between sessions
- Always up to date
