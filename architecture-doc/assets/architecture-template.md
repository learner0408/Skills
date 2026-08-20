# Architecture: <project name>

> Created by the `architecture-doc` skill. Section names must stay stable — the
> coding agent reads this file to map features to modules.

## 1. Project Overview
One-paragraph description of what the system does and its goals.

## 2. Tech Stack
Language, framework, key libraries, tooling, and versions.

## 3. Directory Structure
The intended folder layout (feature-based, layered, etc.) with a one-line note
on what lives where.

```
src/
├── features/
│   └── user/
├── shared/
└── core/
```

## 4. Module / Component Breakdown
For each module: name, responsibility, and key files.

| Module | Responsibility | Files |
|---|---|---|
| user | Account data, auth flows | `features/user/{api,components,pages}/...` |
| billing | Payment and invoices | `features/billing/...` |

## 5. Data Flow
How data moves between modules. Mark each flow `[Input] → [Step] → [Output]`.

- `[Profile form] → [user/api.ts] → [POST /api/v1/users/:id] → [updated row]`

## 6. Contracts & Interfaces (optional)
The APIs, function interfaces, and data shapes each module exposes to others.
Only include if the project has cross-module or external contracts worth
pinning down. Delete this section if not applicable.

## 7. Boundaries & Rules (optional)
What each module MAY and MAY NOT do, e.g. "UI never queries the database".
Only include if the architecture enforces hard boundaries. Delete this section
if not applicable.

## 8. Conventions Reference
Pointer to CONVENTIONS.md (project-local, else `~/.config/opencode/CONVENTIONS.md`)
and any project-specific deviations.

## 9. Open Questions
Anything undecided at write time that must be resolved before this architecture
is final.