#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

assert_file_contains() {
  local file="$1"
  local expected="$2"

  grep -Fq -- "$expected" "$file" || fail "${file} does not contain: ${expected}"
}

test_package_bin_contract() {
  local package_json="${ROOT_DIR}/package.json"

  [ -f "$package_json" ] || fail "package.json is missing"
  assert_file_contains "$package_json" '"name": "@yatmn/skillpack"'
  assert_file_contains "$package_json" '"skillpack": "bin/skillpack"'
  assert_file_contains "$package_json" '"access": "public"'
}

test_profile_entrypoint() {
  local entrypoint="$1"
  local tmp_dir project_dir stub_dir log_file

  tmp_dir="$(mktemp -d)"
  project_dir="${tmp_dir}/project"
  stub_dir="${tmp_dir}/bin"
  log_file="${tmp_dir}/npx.log"

  mkdir -p "$project_dir" "$stub_dir"
  cat > "${stub_dir}/npx" <<'EOF'
#!/usr/bin/env bash
printf '%s\n' "$*" >> "${NPX_LOG}"
EOF
  chmod +x "${stub_dir}/npx"

  (
    cd "$project_dir"
    PATH="${stub_dir}:$PATH" NPX_LOG="$log_file" "${ROOT_DIR}/bin/skillpack" "$entrypoint"
  )

  [ -d "${project_dir}/.agents/skills" ] || fail "${entrypoint} did not create .agents/skills"
  assert_file_contains "$log_file" "skills add obra/superpowers --skill"
  assert_file_contains "$log_file" "--agent codex -y"

  rm -rf "$tmp_dir"
}

test_package_bin_contract
test_profile_entrypoint dev
test_profile_entrypoint -dev
test_profile_entrypoint --dev

echo "skillpack CLI tests passed"
