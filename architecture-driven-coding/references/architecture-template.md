# Architecture: <project name>

Fill this in before code is written. The coding agent reads this file to map
features to modules, so keep section names stable and entries concrete.

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

## 6. Contracts & Interfaces
The APIs, function interfaces, and data shapes each module exposes to others.

## 7. Boundaries & Rules
What each module MAY and MAY NOT do, e.g. "UI never queries the database".

## 8. Conventions Reference
Pointer to CONVENTIONS.md and any project-specific deviations.

## 9. Open Questions
Anything undecided that must be resolved before this architecture is complete.