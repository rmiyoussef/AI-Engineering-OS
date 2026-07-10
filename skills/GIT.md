# Git Skill

> How to manage code with Git.
> Loaded by the EXECUTOR and GITHUB agents.

---

## When to Use

During execution (committing changes), during GitHub operations (branching, PRs).

## Conventions

### Branching
```
main           → production-ready code
feat/<name>    → new features
fix/<name>     → bug fixes
refactor/<name> → code restructuring
docs/<name>    → documentation changes
chore/<name>   → maintenance, dependencies, tooling
```

### Commit Messages
Use conventional commits:

```
type(scope): short description

Longer explanation if needed. Wrap at 72 characters.

- Bullet points for context
- Reference issues: #123
```

| Type | When |
|------|------|
| `feat` | New feature |
| `fix` | Bug fix |
| `refactor` | Code change with no behavior change |
| `docs` | Documentation only |
| `test` | Adding or fixing tests |
| `chore` | Maintenance, deps, config |
| `perf` | Performance improvement |
| `style` | Formatting, linting |

### PRs
- Title: `type(scope): description`
- Body: What, Why, How, Testing, Screenshots (if UI)
- Labels: `breaking`, `bug`, `enhancement`, `dependencies`
- Auto-close issues: `Closes #123`

## Workflow

```
feat/user-auth
  ↓
git add <files>
git commit -m "feat(auth): add user registration"
  ↓
git push -u origin feat/user-auth
  ↓
gh pr create --fill
```
