# RAI-Engineering — Architecture

> Version 1.5.3 — DevOps Rules System (45 rules, 17 agents, domain isolation, inter-session mesh)

---

## 1. What Is the Brain?

The **Brain** is a **message broker** embedded in `CLAUDE.md`. It does not write code, plan features, review changes, or test anything directly.

The Brain does exactly three things:
1. **Route** messages from one agent to another
2. **Validate** every message's structure before delivery
3. **Persist** decisions and conversations to memory

Agents talk to each other. The Brain facilitates. No slash commands or special prefixes — the system auto-detects what agents to call based on the task.

```
Agent A ──message──► Brain ──validated message──► Agent B
                         ◄──response──────────────
```

The Brain is defined by:

- `.brain/brain/SYSTEM.md` — Message broker protocol and routing rules
- `.brain/brain/MISSION.md` — The system's purpose (immutable)
- `.brain/brain/PRINCIPLES.md` — Design values that guide all decisions
- `.brain/brain/LIMITATIONS.md` — Hard boundaries the system must not cross
- `.brain/brain/RULES.md` — Enforceable rules (R1-R45)
- `.brain/brain/ORCHESTRATION.md` — Parallel dispatch and multi-agent orchestration protocol
- `.brain/brain/INTER_SESSION.md` — Multi-session mesh communication protocol
- `.brain/brain/MEMORY_SYSTEM.md` — Memory indexing, storage, and retrieval protocol

**The Brain never writes code.** It routes messages between agents and delegates execution.

All system files live under `.brain/`, making it compatible with any AI tool — Claude Code, Cursor, Windsurf, Copilot.

---

## 2. The Skill Mandate

Skills are **mandatory**, not optional. Before any task starts, the Brain checks the **Skill Trigger Table** and loads matching skills.

### Skill Trigger Table

| Task signal | Domain | Skill(s) to load |
|---|---|---|
| React/Vue/Angular, UI, Mantine | Frontend | UI/Frontend Skill + relevant frontend rules |
| API, DB, server, auth, jobs | Backend | Backend Skill |
| Swift/Kotlin/Flutter/RN | Mobile | Mobile Skill |
| Terraform, Docker, CI/CD, deploy | DevOps | DevOps Skill + devops rules |
| "review this", "audit" | Any | Code Review Skill |

### Skill Location

Skills live in two places:

- **Shared skills** (`.brain/shared/skills/`) — framework-agnostic, reusable across domains (27+ skills):
  - `context-engineering`, `code-review`, `test-driven-development`, `systematic-debugging`
  - `writing-plans`, `executing-plans`, `subagent-driven-development`, `dispatching-parallel-agents`
  - `code-simplification`, `improve-codebase-architecture`, `performance-optimization`
  - `domain-modeling`, `source-driven-development`, `spec-driven-development`
  - `brainstorming`, `research`, `prototype`, `shipping-and-launch`
  - `deprecation-and-migration`, `incremental-implementation`, `verification-before-completion`
  - `resolving-merge-conflicts`, `finishing-a-development-branch`, `documentation-and-adrs`
  - `using-git-worktrees`, `observability-and-instrumentation`, `codebase-design`

- **Domain skills** (`.brain/{domain}/skills/`) — framework-specific templates:
  - `.brain/backend/skills/` — `controller`, `service`, `resource`, `crud`
  - Domain-specific skills per project framework

### Skill Mandate Rules

1. Check for a matching skill before every task
2. Load and follow it before writing code or answering
3. Never skip because a task "seems simple"
4. Apply multiple skills if a task spans domains
5. Check even if unsure — verify rather than assume
6. Load skill files — never fabricate contents
7. Re-check the trigger table before each new sub-task

---

## 3. What Is an Agent?

An **Agent** is a specialized role with a defined responsibility. Each agent receives a goal and returns a structured output — never free-form text.

Agents communicate through the Brain using the **Message Protocol**. Any agent can call any other agent for information, delegation, or consultation.

### Current Agent Roster (17 agents)

| Agent | Role | Returns | Can Call |
|-------|------|---------|----------|
| `ARCHITECT` | System architect — guidelines, patterns, consistency | `{ guidelines, architecturePattern, conventions }` | Any agent |
| `PLANNER` | Designer — produces structured plans | `{ goal, affectedFiles, risks, dependencies, executionPlan, questions }` | ARCHIVIST, MEMORY, REVIEWER |
| `ARCHIVIST` | Librarian — reads files, answers questions | `{ answers, relevantFiles, relatedDecisions, status }` | *(read-only)* |
| `DATABASE` | DB specialist — schema, migrations, queries, indexes | `{ schema, migrations, indexes, risks }` | ARCHIVIST |
| `SECURITY` | Security auditor — OWASP, CVSS, STRIDE, LLM/SSRF | `{ vulnerabilities, scores, mitigations }` | ARCHIVIST, DATABASE |
| `EXECUTOR` | Builder — writes the code | `{ filesChanged, testResults, lintResults, status }` | ARCHIVIST, BACKEND QA, CLEAN CODE, TESTER, REVIEWER |
| `BACKEND QA` | Backend auditor — clean code, queries, tests | `{ overallStatus, dimensions: { cleanCode, queryOptimization, security, testing }, fixes }` | CLEAN CODE, TESTER, ARCHIVIST |
| `CLEAN CODE` | Refactorer — SOLID, naming, duplication | `{ refactored, violationsFixed, qualityScore }` | ARCHIVIST, TESTER |
| `TESTER` | Test specialist — 5 testing modes | `{ generatedTests, testResults, coverage, status }` | ARCHIVIST, EXECUTOR |
| `REVIEWER` | Inspector — scores code 1-10, manages fix loop | `{ issues, suggestions, performance, security, score }` | BACKEND QA, TESTER, CLEAN CODE, ARCHIVIST, MEMORY, SECURITY, DATABASE |
| `MEMORY SCRIBE` | Historian — persists decisions, lessons, index | `{ decisions, lessons, architectureChanges, sessionSummary }` | PLANNER, EXECUTOR, REVIEWER, TESTER |
| `GITHUB` | Integrator — branches, commits, PRs | `{ branch, commits, prUrl, prBody, status }` | EXECUTOR, REVIEWER, TESTER, MEMORY |
| `GITHUB TASKS` | GitHub task manager — issues to delivery | `{ subTasks, plan, branch, summary }` | All agents |
| `SUMMARY` | Documentation specialist — professional summaries | `{ document, metrics, tables }` | All agents |
| `ORCHESTRATOR` | Session manager — registration, heartbeat, inter-session | `{ registered, peers, messages }` | All agents |
| `ORCHESTRATOR ENGINE` | Task orchestrator — decomposition, parallel dispatch, verification | `{ decomposition, waves, results, conflicts, status }` | All domain agents |
| `BRAIN` | Message broker — routes, validates, persists | Routes and validates | *(broker, all agents)* |

### Agent Communication Types

| Type | Meaning |
|------|---------|
| `request` | "I need information from you" — ask questions |
| `delegate` | "Take over this work and report back" — assign subtasks |
| `consult` | "Review this specific piece and give feedback" — mid-work advice |
| `escalate` | "I can't resolve this — needs human input" |
| `error` | "Something went wrong" |
| `done` | "Task complete, here's my output" |
| `inter_session_*` | Cross-session variants of the above (request, delegate, consult, done, error) |

### Agent Lifecycle

1. **Brain activates agent** — injects role, skills, memory context
2. **Agent works** — reads files, thinks, produces structured output
3. **Agent calls for help (optional)** — sends message through Brain to another agent
4. **Helper responds** — Brain validates and routes response back
5. **Agent completes output** — returns structured result to Brain
6. **Brain validates schema** — rejects malformed output
7. **Brain persists** — writes decisions, conversation to memory

### Agent Directory

Agent definitions live in `.brain/agents/{NAME}.md` — each file defiines purpose, input/output schemas, skills loaded, and who the agent can call.

---

## 4. Domain Isolation

Every task belongs to exactly one domain. **Domain knowledge never leaks** between domains.

### Domain Subtrees

```
.brain/
├── backend/                   ← Backend domain
│   ├── memory/                ← decisions, architecture, lessons, sessions, tests, tasks, business
│   │   ├── guidelines.md      ← Project structure & conventions
│   │   ├── decisions/         ← Architecture Decision Records (ADRs)
│   │   ├── architecture/      ← System component maps
│   │   ├── lessons/           ← Things learned
│   │   ├── sessions/          ← Session summaries
│   │   ├── tests/             ← Test summaries
│   │   ├── tasks/             ← Task summaries
│   │   └── business/          ← Business rules & glossary
│   ├── rules/                 ← Framework-scoped conventions
│   ├── skills/                ← Code templates (controller, service, resource, crud)
│   ├── plans/                 ← Project plans
│   └── connections/           ← DB connections ⚠️ GITIGNORED
│
├── frontend/                  ← Frontend domain (self-contained)
├── mobile-ios/                ← iOS domain (self-contained)
├── mobile-android/            ← Android domain (self-contained)
├── devops/                    ← DevOps domain (self-contained)
└── shared/                    ← Cross-domain shared skills
    └── skills/                ← 27+ framework-agnostic skills
```

### Domain Rules (R36-R40)

- **R36** — Every task must declare its domain before work begins
- **R37** — Plans, rules, skills, and memory are stored in domain-isolated subtrees
- **R38** — Cross-domain references use explicit relative links, never duplicated content
- **R39** — Rules within a domain are scoped to the declared framework (e.g., `backend/laravel/rules/`)
- **R40** — If `.brain/{domain}/` doesn't exist on first task, initialize it with subdirectories

---

## 5. The Rules System (R1-R45)

Rules are enforceable constraints that guide every interaction. They live in `.brain/brain/RULES.md` and are distributed to domain-specific files under `.brain/{domain}/rules/`.

### Rule Categories

| Category | Rules | Scope |
|----------|-------|-------|
| **Core** | R1-R10 | System-wide — planning, review, testing, memory, model lock, delegation |
| **Inter-session** | R32-R35 | Multi-session mesh — identity, heartbeat, idempotency, no circular delegation |
| **Domain isolation** | R36-R40 | Domain subtrees — identity, isolation, cross-references, framework scoping, initialization |
| **Orchestration** | R41-R45 | Parallel dispatch — decomposition, parallel default, relay, conflict resolution, max 3 cycles |
| **Code quality** | R24-R30 | Hardcoded secrets, naming, refactoring, tests, templates, version bump, summaries |
| **Approval** | R21-R23, R25, R27 | Approval before database changes, file deletions, commands, full test suite, refactoring |
| **Skills** | (Skill Mandate) | 8 rules in CLAUDE.md — check, load, follow, never skip |

### Current Version

v1.5.3 — 45 rules, including:
- 13 DevOps rules with handbook
- SECURITY rule (merged with STRIDE/LLM/SSRF)
- API_DESIGN rule (merged with Hyrum/contract-first)
- COMMIT_MESSAGES rule (merged with trunk-based/semver)
- GIT_SAFETY rule (merged with generated-files)

---

## 6. The Memory System

Memory is the project's persistent knowledge base — indexed, structured, and team-wide. All memory lives in `.brain/`, works with ANY AI tool, and is committed to the repo (except gitignored paths).

### Memory Flow

**Before work:** Read `.brain/INDEX.md` → `.brain/{domain}/memory/guidelines.md` → decisions/ → architecture/ → lessons/ → tests/ → tasks/

**After work:** MEMORY SCRIBE writes decisions/lessons/sessions/tests/tasks, ARCHITECT updates guidelines, MEMORY SCRIBE updates INDEX.md.

### Git Safety

- `.brain/agents/`, `.brain/brain/`, `.brain/{domain}/` (except `connections/`) — **committed**
- `.brain/{domain}/connections/` — **gitignored** (schema data w/ connection info)
- `.brain/session-bus/` — **gitignored** (ephemeral message queue)
- `.brain/sessions/live/` — **gitignored** (ephemeral session registrations)

### Summaries Are Mandatory

Every task, test, or discussion writes a summary:
- Tests → `.brain/{domain}/memory/tests/{{YYYY-MM-DD}}-{{feature}}.md`
- Tasks → `.brain/{domain}/memory/tasks/{{YYYY-MM-DD}}-{{task-slug}}.md`
- Templates: `.brain/templates/summary/TEST_SUMMARY.md`, `TASK_SUMMARY.md`

Summaries are team-ready: tables, icons, security, perf, DB, clean code, optimizations.

---

## 7. Orchestration System

For multi-domain or complex tasks with independent sub-tasks, the **ORCHESTRATOR ENGINE** runs before any domain-specific planning.

### Orchestration Flow

1. **Decompose** — Full task decomposition and dependency graph before any sub-agent runs (R41)
2. **Parallel waves** — Launch every sub-task whose dependencies are resolved at the same time (R42)
3. **Relay** — Cross-agent requests are logged, relayed, and delivered within the same turn (R43)
4. **Conflict resolution** — Auto-resolve by: project rules → past decisions → guidelines → conventions → framework defaults. Escalate only for real consequences (R44)
5. **Verification loop** — Max 3 cycles. Same-failure-3x escalates mid-cycle (R45)

### When It Runs

- Task involves multiple domains? → Decompose into sub-tasks
- Task has independent pieces of work? → Decompose into sub-tasks
- Build dependency graph and parallel waves
- Single-domain + single sub-task → skip, route normally

---

## 8. Inter-Session Protocol

Multiple sessions can discover each other, send messages, and delegate work across sessions.

### Protocol

- **R32** — Every session must register before sending/receiving inter-session messages
- **R33** — Registered sessions must update heartbeat every 60s
- **R34** — Inter-session messages must be safe to replay
- **R35** — No cross-session circular delegation (A → B → A rejected)

### Message Bus

```
.brain/session-bus/
├── inbox/{uuid}/         ← Incoming messages for this session
├── outbox/{uuid}/        ← Outgoing messages from this session
└── archive/              ← Processed messages (TTL-based cleanup)
```

Registrations live in `.brain/sessions/live/{sessionId}.json` (gitignored). Peer discovery scans the live directory.

---

## 9. Execution Phases

Every request follows a structured pipeline:

| Phase | Lead | What Happens |
|-------|------|-------------|
| **0: Session Init** | ORCHESTRATOR | Register, poll inbox, discover peers, heartbeat, clean stale sessions |
| **0a: Project Analysis** | ARCHITECT | If no guidelines: read structure, create `.brain/{domain}/memory/guidelines.md` |
| **0b: Task Orchestration** | ORCHESTRATOR ENGINE | If multi-domain or complex: decompose, parallel waves, relay, verify |
| **1: Planning** | PLANNER | Call ARCHIVIST/MEMORY/REVIEWER/DATABASE/ARCHITECT → structured plan → user approval |
| **2: Database** | DATABASE | Schema review, migration safety, index analysis (if needed) |
| **3: Security** | SECURITY | OWASP, STRIDE, CVSS scoring, auth audit (if needed) |
| **4: Execution** | EXECUTOR | Write code, call ARCHIVIST/DATABASE/SECURITY/BACKEND QA/CLEAN CODE/TESTER as needed |
| **5: Backend QA** | BACKEND QA | Clean code → CLEAN CODE, queries → DATABASE, security → SECURITY, tests → TESTER |
| **6: Review** | REVIEWER | Score 1-10, call agents for verification, fix loop (max 3 iterations if score < 7) |
| **7: Testing** | TESTER | 5 modes (API, Flow, DB, Performance, Code Quality), templates-led, all scenarios |
| **8: Memory & Guidelines** | MEMORY SCRIBE + ARCHITECT | Write decisions/lessons/sessions/tests/tasks, update INDEX.md and guidelines |
| **9: GitHub** | GITHUB | Branch, commit, PR (if requested) |
| **10: Summary** | SUMMARY | Professional document with tables, metrics, learning summary |
| **11: Respond** | BRAIN | Summarize done, files changed, review score, memory entries, open questions |

### The Fix Loop

When REVIEWER scores < 7, agents collaborate in a fix loop:

```
REVIEWER score < 7
    │
    ├─► REVIEWER: "SQL injection — call SECURITY"
    │     └─► SECURITY confirms, CVSS 9.1
    │
    ├─► REVIEWER: "Missing indexes — call DATABASE"
    │     └─► DATABASE recommends composite index
    │
    ├─► REVIEWER: "Clean code issues — call CLEAN CODE"
    │     └─► CLEAN CODE extracts service layer
    │
    └─► EXECUTOR fixes remaining issues
    │
    └─► REVIEWER re-scores (max 3 iterations per R45)
```

---

## 10. The Agent Mesh

```
                    ┌───────────────────┐
                    │     ARCHIVIST     │── Read-only knowledge base
                    └────────┬──────────┘
                             │
         ┌───────────────────┼───────────────────┐
         ▼                   ▼                   ▼
   ┌──────────┐       ┌──────────┐       ┌──────────┐
   │ PLANNER  │◄─────►│ EXECUTOR │◄─────►│ REVIEWER │
   └─────┬────┘       └─────┬────┘       └─────┬────┘
         │                  │                  │
         ▼                  ▼                  ▼
   ┌──────────┐       ┌──────────┐       ┌──────────┐
   │  MEMORY  │       │ CLEAN    │       │ BACKEND  │
   │  SCRIBE  │       │ CODE     │       │   QA     │
   └──────────┘       └──────────┘       └────┬─────┘
         │                                    │
         ▼                                    ▼
   ┌──────────┐                       ┌──────────┐
   │  GITHUB  │                       │  TESTER  │
   └──────────┘                       └──────────┘
                                                   ┌──────────────┐
                                          ┌───────┤  SECURITY    │
                                          │       └──────────────┘
                                          │       ┌──────────────┐
                                          ├───────┤  DATABASE    │
                                          │       └──────────────┘
                                          │       ┌──────────────┐
                                          ├───────┤  ARCHITECT   │
                                          │       └──────────────┘
                                          │       ┌──────────────┐
                                          ├───────┤  SUMMARY     │
                                          │       └──────────────┘
                                          │       ┌──────────────┐
                                          ├───────┤GITHUB TASKS │
                                          │       └──────────────┘
                                          │       ┌──────────────┐
                                          └───────┤ ORCHESTRATOR │
                                                  └──────────────┘
                                            ORCHESTRATOR ENGINE (parallel dispatch)
```

Sixteen specialized agents talk to each other through the Brain message broker.

---

## 11. How a Conversation Unfolds

```
User request
    │
    ▼
BRAIN → [Phase 0] ORCHESTRATOR: session init, heartbeat, poll inbox
BRAIN → [Phase 0a] ARCHITECT: read/create guidelines if missing
BRAIN → [Phase 0b] ORCHESTRATOR ENGINE: decompose if multi-domain
    │
    ▼
BRAIN → [Phase 1] PLANNER (starts planning)
    │
    ├─► PLANNER → ARCHIVIST: "What's the current architecture?"
    │     ◄─ ARCHIVIST responds
    ├─► PLANNER → MEMORY: "Any past decisions about this?"
    │     ◄─ MEMORY responds
    ├─► PLANNER → REVIEWER: "Does this design approach look right?"
    │     ◄─ REVIEWER validates
    │
    ◄─ PLANNER produces plan → BRAIN validates → user approves
    │
    ▼
BRAIN → [Phase 4] EXECUTOR (starts building)
    │
    ├─► EXECUTOR → ARCHIVIST: "What columns does the X table have?"
    ├─► EXECUTOR → BACKEND QA: "Review this query mid-write"
    ├─► EXECUTOR → TESTER: "Generate tests for this service"
    ├─► EXECUTOR → CLEAN CODE: "Refactor this controller"
    │
    ◄─ EXECUTOR reports completion
    │
    ▼
BRAIN → [Phase 6] REVIEWER (reviews everything)
    │
    ├─► REVIEWER → BACKEND QA: "Verify these security concerns"
    ├─► REVIEWER → TESTER: "Generate missing edge case tests"
    ├─► REVIEWER → CLEAN CODE: "Fix naming violations"
    │
    ◄─ REVIEWER scores ≥ 7 → passes (or fix loop if < 7)
    │
    ▼
BRAIN → [Phase 8] MEMORY SCRIBE + ARCHITECT (persists everything)
    │
    ├─► MEMORY writes decisions, lessons, session
    ├─► ARCHITECT updates guidelines if architecture changed
    │
    ▼
BRAIN → [Phase 10] SUMMARY (professional summary with tables)
    │
    ▼
BRAIN → [Phase 11] Respond to user
```

---

## 12. How to Add a New Agent

1. Create `.brain/agents/<name>.md`
2. Define purpose, inputs, and structured output schema
3. Define what skills it loads
4. Define which other agents it can call (and who can call it)
5. Add "Who I Can Call" section
6. Register it in the Brain's routing table (`.brain/brain/SYSTEM.md`)
7. Add validation for its output schema
8. Add it to the agent directory in `CLAUDE.md`

## 13. How to Add a New Skill

1. Create skill file — shared: `.brain/shared/skills/<name>.md`, domain: `.brain/{domain}/skills/<name>.md`
2. Describe what the skill teaches and when to use it
3. Keep it to one responsibility
4. Link to related skills
5. Add it to the Skill Trigger Table in `CLAUDE.md` if it maps to a domain signal

## 14. Adding a New Domain

1. Create `.brain/{domain}/` with `plans/`, `rules/`, `skills/`, `memory/` subdirectories
2. Add `README.md` in the domain root
3. Register the domain in `CLAUDE.md`'s DOMAIN ISOLATION section
4. Ensure domain-specific connections/ is added to `.gitignore`
5. Create initial `memory/guidelines.md` via ARCHITECT

## 15. Versioning and Updates

- **Version pinned** in `VERSION`, `CLAUDE.md` header+footer, and `README.md` — all three must match (R30)
- **Incremented before every push**
- **Update via**: `bash .ai/update.sh` or ask the Brain
- **Install into another project**: `curl -fsSL https://raw.githubusercontent.com/rmiyoussef/RAI-Engineering/master/setup.sh | bash`

### Version History

| Version | Focus | Key Additions |
|---------|-------|---------------|
| v0.1 | **Foundation** | Brain, Workflow, Skills, Agents (PLANNER, EXECUTOR, REVIEWER, MEMORY, GITHUB), Templates |
| v0.2 | **Agent Mesh** | Message protocol, agent-to-agent communication, BACKEND QA, TESTER, CLEAN CODE, ARCHIVIST |
| v0.3 | **Rules + Install** | 6 rules files (COMMIT_MESSAGES, ERROR_HANDLING, NAMING, SECURITY, DATABASE, API_DESIGN), setup.sh |
| v0.4 | **Skills expansion** | Shared skills framework, domain-specific skills |
| v1.0 | **Domain isolation** | `.brain/` structure, per-domain subtrees, SECURITY agent, DATABASE agent |
| v1.1 | **Inter-session mesh** | Multi-session protocol, ORCHESTRATOR, session bus |
| v1.2 | **Orchestration engine** | ORCHESTRATOR ENGINE, parallel wave dispatch, R41-R45 |
| v1.3 | **GitHub tasks** | GITHUB TASKS agent, issue-to-delivery pipeline |
| v1.4 | **Skills expansion** | 34 imported shared skills, domain-isolated rules, template-led testing |
| v1.5 | **DevOps rules** | 13 DevOps rules + handbook, SECURITY/API/COMMIT/GIT rule merges |

### Planned

| Version | Focus |
|---------|-------|
| v1.6 | **Memory enhancements** — Memory querying, linking, lifecycle management |
| v1.7 | **Templates expansion** — Project scaffolding, agent templates, skill templates |
| v2.0 | **Stable** — Battle-tested, documented, versioned, with upgrade guides |

---

## 16. Design Principles

1. **Single responsibility.** Every file does one thing. One agent per role.
2. **Agents ask for help, they don't guess.** Unsure about architecture? Call ARCHIVIST. Unsure about a query? Call BACKEND QA.
3. **Delegate, don't duplicate.** Need tests? Delegate to TESTER. Need refactoring? Delegate to CLEAN CODE.
4. **Structured over free-form.** Agents return schemas, not paragraphs.
5. **Validation at boundaries.** The Brain validates every input and output.
6. **Memory is a first-class citizen.** Every decision, every lesson, every architectural change is indexed. Nothing is lost.
7. **Domain isolation.** Backend, Frontend, Mobile, DevOps knowledge never mixes.
8. **Framework-agnostic core with framework-scoped rules.** Patterns in the core, conventions in domain rules.
9. **Parallel by default, serial only when forced.** Maximum throughput, minimum wall-clock.
10. **Versioned product.** RAI-Engineering has releases. Projects pin a version.
11. **Progressive complexity.** Start simple. Add layers as needed.
12. **Reusable across projects.** Nothing exists only because it's useful today.

---

*This document is the source of truth for RAI-Engineering architecture. All implementation must conform to it. Changes to this document require full team consensus.*
