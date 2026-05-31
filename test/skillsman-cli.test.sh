#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLSMAN="${ROOT_DIR}/bin/skillsman"
TMP_ROOT="$(mktemp -d)"

cleanup() {
  rm -rf "$TMP_ROOT"
}
trap cleanup EXIT

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

make_tmp() {
  local dir
  dir="$(mktemp -d "${TMP_ROOT}/tmp.XXXXXX")"
  printf '%s\n' "$dir"
}

make_project() {
  local project
  project="$(make_tmp)/project"
  mkdir -p "$project"
  printf '%s\n' "$project"
}

make_fake_npx() {
  local fake_bin="$1"
  mkdir -p "$fake_bin"
  cat > "${fake_bin}/npx" <<'SH'
#!/usr/bin/env bash
set -euo pipefail

log="${SKILLSMAN_TEST_LOG:?}"
state="${SKILLSMAN_TEST_STATE:?}"

printf '%s\n' "$*" >> "$log"

[ "${1:-}" = "skills" ] || exit 1

case "${2:-}" in
  --help)
    exit 0
    ;;
  list)
    printf '['
    first=1
    if [ -f "$state" ]; then
      while IFS= read -r skill || [ -n "$skill" ]; do
        [ -n "$skill" ] || continue
        if [ "$first" -eq 0 ]; then
          printf ','
        fi
        first=0
        printf '{"name":"%s"}' "$skill"
      done < "$state"
    fi
    printf ']'
    ;;
  add)
    shift 2
    while [ "$#" -gt 0 ]; do
      case "$1" in
        --skill)
          shift
          while [ "$#" -gt 0 ]; do
            case "$1" in
              --*) break ;;
              *) printf '%s\n' "$1" >> "$state" ;;
            esac
            shift
          done
          ;;
        --agent)
          shift
          [ "$#" -gt 0 ] && shift
          ;;
        *)
          shift
          ;;
      esac
    done
    if [ -f "$state" ]; then
      sort -u "$state" -o "$state"
    fi
    ;;
  remove)
    exit 0
    ;;
  *)
    exit 0
    ;;
esac
SH
  chmod +x "${fake_bin}/npx"
}

run_with_fake_npx() {
  local fake_bin="$1"
  local log="$2"
  local state="$3"
  shift 3

  PATH="${fake_bin}:${PATH}" \
    SKILLSMAN_TEST_LOG="$log" \
    SKILLSMAN_TEST_STATE="$state" \
    "$@"
}

test_remove_passes_agent_for_each_target() {
  local project tmp fake_bin log state
  project="$(make_project)"
  tmp="$(make_tmp)"
  fake_bin="${tmp}/bin"
  log="${tmp}/npx.log"
  state="${tmp}/state.txt"
  make_fake_npx "$fake_bin"

  run_with_fake_npx "$fake_bin" "$log" "$state" \
    "$SKILLSMAN" remove skillsman-readme --target codex,cursor --project "$project"

  grep -Fxq "skills remove skillsman-readme --agent codex -y" "$log" ||
    fail "remove did not pass --agent codex"
  grep -Fxq "skills remove skillsman-readme --agent cursor -y" "$log" ||
    fail "remove did not pass --agent cursor"
}

test_target_all_does_not_skip_from_codex_directory() {
  local project tmp fake_bin log state yatmn_line
  project="$(make_project)"
  mkdir -p "${project}/.agents/skills/skillsman-readme"
  touch "${project}/.agents/skills/skillsman-readme/SKILL.md"
  tmp="$(make_tmp)"
  fake_bin="${tmp}/bin"
  log="${tmp}/npx.log"
  state="${tmp}/state.txt"
  make_fake_npx "$fake_bin"

  run_with_fake_npx "$fake_bin" "$log" "$state" \
    "$SKILLSMAN" add workflow --target all --project "$project"

  yatmn_line="$(grep -F "skills add YatMn/skillsman" "$log" || true)"
  case "$yatmn_line" in
    *skillsman-readme*) ;;
    *) fail "--target all skipped skillsman-readme because it existed only in Codex directory" ;;
  esac
}

test_claude_alias_snapshots_as_claude_code() {
  local project snapshot
  project="$(make_project)"
  mkdir -p "${project}/.claude/skills/sample-skill"
  touch "${project}/.claude/skills/sample-skill/SKILL.md"
  cat > "${project}/skills-lock.json" <<'JSON'
{"skills":{"sample-skill":{"source":"example/source"}}}
JSON
  snapshot="${project}/snapshot.yaml"

  "$SKILLSMAN" snapshot --target claude --project "$project" --output "$snapshot" >/dev/null

  grep -Fq "  claude-code:" "$snapshot" ||
    fail "snapshot should use canonical claude-code target"
}

test_doctor_describes_snapshot_lock_usage() {
  local project tmp fake_bin log state output
  project="$(make_project)"
  tmp="$(make_tmp)"
  fake_bin="${tmp}/bin"
  log="${tmp}/npx.log"
  state="${tmp}/state.txt"
  make_fake_npx "$fake_bin"

  output="$(run_with_fake_npx "$fake_bin" "$log" "$state" \
    "$SKILLSMAN" doctor --target codex --project "$project")"

  case "$output" in
    *"skills-lock.json is used by snapshot"*) ;;
    *) fail "doctor should explain snapshot-specific skills-lock.json usage" ;;
  esac
}

test_workflow_includes_openspec_skill() {
  local output
  output="$("$SKILLSMAN" show workflow)"

  case "$output" in
    *skillsman-openspec*) ;;
    *) fail "workflow scenario should include skillsman-openspec" ;;
  esac
}

test_remove_passes_agent_for_each_target
test_target_all_does_not_skip_from_codex_directory
test_claude_alias_snapshots_as_claude_code
test_doctor_describes_snapshot_lock_usage
test_workflow_includes_openspec_skill

echo "skillsman CLI tests passed"
