#!/usr/bin/env bash
# Push this project's Widgetbook web build to Widgetbook Cloud.
#
# Prerequisites:
#   1. Widgetbook Cloud project + API key (project settings).
#   2. This repo is a git checkout (CLI reads branch/remote metadata).
#
# Usage:
#   export WIDGETBOOK_API_KEY='your-key'
#   ./tool/widgetbook_cloud_push.sh
#
# Or load from a local .env file (gitignored):
#   set -a && source .env && set +a && ./tool/widgetbook_cloud_push.sh
#
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if [[ -z "${WIDGETBOOK_API_KEY:-}" ]]; then
  echo "error: WIDGETBOOK_API_KEY is not set." >&2
  echo "  export it, or: set -a && source .env && set +a" >&2
  echo "  Copy .env.example to .env and add your key." >&2
  exit 1
fi

echo ">> dart run build_runner build -d"
dart run build_runner build -d

echo ">> flutter build web -t lib/main.widgetbook.dart"
flutter build web -t lib/main.widgetbook.dart

WB_ARGS=(
  cloud build push
  --api-key "$WIDGETBOOK_API_KEY"
  --path "$ROOT"
)

[[ -n "${WIDGETBOOK_REPOSITORY:-}" ]] && WB_ARGS+=(--repository "$WIDGETBOOK_REPOSITORY")
[[ -n "${WIDGETBOOK_BRANCH:-}" ]] && WB_ARGS+=(--branch "$WIDGETBOOK_BRANCH")
[[ -n "${WIDGETBOOK_COMMIT:-}" ]] && WB_ARGS+=(--commit "$WIDGETBOOK_COMMIT")
[[ -n "${WIDGETBOOK_ACTOR:-}" ]] && WB_ARGS+=(--actor "$WIDGETBOOK_ACTOR")

echo ">> dart run widgetbook_cli:widgetbook ${WB_ARGS[*]}"
dart run widgetbook_cli:widgetbook "${WB_ARGS[@]}"
