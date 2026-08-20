---
name: code-reviewer
description: >
  Review code changes for correctness, security, maintainability, and adherence
  to project conventions. Use when asked to review code, audit a diff, or check
  for bugs before merging. Skip for style-only feedback, documentation linting,
  general code questions without a review request, or generating new code.
---

## Instructions

1. Read `~/.config/opencode/CONVENTIONS.md` for project conventions
2. Review the provided code/diff for:
   - **Correctness** — logic errors, edge cases, regressions
   - **Security** — injection, secrets in code, auth bypass, input validation
   - **Maintainability** — complexity, readability, duplication
   - **Conventions** — enforce rules from CONVENTIONS.md
3. Output a structured review in the format below

## Output Format

```
## Summary
[1-2 sentence overview]

## Issues
### [Severity: High/Medium/Low] [Short title]
- **File**: path/to/file.ts:42
- **Category**: Correctness / Security / Maintainability / Conventions
- **Description**: ...
- **Suggestion**: ...
```

## Example

Input: "review this function"
```python
def add(a, b):
    return a + b
```

Output:
## Summary
The function is correct but lacks type hints and error handling.

## Issues
### [Low] Missing type hints
- **File**: example.py:1
- **Category**: Conventions
- **Description**: Function parameters and return value have no type annotations.
- **Suggestion**: Add type hints: `def add(a: int, b: int) -> int:`
