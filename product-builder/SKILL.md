---
name: product-builder
description: >
  Orchestrate building a feature or software product end-to-end — from
  architecture decisions through implementation, automated testing, and code
  review. Use when asked to build a product or feature from idea to working,
  tested code, e.g. "build this product" or "implement end-to-end". Skip for
  single-stage requests like writing only tests, only reviewing code, or only
  drafting an architecture doc.
---

## Skills Used

This skill orchestrates other skills. Invoke each by name with the Skill tool
at the matching stage — do not reimplement their behavior inline.

| Stage | Skill |
|---|---|
| Architecture doc | `architecture-doc` |
| Implementation | `architecture-driven-coding` |
| Test writing + execution | `test-case-writer` |
| Code review | `code-reviewer` |
| Ambiguity resolution | `grilling` |

## Instructions

1. **Setup gate** — locate the project root (walk up from the current
   directory). If `ARCHITECTURE.md` is missing, invoke `architecture-doc` to
   create it first. Verify `CONVENTIONS.md` exists (project-local, else
   `~/.config/opencode/CONVENTIONS.md`); if neither exists, halt and ask the
   user before proceeding.
2. **Feature intake** — split the request into an ordered list of features.
   Order them by dependency (data models before API before UI). If ordering is
   genuinely ambiguous after reading `ARCHITECTURE.md`, invoke `grilling` for
   the minimal questions; otherwise decide and state your reasoning.
3. **Run the pipeline per feature**, in order:

   - **Implement** — invoke `architecture-driven-coding` with the feature
     request
   - **Test** — invoke `test-case-writer` scoped to the code just written;
     collect its results report
   - **Fix loop** — see rules below
   - **Review** — invoke `code-reviewer` on the feature's full diff; handle
     findings per the fix-loop rules
4. **Final report** — output the summary in the format below after all
   features are processed.

## Fix Loop

Every fix round routes through exactly two skills, in this order:
`architecture-driven-coding` (apply fixes) → `test-case-writer` (re-run scoped
tests). Never patch code directly yourself.

Budget: **3 rounds** for test failures, then **1 round** for review findings.
Exhausted → mark the feature blocked and continue to the next feature.

### Architecture deviation gate

Before applying any fix round, classify each suggested fix:

- **Local fixes** — logic bugs, missing edge cases, wrong mocks, errors
  confined within existing modules → apply autonomously
- **Architecture-touching fixes** — new or renamed modules, changed data flow,
  boundary/contract changes, tech stack adjustments → STOP. Present to the
  human: the failing test or review finding, the proposed architectural
  change, and why it is needed. Proceed only on explicit approval. On
  rejection, record the feature as blocked-by-architecture-rejection and move
  on

The same gate applies during implementation if `architecture-driven-coding`
reports the request cannot be mapped to existing modules.

## Autonomy Rules

- No pauses between stages — run straight through
- Stop only at: architecture gates (setup + deviations), budget exhaustion,
  user interrupt
- Blocked features never block later independent features

## Output Format

```
## Build Report

### [Feature name] — [done | blocked-by-budget | blocked-by-architecture-rejection]
- Files written: [paths]
- Tests added/passed/failed: [n/n/n]
- Review outcome: [clean | issues fixed | open Medium/Low items]
- Architecture deviations: [none | approved: <change> | rejected: <change>]
- Notes: [deviations from plan, leftover risks]
```

## Example

Input: "Build our analytics platform: event ingestion first, then dashboards."

1. Setup gate — no `ARCHITECTURE.md`; invoke `architecture-doc`, user confirms
   stack and modules.
2. Intake — two features ordered: ingestion, then dashboards (dashboards read
   what ingestion writes).
3. Feature 1: implement via `architecture-driven-coding`; test via
   `test-case-writer`; one failure needs a new shared module → deviation gate
   stops, user approves, fix applied via the coding skill, tests re-run green;
   review via `code-reviewer`, one High issue fixed through the same two-skill
   route.
4. Feature 2 runs clean end-to-end.
5. Output the build report covering both features.

## Out of Scope

- Deployment and git commits unless explicitly requested
- Modifying pre-existing code outside the current feature's modules
- E2E authoring unless explicitly requested
- Changing the behavior of the sub-skills — follow them as written