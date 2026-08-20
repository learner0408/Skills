---
name: create-skill
description: Guide the user through creating a well-structured agent skill, from directory setup and frontmatter to instruction writing, bundled resources, and validation. Use when asked to create a new skill, build a reusable agent behavior, or scaffold a SKILL.md from scratch.
---

# Create Skill

Guide the user through the full lifecycle of building a well-structured agent skill.

## How Skills Work

Understanding how skills are loaded helps inform good design. There are three levels:

1. **Metadata** (`name` + `description`) — Always loaded at session startup. The agent uses this to decide whether to load the full skill. This is why the `description` field is the single most critical part of any skill.
2. **Body** (the markdown content after frontmatter) — Loaded into context only when the skill is activated. Keep this focused and concise.
3. **Resources** (`references/`, `scripts/`, `assets/`) — Loaded on-demand only when explicitly referenced in the body. Files here add zero context cost until the agent reads or executes them.

Every token in the body competes with conversation history and other context. Be concise.

## Description Guidelines

The description is the primary triggering mechanism. The agent matches it against the user's request to decide whether to activate the skill.

### Format

```
When [trigger phrases], [action verb] [scope]. Skip if [negative condition].
```

### Rules

- Aim for 200–500 characters (max 1024)
- Include concrete trigger phrases — file types, action verbs, domain keywords, contexts
- Embed anti-triggers directly in the description to prevent false activation
- Write for the agent, not for humans

### Examples

**Good:**
> Use when asked to extract, merge, or annotate PDF files — opening, reading, splitting, rotating, or filling forms. Do NOT trigger for image conversion, document creation from scratch, or OCR tasks.

**Bad:**
> Helps with PDFs

**Good:**
> Review code changes for correctness, security, and maintainability. Use when asked to review a PR, audit a diff, or check for bugs before merging. Skip for style-only feedback or documentation linting.

**Bad:**
> Code review

## Anatomy of a Skill

```
my-skill/
├── SKILL.md              # Core instructions (required, < 500 lines)
├── references/           # Detailed docs loaded on-demand by the agent
│   └── api-guide.md
├── scripts/              # Executable code — run, not loaded into context
│   └── helper.py
└── assets/               # Templates, schemas, output boilerplate
    └── template.json
```

### When to use each resource type

| Type | When to use | Token cost |
|---|---|---|
| `references/` | API docs, schemas, long guides, edge case catalogs | Zero until the agent reads them |
| `scripts/` | Deterministic operations — parsing, validation, formatting | Zero — code never enters context, only output |
| `assets/` | Output templates, starter files, configuration stubs | Zero until the agent reads them |

### Progressive disclosure pattern

Keep SKILL.md under 500 lines. If you approach this limit, branch detail into companion files and give clear pointers on when to read each one.

```
my-analytics-skill/
├── SKILL.md
└── references/
    ├── finance.md     # "Read this when the user mentions revenue data"
    ├── marketing.md   # "Read this when handling campaign metrics"
    └── product.md     # "Read this for feature usage analysis"
```

The agent reads only the relevant reference, not all of them.

## Step-by-Step Instructions

### 1. Choose a name

- Lowercase kebab-case only — `^[a-z0-9]+(-[a-z0-9]+)*$`
- 1–64 characters
- Must match the directory name exactly
- Cannot contain reserved words (check platform docs for your target agent)
- Convention: one clear noun or verb-noun pair — `pdf-processor`, `commit-writer`, `deploy-check`

### 2. Pick a location

| Location | Scope | Use when |
|---|---|---|
| Project dir (`.agent/skills/<name>/` or `.opencode/skills/<name>/`) | Single repo | The skill is specific to this project's conventions |
| Global dir (`~/.config/opencode/skills/<name>/` or `~/.claude/skills/<name>/`) | All sessions | The skill is useful across all your work |

### 3. Create the directory and SKILL.md

```
mkdir -p <location>/<skill-name>
```

Write SKILL.md starting with YAML frontmatter:

```markdown
---
name: my-skill
description: What this skill does and when to use it.
---
```

Only these frontmatter fields are recognized:
- `name` (required)
- `description` (required)
- `license` (optional)
- `compatibility` (optional)
- `metadata` (optional, string-to-string map)

Unknown fields are ignored by the agent, so don't rely on them.

### 4. Write the body

- Use imperative voice — "Create a release", not "You should create a release"
- Number ordered steps when sequence matters
- Include concrete examples — they carry more weight than abstract rules
- Define output format explicitly for predictable results
- Explain *why* something matters rather than relying on heavy-handed MUSTs

```
## Instructions

1. First action to take
2. If [condition], do X; otherwise do Y
3. Final output format

## Examples

Input: "some user request"
Output: expected result
```

### 5. Add optional resources

If the skill has domain variants, organize references by domain and tell the agent when to read each one.

If the skill needs deterministic operations (parsing, validation, generation), write scripts rather than asking the agent to reinvent the logic each time.

If the skill produces predictable outputs, include templates the agent can fill in.

### 6. Validate

Run through the checklist below before declaring the skill ready.

## Scope Discipline

One skill, one verb, one scope.

- If the description uses "or" between distinct actions, it should be multiple skills
- Narrow skills trigger more reliably than broad ones
- If you cannot describe what the skill does in a single sentence, it is too broad

### Signs you need to split

- "Use when the user wants to create a chart OR export data OR generate a report"
- The body has separate instruction sections for unrelated workflows
- Testing shows the skill fires on false positives because the description has to cover too many cases

## Validation Checklist

Before shipping a skill, verify:

### Core quality

- [ ] Name matches the directory name exactly
- [ ] Name is lowercase kebab-case, no underscores or spaces
- [ ] Description includes what the skill does AND when to use it
- [ ] Description includes concrete trigger phrases
- [ ] Anti-triggers included for near-neighbor confusion
- [ ] Description is 200–500 characters (max 1024)
- [ ] SKILL.md body is under 500 lines
- [ ] All file references use forward slashes, relative paths
- [ ] No time-sensitive information (dates, version pins, API specifics)
- [ ] Consistent terminology throughout
- [ ] Concrete examples included, not abstract descriptions
- [ ] Reference files are one level deep from SKILL.md (no nested chains)

### If scripts are included

- [ ] Scripts solve a deterministic problem rather than asking the agent to guess
- [ ] Dependencies are declared in the instructions
- [ ] Error handling is explicit
- [ ] Forward slashes only (no Windows-style paths)

## Testing Guidance

The agent caches the skill index at session start. Edits to SKILL.md take effect only after restarting the session.

### Test procedure

1. Restart the agent session
2. Prepare 3 prompts that should trigger the skill and 3 that should not (near-misses are most valuable)
3. Run each prompt and observe whether the skill activates
4. If a should-trigger prompt fails — broaden the description trigger phrases
5. If a should-not-trigger prompt fires — add tighter anti-triggers
6. Repeat until both categories are clean

### What to check

- Does the skill activate when the user uses synonyms or paraphrases?
- Does the skill stay silent for adjacent but unrelated tasks?
- Does the description work for casual phrasing with typos?

## When NOT to Use This Skill

- The user wants to edit an existing skill — use the target skill directly
- The user is configuring the agent itself (permissions, tools, MCP) — use the platform's own config guidance
- The user needs a one-off answer, not a repeatable behavior package

## Example

Walk through creating a `changelog-generator` skill:

1. Confirm name: `changelog-generator` — kebab-case, matches directory name
2. Location: global — useful across projects
3. Frontmatter:
   ```markdown
   ---
   name: changelog-generator
   description: Generate changelogs from conventional commit history. Use when asked to draft release notes, summarize git log, or create a changelog from recent commits. Skip for one-off commit message generation.
   ---
   ```
4. Body: steps for parsing commits, grouping by type, formatting output, example input/output
5. No bundled resources needed — the skill is self-contained
6. Validate against the checklist above
7. Test with prompts: "write a changelog for the last 10 commits" (should trigger), "explain what this commit does" (should not trigger)
