---
name: test-case-writer
description: >
  Write test files for newly written code and features, run them, and report
  results. Use when asked to add tests, cover code with test cases, or write
  unit/integration tests after implementing code. Skip for reviewing existing
  tests, debugging failures, fixing code, or test plans without code.
---

## Instructions

1. **Read conventions** — project-local `CONVENTIONS.md` if present, else
   `~/.config/opencode/CONVENTIONS.md`. Read `ARCHITECTURE.md` at the project
   root if it exists and map the target code to its modules.
2. **Determine the test framework** — from CONVENTIONS.md, or inspect
   `package.json` / config files (e.g. `vitest.config.ts`, `jest.config.js`,
   Playwright configs). Match the existing project layout: co-located
   `*.test.ts` files or a `__tests__/` directory, whichever is already used.
3. **Choose the scope** — default to code that was just written: new files,
   the recent diff, or explicitly named functions. Use full-scope only when the
   user asks.
4. **Grill ONLY when necessary** — resolve the test target, mocking strategy,
   and unit-vs-integration split from the code and config first. If they cannot
   be determined, load the grilling skill and ask the minimal number of
   questions needed. Otherwise decide from evidence and note the reasoning in
   the report. Do not grill for its own sake.
5. **Write the tests** — unit tests for pure logic and isolated functions;
   integration tests where components interact. Use the project's patterns and
   mocks. Cover normal paths, edge cases, and failure cases.
6. **Execute the tests** — run them with the project's test command scoped to
   the new files. Record which pass and which fail.
7. **Report, do not fix** — output the report below. Do not modify or patch the
   code under test. Suggested fixes are handed to the coding agent to implement.

## Output Format

```
## Test Summary
- Files written: [paths]
- Framework: [name + version]
- Scope: [newly written code | full project]
- Tests added: [count]

## Results
- Passing: [count] — [name or file list]
- Failing: [count] — [name or file list]

## Suggested Fixes (for coding agent)
### [Failed test / file]
- **File**: path/to/file.ts:42
- **Failure**: error message or assertion
- **Suggested fix**: what to change and why
```

## Example

Input: "write tests for the new billing module"
With a backend using Vitest and `src/billing/` just added:
- target `src/billing/*.ts`, co-located `*.test.ts`
- tests covering `createInvoice`, `applyDiscount`, edge cases (negative totals,
  missing customer), failure path (payment declined)
- run `npx vitest run src/billing`
- report passing/failing counts and hand suggested fixes to the coding agent

## Out of scope

- Fixing or patching the code under test — suggested fixes go in the report for
  the coding agent to apply
- Reviewing or debugging existing tests the skill did not write
- E2E authoring unless explicitly requested
- Test plan documents without test files