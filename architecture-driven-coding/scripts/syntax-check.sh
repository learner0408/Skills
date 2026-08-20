#!/usr/bin/env bash
# syntax-check.sh — lightweight offline syntax verification for common languages.
# Usage: bash syntax-check.sh <file> [file...]
# Exit codes: 0 all pass | 1 any file failed | 2 usage error

set -u

have() { command -v "$1" >/dev/null 2>&1; }

if [ "$#" -eq 0 ]; then
  echo "Usage: bash syntax-check.sh <file> [file...]" >&2
  exit 2
fi

failed=0

check_file() {
  local file="$1"

  if [ ! -f "$file" ]; then
    echo "SKIP  $file (not found)" >&2
    return 0
  fi

  case "$file" in
    *.py)
      if have python3; then
        if python3 -m py_compile "$file" >/dev/null 2>&1; then
          echo "OK    $file (python)"
        else
          echo "FAIL  $file (python py_compile)" >&2
          failed=1
        fi
      else
        echo "SKIP  $file (python3 not available)" >&2
      fi
      ;;
    *.js|*.mjs|*.cjs)
      if have node; then
        if node --check "$file" >/dev/null 2>&1; then
          echo "OK    $file (node)"
        else
          echo "FAIL  $file (node --check)" >&2
          failed=1
        fi
      else
        echo "SKIP  $file (node not available)" >&2
      fi
      ;;
    *.sh)
      if bash -n "$file" >/dev/null 2>&1; then
        echo "OK    $file (bash)"
      else
        echo "FAIL  $file (bash -n)" >&2
        failed=1
      fi
      ;;
    *.rb)
      if have ruby; then
        if ruby -c "$file" >/dev/null 2>&1; then
          echo "OK    $file (ruby)"
        else
          echo "FAIL  $file (ruby -c)" >&2
          failed=1
        fi
      else
        echo "SKIP  $file (ruby not available)" >&2
      fi
      ;;
    *.go)
      if have gofmt; then
        if gofmt -l "$file" >/dev/null 2>&1; then
          echo "OK    $file (gofmt)"
        else
          echo "FAIL  $file (gofmt syntax)" >&2
          failed=1
        fi
      else
        echo "SKIP  $file (gofmt not available)" >&2
      fi
      ;;
    *.json)
      if have python3; then
        if python3 -m json.tool "$file" >/dev/null 2>&1; then
          echo "OK    $file (json)"
        else
          echo "FAIL  $file (python json.tool)" >&2
          failed=1
        fi
      else
        echo "SKIP  $file (python3 not available)" >&2
      fi
      ;;
    *.ts|*.tsx|*.rs)
      echo "SKIP  $file (no offline checker — verify with project tooling)" >&2
      ;;
    *)
      echo "SKIP  $file (unknown type — pick a checker manually)" >&2
      ;;
  esac
}

for file in "$@"; do
  check_file "$file"
done

exit "$failed"