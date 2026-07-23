# 🧠 Project Brain Index

> **Last updated:** 2026-07-23
> **Purpose:** Everything an AI tool needs to understand this project.
> **How to use:** Start here, identify which domain your task belongs to, then read the relevant subtree.

---

## Domain Isolation Structure

RAI-Engineering organizes knowledge into **domain-isolated subtrees**. Each domain is self-contained.

```
.brain/
├── INDEX.md                              ← You are here
├── README.md                             ← What this folder is
├── agents/                               ← Agent definitions (framework-agnostic)
├── brain/                                ← Core OS files
├── templates/                            ← Summary & testing templates
├── shared/skills/                        ← Cross-domain skills (27 skills from 6 repos)
├── session-bus/                          ← Inter-session message bus (gitignored)
├── sessions/                             ← Session registry
│
├── backend/                              ← Backend domain
│   ├── README.md
│   └── rai-engineering/                  ← RAI-Engineering's own knowledge
│       ├── memory/guidelines.md          ← Architecture, conventions, stack
│       ├── memory/decisions/             ← Past architecture decisions
│       ├── memory/architecture/          ← Component maps
│       ├── memory/lessons/               ← Things learned
│       ├── memory/sessions/              ← Every interaction logged
│       ├── memory/tests/                 ← Test summaries per feature
│       ├── memory/tasks/                 ← Task summaries with results
│       ├── memory/business/              ← Business rules
│       ├── rules/                        ← Project rules (V2: SECURITY, API_DESIGN, COMMIT_MESSAGES, GIT_SAFETY merged)
│       ├── skills/                       ← Code templates & patterns
│       ├── plans/                        ← Project plans
│       └── connections/                  ← DB connections (gitignored)
│
├── frontend/                             ← Frontend domain (NEW: 6 skills)
│   ├── README.md
│   └── rai-engineering/skills/           ← UI eng, design, devtools, animations
├── mobile-ios/                           ← iOS domain (for future projects)
├── mobile-android/                       ← Android domain (for future projects)
└── devops/                               ← DevOps domain (NEW: CI/CD skill)
    ├── README.md
    └── rai-engineering/skills/           ← DevOps patterns
```

---

## 🧩 Skills Library

> Newly imported from 6 GitHub repos (mattpocock, anthropics, addyosmani, obra, emilkowalski, nextlevelbuilder). See `.brain/shared/skills/`, `.brain/frontend/rai-engineering/skills/`, and `.brain/devops/rai-engineering/skills/` for full files.

### Shared Skills `.brain/shared/skills/`

| Skill | Source | Use When |
|-------|--------|----------|
| context-engineering | addyosmani | Structuring what an AI sees; session setup |
| verification-before-completion | obra | Before claiming any task is done |
| systematic-debugging | obra + addyosmani | Any bug, test failure, unexpected behavior |
| test-driven-development | mattpocock + addyosmani + obra | New features, bug fixes, refactoring |
| writing-plans | obra + addyosmani | Multi-step tasks before touching code |
| executing-plans | obra | Working through a written plan inline |
| codebase-design | mattpocock | Designing new modules, evaluating architecture |
| subagent-driven-development | obra | Fresh subagents per task with review gates |
| dispatching-parallel-agents | obra | Multiple independent tasks in parallel |
| brainstorming | obra + addyosmani | Turning vague ideas into actionable specs |
| code-review | addyosmani + mattpocock | Reviewing code changes before merge |
| code-simplification | addyosmani | Simplifying code without changing behavior |
| incremental-implementation | addyosmani | Building in thin vertical slices |
| source-driven-development | addyosmani | Grounding implementation in official docs |
| spec-driven-development | addyosmani | Four-phase gated workflow with specs |
| documentation-and-adrs | addyosmani | Writing ADRs, READMEs, inline docs |
| deprecation-and-migration | addyosmani | Removing old systems, migrating users |
| performance-optimization | addyosmani | Measurement-first performance work |
| shipping-and-launch | addyosmani | Pre-launch checklists, staged rollouts |
| observability-and-instrumentation | addyosmani | Logging, metrics, tracing, alerting |
| domain-modeling | mattpocock | Building shared vocabulary (CONTEXT.md) |
| research | mattpocock | Investigating questions against primary sources |
| prototype | mattpocock | Throwaway code that answers a question |
| resolving-merge-conflicts | mattpocock | In-progress merge/rebase conflicts |
| improve-codebase-architecture | mattpocock | Deepening shallow modules |
| using-git-worktrees | obra | Isolated workspaces for parallel agents |
| finishing-a-development-branch | obra | Merging/pushing/discarding branches |

### Frontend Skills `.brain/frontend/rai-engineering/skills/`

| Skill | Source | Use When |
|-------|--------|----------|
| frontend-ui-engineering | addyosmani | Production-quality, accessible UIs |
| frontend-design-principles | anthropics | Creating distinctive visual identities |
| browser-testing-with-devtools | addyosmani | Live browser testing and debugging |
| design-engineering | emilkowalski | Animation-focused UI engineering |
| apple-design-principles | emilkowalski | Apple WWDC design principles for web |
| animation-vocabulary | emilkowalski | Precise animation terminology for agents |

### DevOps Skills `.brain/devops/rai-engineering/skills/`

| Skill | Source | Use When |
|-------|--------|----------|
| ci-cd-and-automation | addyosmani | Setting up CI/CD pipelines and automation |

---

## Quick Start

| If you want to... | Read this |
|-------------------|-----------|
| Understand project architecture | `.brain/backend/rai-engineering/memory/guidelines.md` |
| Check past decisions | `.brain/backend/rai-engineering/memory/decisions/` |
| Learn from past mistakes | `.brain/backend/rai-engineering/memory/lessons/` |
| See what was done recently | `.brain/backend/rai-engineering/memory/tasks/` |
| Create a service | `.brain/backend/rai-engineering/skills/service.md` |
| Create a controller | `.brain/backend/rai-engineering/skills/controller.md` |
| Create an API resource | `.brain/backend/rai-engineering/skills/resource.md` |
| Generate a full CRUD | `.brain/backend/rai-engineering/skills/crud.md` |
| Browse ALL cross-domain skills | `.brain/shared/skills/` (27 skills) |
| Browse frontend skills | `.brain/frontend/rai-engineering/skills/` (6 skills) |
| Browse devops skills | `.brain/devops/rai-engineering/skills/` (1 skill) |
| Follow project conventions | `.brain/backend/rai-engineering/rules/project-rules.md` |
| Check DB schema | `.brain/backend/rai-engineering/connections/database.md` |
| Browse plans | `.brain/backend/rai-engineering/plans/` |

---

## Active Decisions

- [Caveman ULTRA Install](backend/rai-engineering/memory/decisions/caveman-ultra-install.md) — 67% token compression
- [Super TESTER Upgrade](backend/rai-engineering/memory/decisions/super-tester-upgrade.md) — 5 testing modes
- [.brain/ Migration](backend/rai-engineering/memory/decisions/brain-migration.md) — Team-wide AI knowledge base
- [Orchestration Engine](backend/rai-engineering/memory/decisions/2026-07-23-orchestration-engine.md) — Parallel execution engine

## Lessons

- [Version Bump Before Push](backend/rai-engineering/memory/lessons/version-bump-before-push.md) — R30

## Task Summaries

- [Super TESTER Upgrade](backend/rai-engineering/memory/tasks/2026-07-13-super-tester-upgrade.md)
- [.brain/ Migration](backend/rai-engineering/memory/tasks/2026-07-13-brain-migration.md)

## Plans

- [Multi-Session Mesh](backend/rai-engineering/plans/2026-07-19-multi-session-architecture.md)
- [Domain Isolation Protocol](backend/rai-engineering/plans/2026-07-21-domain-isolation-protocol.md)
- [Orchestration & Parallel Execution](backend/rai-engineering/plans/2026-07-23-orchestration-parallel-execution.md)
