#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

bash -n "$repo_root/bihal.sh"

if command -v shellcheck >/dev/null 2>&1; then
  shellcheck "$repo_root/bihal.sh" "$repo_root/scripts/check.sh"
fi

while IFS= read -r -d '' file; do
  luac -p "$file"
done < <(find "$repo_root" -type f -name '*.lua' -not -path '*/.git/*' -print0)

python3 -m json.tool "$repo_root/lazy-lock.json" >/dev/null
python3 -m json.tool "$repo_root/lua/.luarc.json" >/dev/null

nvim --headless -u NONE \
  "+set runtimepath^=$repo_root" \
  "+lua assert(loadfile('$repo_root/init.lua'))" \
  +qa

if [[ "${BIHAL_FULL_STARTUP_TEST:-0}" == "1" ]]; then
  tmp_home="$(mktemp -d)"
  trap 'rm -rf -- "$tmp_home"' EXIT
  mkdir -p "$tmp_home/config"
  ln -s "$repo_root" "$tmp_home/config/nvim"

  XDG_CONFIG_HOME="$tmp_home/config" \
    XDG_DATA_HOME="$tmp_home/data" \
    XDG_STATE_HOME="$tmp_home/state" \
    XDG_CACHE_HOME="$tmp_home/cache" \
    nvim --headless "+lua vim.defer_fn(function() vim.cmd('qa') end, 3000)"
fi

git -C "$repo_root" diff --check

echo "All available checks passed."
