# Memory System

> How the BRAIN organizes, indexes, and queries project memory.
> Memory is the project's persistent knowledge. It grows with every session.
> Memory lives in `.claude/memory/` — in your project root, not in the AI-Engineering-OS folder.

---

## Memory Layout

```
.claude/memory/
├── INDEX.md                         ← Master index (auto-maintained)
├── guidelines.md                    ← Project structure & conventions
├── decisions/                       ← Architecture decisions
│   └── 2026-07-10-jwt-auth.md
├── architecture/                    ← Component maps
│   └── auth-system.md
├── lessons/                         ← Things learned
│   └── 2026-07-10-n-plus-one-fix.md
├── sessions/                        ← Every interaction, task, discussion
│   ├── 2026-07-10-implement-auth.md
│   └── 2026-07-10-discussion-api-design.md
├── business/                        ← Business rules
│   └── two-factor-auth.md
└── connections/                     ← Database connections ⚠️ GITIGNORED
    └── database.md
```

### Why `.claude/memory/`?

| Reason | Explanation |
|--------|-------------|
| **Persistence** | Claude Code reads `.claude/` automatically. Memory persists across sessions. |
| **Clean project root** | No extra `memory/` folder cluttering your project. |
| **Standard location** | `.claude/` is the standard Claude Code directory. |
| **Git safety** | Can be gitignored or committed per-project. |

### Session Entry — Every Interaction

**Every single interaction** — task, discussion, question, exploration — must write a session entry. This ensures:

- If you close the terminal, you can resume exactly where you left off
- Nothing is lost between sessions
- The BRAIN reads past sessions before starting new work
- Continuity is maintained across days

A session entry is written after:
- ✅ Completing a task
- ✅ Having a design discussion
- ✅ Exploring the codebase
- ✅ Answering a question
- ✅ Making any decision
- ✅ Any interaction that produced value

### guidelines.md

The `.claude/memory/guidelines.md` file holds the project's architecture, conventions, commands, middleware, database rules, and security setup. Created by ARCHITECT on first install using `templates/GUIDELINES.md`.

See `agents/ARCHITECT.md` for how guidelines are managed.

### Git Safety

| Path | Committed? | Why |
|------|-----------|-----|
| `.claude/memory/decisions/` | ✅ Recommended | Architecture decisions are project knowledge |
| `.claude/memory/architecture/` | ✅ Recommended | Component maps are part of the project |
| `.claude/memory/lessons/` | ✅ Recommended | Lessons benefit the whole team |
| `.claude/memory/sessions/` | ✅ Recommended | Session history helps resume work |
| `.claude/memory/business/` | ✅ Recommended | Business rules are project knowledge |
| `.claude/memory/guidelines.md` | ✅ Recommended | Project structure is shared knowledge |
| `.claude/memory/INDEX.md` | ✅ Recommended | Master index helps everyone navigate |
| `.claude/memory/connections/` | ❌ **Never** | Contains schema info — never push secrets |

---

## INDEX.md — The Master Index

The `.claude/memory/INDEX.md` file is the **entry point for all memory queries**. Auto-maintained by MEMORY SCRIBE after every session.

### Format

```markdown
# Memory Index

> Auto-maintained. Last updated: 2026-07-10

## Active Decisions
- [JWT Authentication](decisions/2026-07-10-jwt-auth.md) — Using JWT over session auth

## Architecture
- [Auth System](architecture/auth-system.md) — Login, register, password reset

## Lessons
- [N+1 Query Fix](lessons/2026-07-10-n-plus-one-fix.md) — Eager loading posts

## Sessions
- [Implement JWT Auth](sessions/2026-07-10-implement-auth.md) — Completed score 9/10
```

### How it's maintained

After every session, MEMORY SCRIBE calls:
```
MEMORY SCRIBE: "I need to update INDEX.md"
  ├─► List files in .claude/memory/decisions/ → add new ones
  ├─► List files in .claude/memory/lessons/ → add new ones
  ├─► List files in .claude/memory/sessions/ → add new ones
  └─► List files in .claude/memory/architecture/ → add new ones
```

---

## Memory Flow

### Before Any Work

```
BRAIN receives task
    │
    ├─► Read .claude/memory/INDEX.md       ← What does the project know?
    ├─► Read .claude/memory/guidelines.md  ← Project conventions
    ├─► Read .claude/memory/decisions/     ← Past decisions
    ├─► Read .claude/memory/architecture/  ← Current component map
    ├─► Read .claude/memory/lessons/       ← Known pitfalls
    └─► Read .claude/memory/connections/   ← Database schema (if needed)
```

### After Any Work (Always)

```
Task/Discussion/Question complete — ALWAYS write session
    │
    ├─► MEMORY SCRIBE writes session/      ← WHAT happened (ALWAYS)
    ├─► MEMORY SCRIBE writes decisions/    ← WHAT was decided (if applicable)
    ├─► MEMORY SCRIBE writes lessons/      ← WHAT was learned (if applicable)
    ├─► ARCHITECT updates guidelines/      ← Did architecture change?
    └─► MEMORY SCRIBE updates INDEX.md     ← Keep index in sync
```

---

## Session Entry — Written After EVERY Interaction

This is the most important rule. Every interaction writes a session entry.

### Session File Format

```markdown
# Session: 2026-07-10 - Discussion about API Design

**Date:** 2026-07-10
**Type:** Task | Discussion | Exploration | Question
**Duration:** ~15 min

## Context
What prompted this session.

## What Happened
Summary of the conversation, decisions, findings.

## Key Takeaways
- Point 1
- Point 2

## Files Referenced
- path/to/file.php

## Next Steps
- [ ] Action item 1
- [ ] Action item 2

## Related
- See also: [[decisions/past-decision.md]]
```

---

## Memory Entry Format

### Decision File

```markdown
# Decision: {{title}}

**Date:** {{date}}
**Context:** {{why this decision was needed}}

## Options Considered
- Option A: {{pros/cons}}
- Option B: {{pros/cons}}

## Decision
**Chosen:** {{option}}
**Rationale:** {{why}}

## Consequences
- {{what this enables}}
- {{what this constrains}}

## Related
- See also: [[decisions/past-decision.md]]
- Affects: {{files/components}}
```

### Lesson File

```markdown
# Lesson: {{title}}

**Date:** {{date}}
**What:** {{what happened}}
**Impact:** {{low | medium | high}}
**Root Cause:** {{why it happened}}
**Prevention:** {{how to avoid in future}}
**Applies to:** {{files/patterns}}
```

---

## How Agents Use Memory

| Agent | Reads | Writes |
|-------|-------|--------|
| **BRAIN** | INDEX.md, guidelines.md — before any task | Creates session UUID |
| **PLANNER** | decisions/, architecture/, guidelines.md | Nothing — passes to MEMORY SCRIBE |
| **ARCHITECT** | guidelines.md, architecture/ | guidelines.md |
| **EXECUTOR** | architecture/, connections/ | Nothing — passes to MEMORY SCRIBE |
| **REVIEWER** | decisions/ (for precedent) | Nothing — passes to MEMORY SCRIBE |
| **BACKEND QA** | architecture/ | Nothing — passes to MEMORY SCRIBE |
| **DATABASE** | connections/ | connections/ (schema only) |
| **SECURITY** | architecture/ | Nothing — passes to MEMORY SCRIBE |
| **TESTER** | Nothing specific | test files |
| **MEMORY SCRIBE** | All stores (to build index) | decisions/, lessons/, sessions/, INDEX.md |
| **GITHUB** | decisions/, INDEX.md | Nothing |

---

## Template

Use `templates/MEMORY_DECISION.md` for decision entries.
