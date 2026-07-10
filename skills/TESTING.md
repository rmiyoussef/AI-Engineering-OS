# Testing Skill

> How to test software effectively.
> Loaded by the EXECUTOR and REVIEWER agents.

---

## When to Use

During execution (writing tests) and review (evaluating test quality).

## Principles

1. **Test behavior, not implementation.** Your test should pass after a refactor that doesn't change visible behavior.
2. **One assertion concept per test.** A test should fail for one reason, making debugging instant.
3. **Arrange-Act-Assert.** Structure every test: set up, execute, verify.
4. **Test the boundary conditions.** Empty, null, max, min, error — not just the happy path.
5. **Tests are code too.** They should be clean, readable, and maintained.

## What to Write

### Unit Tests
- Test one function/class in isolation
- Mock dependencies
- Focus on logic and edge cases

### Integration Tests
- Test components working together
- Use real databases/filesystems where practical
- Cover the critical paths

### Feature/End-to-End Tests
- Test user-facing behavior
- Cover the main workflow
- Fewer, broader, slower

## Coverage Goals

| Area | Minimum Coverage |
|------|-----------------|
| Core business logic | 90%+ |
| API endpoints | 80%+ |
| Error handling | 90%+ |
| UI components | 70%+ |
| Configuration | 60%+ |

## Patterns to Avoid

- **Testing the framework.** Don't test that Laravel's QueryBuilder works. Test that your query logic is correct.
- **Brittle selectors.** Don't use CSS class names in feature tests. Use data attributes or text content.
- **Slow tests.** A unit test should take milliseconds. If it takes seconds, it's an integration test.
- **Shared mutable state.** Tests should not depend on each other or on execution order.
- **Snapshot-heavy.** One snapshot per test maximum. Prefer explicit assertions.
