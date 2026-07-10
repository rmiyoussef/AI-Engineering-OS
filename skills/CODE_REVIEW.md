# Code Review Skill

> How to review code like a senior engineer.
> Loaded by the REVIEWER agent and the Brain during the review phase.

---

## When to Use

After any code is written or modified. Run a full review before the code is accepted.

## What to Check

### Correctness
- Does the code do what the plan specified?
- Are edge cases handled? (empty states, null values, boundary conditions)
- Are error paths handled properly?
- Are there race conditions or timing issues?
- Does the logic actually terminate?

### Performance
- Are there N+1 queries?
- Is data loaded eagerly that should be lazy?
- Are there unnecessary allocations or copies?
- Would this code scale to 10x the data?
- Are cache opportunities missed?

### Security
- Are inputs validated and sanitized?
- Are there SQL injection or XSS vectors?
- Are secrets exposed (hardcoded keys, tokens in logs)?
- Are authorization checks present?
- Is user data handled correctly?

### Maintainability
- Is the code readable? Can you understand it without comments?
- Are functions at a single level of abstraction?
- Are names descriptive and honest?
- Is there dead code?
- Would a new developer understand this in 6 months?

### Test Coverage
- Are the right tests present? (unit + integration + edge cases)
- Do tests test behavior, not implementation?
- Are there tests for failure modes?
- Are tests deterministic?

## Scoring Guide

| Score | Meaning | Action |
|-------|---------|--------|
| 1-3 | **Critical issues.** Security vulnerability, data loss, broken core logic | Block. Route back to EXECUTOR. |
| 4-6 | **Major issues.** Wrong approach, missing error handling, no tests | Route back to EXECUTOR. |
| 7-8 | **Minor issues.** Style nits, missed edge case, naming | Flag, accept with notes. |
| 9-10 | **Clean.** No issues found. | Accept immediately. |

## Language

- Be precise. "Line 42: `$user` can be null when the query returns no rows." Not "there might be an issue."
- Be constructive. Every issue should suggest how to fix it.
- Be specific. File + line number for every issue.

## Output Schema

```json
{
  "issues": [
    {
      "file": "path/to/file.php",
      "line": 42,
      "severity": "critical | major | minor",
      "description": "What's wrong and why it matters",
      "suggestion": "How to fix it"
    }
  ],
  "suggestions": [
    {
      "area": "performance | architecture | testing | style",
      "description": "What could be improved and why"
    }
  ],
  "performance": "good | acceptable | concerning | critical",
  "security": "good | acceptable | concerning | critical",
  "score": 8
}
```
