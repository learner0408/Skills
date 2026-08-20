---
name: architecture-driven-coding
description: >
  Use when asked to implement, build, add, or write NEW code and features.
  Verifies ARCHITECTURE.md exists at the project root first — if missing,
  stops and asks the user to create it before any code is written. Enforces
  CONVENTIONS.md. Skip for fixing bugs or debugging existing code, refactoring,
  config or file edits, docs-only work, scratch code, or when the user
  explicitly says to skip architecture.
---

## Instructions

1. **Read conventions** — project-local `CONVENTIONS.md` if present, else `~/.config/opencode/CONVENTIONS.md`
2. **Locate `ARCHITECTURE.md`** at the project root (walk up from the current directory if needed)
3. **If missing** — STOP. Do not write any code. Follow "Stop and Ask" below
4. **Read and internalize** `ARCHITECTURE.md` before writing anything
5. **Map the request to the architecture** — identify the modules, files, and data flow the feature touches; state the file-by-file plan before editing
6. **Write the code** conforming to both `ARCHITECTURE.md` and `CONVENTIONS.md`
7. **Basic syntax verification** — run `scripts/syntax-check.sh` on every file you wrote; fix anything it flags
8. **Report** — list files created/modified and note any deviation from the architecture

## Stop and Ask

- If `ARCHITECTURE.md` is missing, halt immediately. Explain that code is not written until the architecture exists, present `references/architecture-template.md`, and ask the user to create or approve the architecture first
- If a request maps ambiguously to a module, or the architecture does not cover it, ask before inventing structure
- Never design architecture on the fly — the project's architecture file is the only source of truth

## Out of Scope

- Fixing bugs, debugging, or repairing existing code
- Refactoring
- Detailed test-case verification (handled by a separate skill)
- Config edits, docs-only changes, scratch scripts

## Example

Input: "Add a user profile page that shows account settings."
With `ARCHITECTURE.md` present: map to the `frontend/user` module, plan
`pages/settings.tsx`, `components/ProfileForm.tsx`, `api/user.ts`, then write
each file and run `scripts/syntax-check.sh` on them.

Without `ARCHITECTURE.md`: stop, present the template, ask the user to write
it first, and write nothing.