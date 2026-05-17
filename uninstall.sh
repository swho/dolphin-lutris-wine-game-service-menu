#!/usr/bin/env bash
set -euo pipefail

bin_dir="${HOME}/.local/bin"
service_menu_dir="${XDG_DATA_HOME:-${HOME}/.local/share}/kio/servicemenus"
config_dir="${XDG_CONFIG_HOME:-${HOME}/.config}/lutris-dolphin-wine-game"

rm -f "${bin_dir}/lutris-add-dolphin-wine-game"
rm -f "${service_menu_dir}/lutris-add-wine-game.desktop"
rmdir "$config_dir" 2>/dev/null || true

if command -v kbuildsycoca6 >/dev/null 2>&1; then
  kbuildsycoca6 >/dev/null 2>&1 || true
elif command -v kbuildsycoca5 >/dev/null 2>&1; then
  kbuildsycoca5 >/dev/null 2>&1 || true
elif command -v kbuildsycoca >/dev/null 2>&1; then
  kbuildsycoca >/dev/null 2>&1 || true
fi

echo "Removed Dolphin Lutris Wine game service menu."
