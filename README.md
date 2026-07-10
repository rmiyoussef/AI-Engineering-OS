# AI Engineering OS

**An operating system for AI software engineering.**

Instead of behaving like a chatbot, the AI behaves like an **engineering organization** — with specialized agents that plan, build, review, test, audit, and remember.

```
curl -fsSL https://raw.githubusercontent.com/rmiyoussef/AI-Engineering-OS/master/setup.sh | bash
```

---

## Why?

Most AI coding assistants behave like chatbots — they answer questions, write code on demand, and forget everything between sessions.

AI Engineering OS is different. It turns your AI into a **disciplined engineering team** that:

- **Understands architecture** before touching code
- **Plans** every change before writing it
- **Maintains project memory** — decisions, lessons, architecture
- **Reviews its own work** for quality, security, and performance
- **Writes tests** with realistic mock data
- **Tracks decisions** so nothing is forgotten
- **Learns project architecture** over time
- **Optimizes continuously** through self-review loops
- **Can be installed** into any repository, any framework

---

## How It Works

The system is built around **9 specialized agents** that talk to each other through the **Brain** (a message broker).

### The Agent Mesh

```
                    ┌───────────────────┐
                    │     ARCHIVIST     │── Knowledge base (reads files)
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
```

### The Agents

| Agent | Role | What It Does |
|-------|------|-------------|
| **PLANNER** | Architect | Produces structured plans before any code is written. Lists affected files, risks, dependencies. |
| **ARCHIVIST** | Librarian | Reads your codebase and answers questions. "What's in the User model?" "What does AuthController do?" |
| **EXECUTOR** | Builder | Writes code following the plan. Creates/modifies files, runs linters. |
| **CLEAN CODE** | Refactorer | Fixes SOLID violations, naming, duplication. Extracts services from fat controllers. Never changes behavior. |
| **BACKEND QA** | Auditor | Deep backend audit: clean code, query optimization (N+1 detection), security (injection, auth, CSRF), test quality. |
| **TESTER** | Test specialist | Generates tests, fixes brittle tests, ensures coverage. Uses factories, covers edge cases. |
| **REVIEWER** | Inspector | Scores code 1-10. Checks correctness, performance, security, maintainability. Manages the fix loop. |
| **MEMORY SCRIBE** | Historian | Writes decisions, lessons, architecture changes to persistent memory. |
| **GITHUB** | Integrator | Creates branches, commits, and pull requests with full documentation. |

### How They Talk to Each Other

Agents don't wait for a pipeline. They **ask each other for help** in real-time:

```
PLANNER needs schema info          → calls ARCHIVIST
EXECUTOR writes a complex query    → consults BACKEND QA mid-write
EXECUTOR needs tests               → delegates to TESTER
REVIEWER finds code quality issues → delegates to CLEAN CODE
REVIEWER needs security audit      → consults BACKEND QA
BACKEND QA finds missing tests     → delegates to TESTER
MEMORY SCRIBE needs session data   → calls PLANNER, EXECUTOR, REVIEWER
GITHUB needs PR body               → calls EXECUTOR, REVIEWER, TESTER
```

### The Fix Loop

When code doesn't pass review, the fix loop isn't a simple retry — agents collaborate:

```
REVIEWER scores 6/10
    │
    ├─► REVIEWER: "3 issues found"
    │     ├─► BACKEND QA confirms SQL injection risk
    │     ├─► CLEAN CODE refactors fat controller
    │     └─► TESTER generates missing edge case tests
    │
    └─► REVIEWER re-scores 9/10 → passes
```

---

## Quick Start

### Install into Any Project

```bash
cd /path/to/your-project
curl -fsSL https://raw.githubusercontent.com/rmiyoussef/AI-Engineering-OS/master/setup.sh | bash
```

This creates:

```
your-project/
├── CLAUDE.md → .ai/CLAUDE.md     ← The Brain (loaded automatically by Claude Code)
├── .ai/                          ← AI Engineering OS
│   ├── brain/                    ← System definitions
│   ├── agents/                   ← Agent roles
│   ├── skills/                   ← Domain knowledge
│   ├── rules/                    ← Engineering rules
│   ├── templates/                ← Memory templates
│   └── workflows/                ← Workflow references
└── memory/                       ← YOUR project memory (grows over time)
    ├── decisions/
    ├── architecture/
    ├── lessons/
    ├── sessions/
    └── business/
```

### Update

```bash
bash .ai/update.sh
```

Or just ask: *"Update AI Engineering OS"*

### Use It

```bash
cd /path/to/your-project
claude
```

Then give it a task:

- *"Show me the structure of this project"*
- *"Add validation to the UserController"*
- *"Review the code quality of the auth system"*
- *"Generate tests for the OrderService"*
- *"Create a new API endpoint for user profiles"*

---

## Project Memory

Every decision, lesson, and architecture change is saved to `memory/`. Over time, your project grows a persistent knowledge base:

```
memory/
├── decisions/               ← Architecture decisions with rationale
│   └── 2026-07-10-jwt-auth.md
├── architecture/            ← Component maps
│   └── auth-system.md
├── lessons/                 ← Things learned
│   └── 2026-07-10-n-plus-one-fix.md
├── sessions/                ← Session summaries
│   └── 2026-07-10-implement-auth.md
└── business/                ← Business rules and domain glossary
```

The Brain reads this before every session so nothing is forgotten.

---

## Rules

When installed, your project gets access to domain-agnostic engineering rules:

| Rule File | Covers |
|-----------|--------|
| `rules/COMMIT_MESSAGES.md` | Conventional commit format, types, scopes |
| `rules/ERROR_HANDLING.md` | Exceptions, logging, fail-fast, HTTP codes |
| `rules/NAMING_CONVENTIONS.md` | Classes, methods, variables, tests naming |
| `rules/SECURITY.md` | Input validation, SQL injection, XSS, CSRF, auth |
| `rules/DATABASE.md` | Migrations, indexing, N+1, pagination, constraints |
| `rules/API_DESIGN.md` | RESTful URLs, consistent responses, versioning |

Rules are loaded automatically based on what the task touches.

---

## Skills

| Skill | When Used |
|-------|-----------|
| `skills/CODE_REVIEW.md` | Reviewing code |
| `skills/TESTING.md` | Writing or reviewing tests |
| `skills/GIT.md` | Committing, branching, PRs |
| `skills/MEMORY.md` | Writing to project memory |
| `skills/BACKEND_ENGINEERING.md` | Backend QA audit or query work |

---

## Architecture

The full architecture specification is in [docs/architecture.md](docs/architecture.md).

Key design decisions:

- **The Brain is a message broker.** It routes messages between agents — it never writes code.
- **Agents ask for help.** Unsure about architecture? Call ARCHIVIST. Unsure about a query? Call BACKEND QA.
- **Structured outputs.** Every agent returns a defined schema, not free-form text.
- **Memory is project-specific.** The OS provides the interface; `memory/` lives in your project.
- **Framework-agnostic.** The OS knows engineering patterns; domain knowledge lives in Skills.
- **Model-locked.** All agents run on `deepseek-v4-flash`. No exceptions.

---

## Version Roadmap

| Version | Focus | Status |
|---------|-------|--------|
| v0.1 | **Foundation** — Brain, agents, skills, workflow | ✅ Done |
| v0.2 | **Agent Mesh** — message broker, agent-to-agent communication | ✅ Done |
| v0.3 | **Rules + Install** — 6 rule files, .ai/ convention, setup.sh | ✅ Done |
| v0.4 | **Skills expansion** — framework skills (Laravel, React, SQL) | 🔲 Planned |
| v0.5 | **Memory enhancements** — querying, linking, lifecycle | 🔲 Planned |
| v0.6 | **GitHub release workflow** — changelog, semantic versioning | 🔲 Planned |
| v0.7 | **Templates expansion** — project scaffolding | 🔲 Planned |
| v0.8 | **Install script improvements** — flags, customization | 🔲 Planned |
| v1.0 | **Stable** — battle-tested, documented, versioned | 🔲 Planned |

---

---

<div align="center">
  <br>
  <sub>
    Built with ❤️ by
    <a href="https://github.com/rmiyoussef">
      <b>Rami Youssef</b>
    </a>
    <br>
    <small>AI Engineering OS — v0.4</small>
  </sub>
  <br>
</div>

---

## Development

To work on AI Engineering OS itself:

```bash
git clone git@github.com:rmiyoussef/AI-Engineering-OS.git
cd AI-Engineering-OS
```

The `CLAUDE.md` in the root is the **development version** (loads from `./`).
The `CLAUDE.install.md` is the **installable version** (loads from `.ai/`).

---

## License

MIT
