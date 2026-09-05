# Skills

A collection of agent skills — reusable instruction packages that extend the agent with specialized workflows.

## Skills

| Skill | Purpose | Example trigger |
|---|---|---|
| [`product-builder`](product-builder/) | Orchestrator that builds a feature or product end-to-end by chaining all skills below | "build this feature end-to-end" |
| [`architecture-doc`](architecture-doc/) | Creates project-root `ARCHITECTURE.md` by grilling the user on architecture decisions first | "write the architecture doc" |
| [`architecture-driven-coding`](architecture-driven-coding/) | Enforces `ARCHITECTURE.md` and `CONVENTIONS.md` when implementing new code; refuses to code without an architecture | "add a user profile page" |
| [`test-case-writer`](test-case-writer/) | Writes test files for new code, executes them, and reports results + suggested fixes (never patches code itself) | "write tests for the billing module" |
| [`code-reviewer`](code-reviewer/) | Structured reviews for correctness, security, maintainability, and convention adherence | "review this PR" |
| [`create-skill`](create-skill/) | Guides building well-structured agent skills, from frontmatter to validation | "create a skill for X" |
| [`grilling`](grilling/) | Relentless one-question-at-a-time decision stress-testing; used by other skills to clarify decisions | "grill me on this plan" |
| [`recruiter-outreach`](recruiter-outreach/) | Generates a concise, JD-tailored recruiter DM + email from a JD link or pasted JD | "write a LinkedIn DM for this JD https://..." |

## Pipeline

`product-builder` composes the lifecycle skills:

```
Setup gate ──▶ Implement ──▶ Test ──▶ Fix loop (≤3) ──▶ Review ──▶ Report
   │              │            │           │               │
architecture-  architecture- test-case- architecture-  code-reviewer
doc            driven-coding writer     driven-coding
```

Architecture-touching changes during fix rounds halt for human approval before proceeding.

## Installation

Copy any skill folder into the opencode global config, then restart the session:

```bash
cp -R <skill-name> ~/.config/opencode/skills/<skill-name>
```

Skills are indexed at session startup; edits take effect after a restart.

## Layout

```
skills/
├── AGENTS.md                     # Agent instructions for this repo
├── product-builder/SKILL.md
├── architecture-doc/
│   ├── SKILL.md
│   └── assets/architecture-template.md
├── architecture-driven-coding/
│   ├── SKILL.md
│   ├── references/architecture-template.md
│   └── scripts/syntax-check.sh
├── test-case-writer/SKILL.md
├── code-reviewer/SKILL.md
├── create-skill/SKILL.md
├── grilling/SKILL.md
└── recruiter-outreach/
    ├── SKILL.md
    ├── assets/profile.md
    ├── assets/message-template.md
    └── references/personalization-guide.md
```

## License

See [LICENSE](LICENSE).
