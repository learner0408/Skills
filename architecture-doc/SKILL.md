---
name: architecture-doc
description: |
  When asked to set up or write a project's architecture document — produce a
  project-root ARCHITECTURE.md by first grilling the user on the architecture
  decisions. Use for "write the architecture doc", "create an ARCHITECTURE.md",
  "settle the project structure", or planning a new codebase's layout. Skip for
  fixing bugs, reviewing existing docs, or writing code.
---

## Instructions

1. **Load the grilling skill** with the Skill tool and apply its discipline:
   ask one question at a time, give a recommended answer for each decision, look
   up facts from the environment instead of asking, and do not write anything
   until the user confirms shared understanding.
2. **Scan the project first** — working directory, project root, any existing
   `CONVENTIONS.md`, `README.md`, `package.json`, or config files. Extract facts
   yourself; grill only on decisions.
3. **Walk the decision tree** below, in order. Ask one question at a time and
   wait for each answer before continuing. For every question, provide your
   recommended answer.
4. When the user confirms shared understanding, write `ARCHITECTURE.md` to the
   project root using the format in `assets/architecture-template.md`.

## Decision tree (grill topics)

Grill the user on each topic. Sections 6 and 7 are optional — only walk them if
applicable; otherwise confirm they don't apply and move on.

1. **Overview** — what the system does, its goals and non-goals
2. **Tech stack** — language, framework, key libraries, tooling, versions
3. **Directory structure** — layout style (feature-based, layered) and rationale
4. **Module / component breakdown** — how responsibility splits across modules
5. **Data flow** — how data moves between modules and layers
6. **Contracts & interfaces** (optional) — only when cross-module or external
   contracts are worth pinning down
7. **Boundaries & rules** (optional) — only when the architecture enforces hard
   rules, e.g. "UI never queries the database"
8. **Conventions reference** — which `CONVENTIONS.md` applies and any deviations
   (read from the filesystem, don't grill unless ambiguous)
9. **Open questions** — record anything left unresolveable at write time

## Output rules

- Follow the section order and headings in `assets/architecture-template.md`
  exactly — the coding skill reads this file to map features to modules, so
  heading names must stay stable
- Sections 1–5, 8, and 9 are mandatory
- Sections 6 and 7 are optional — omit them entirely if not applicable; no empty stubs
- If `ARCHITECTURE.md` already exists, read it first, then grill, then rewrite
- Report afterwards: where the file lives, and which sections were omitted as
  not applicable

## Example

Input: "Write the architecture doc for our new analytics platform."

1. Load the grilling skill via the Skill tool.
2. Scan the repo — read `README.md`, `CONVENTIONS.md`, `package.json`.
3. Grill one question at a time, each with a recommendation:
   "What does the platform do at its core?" (→ track events, run dashboards) —
   "Recommended stack?" (→ Next.js + ClickHouse) — wait for each answer.
4. Once understanding is confirmed, write `ARCHITECTURE.md` at the project root
   — all 9 sections filled, except 6/7 which are omitted if the user says no
   external contracts or hard boundaries exist.

## Out of scope

- Editing an existing architecture doc in place — edit `ARCHITECTURE.md` directly
- Writing code per an architecture — the architecture-driven-coding skill enforces it
- Reviewing a doc you did not produce