#!/usr/bin/env bash
set -euo pipefail

plugin_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
bin_dir="${HOME}/.local/bin"
service_menu_dir="${XDG_DATA_HOME:-${HOME}/.local/share}/kio/servicemenus"
config_dir="${XDG_CONFIG_HOME:-${HOME}/.config}/lutris-dolphin-wine-game"
script_path="${bin_dir}/lutris-add-dolphin-wine-game"
desktop_path="${service_menu_dir}/lutris-add-wine-game.desktop"
wine_prefix="${HOME}/AAA"

while (($#)); do
  case "$1" in
    --wine-prefix)
      wine_prefix="${2:?missing value for --wine-prefix}"
      shift 2
      ;;
    --help|-h)
      cat <<'HELP'
Usage: ./install.sh [--wine-prefix /path/to/wineprefix]

Installs a KDE Dolphin service menu that adds the selected Windows executable
as a Lutris Wine game. Default Wine prefix: $HOME/AAA
HELP
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      exit 2
      ;;
  esac
done

if ! command -v python3 >/dev/null 2>&1; then
  echo "python3 is required." >&2
  exit 1
fi

if ! python3 - <<'PY' >/dev/null 2>&1
import lutris
PY
then
  echo "Lutris Python modules were not found. Install Lutris first." >&2
  exit 1
fi

mkdir -p "$bin_dir" "$service_menu_dir" "$config_dir"
install -m 0755 "${plugin_dir}/bin/lutris-add-dolphin-wine-game" "$script_path"

cat > "${config_dir}/config.ini" <<EOF
[settings]
wine_prefix = ${wine_prefix}
EOF

cat > "$desktop_path" <<EOF
[Desktop Entry]
Type=Service
Name=新增為 Lutris Wine 遊戲
Name[zh_TW]=新增為 Lutris Wine 遊戲
ServiceTypes=KonqPopupMenu/Plugin
X-KDE-ServiceTypes=KonqPopupMenu/Plugin
MimeType=application/x-ms-dos-executable;application/vnd.microsoft.portable-executable;application/x-dosexec;application/x-msdownload;application/x-msi;application/x-ms-shortcut;
Actions=addToLutrisWineGame;
X-KDE-Priority=TopLevel
X-KDE-StartupNotify=false
X-KDE-AuthorizeAction=shell_access
Icon=lutris

[Desktop Action addToLutrisWineGame]
Name=新增為 Lutris Wine 遊戲
Name[zh_TW]=新增為 Lutris Wine 遊戲
Icon=lutris
Exec=/usr/bin/env python3 ${script_path} %F
EOF

chmod 0755 "$desktop_path"

if command -v kbuildsycoca6 >/dev/null 2>&1; then
  kbuildsycoca6 >/dev/null 2>&1 || true
elif command -v kbuildsycoca5 >/dev/null 2>&1; then
  kbuildsycoca5 >/dev/null 2>&1 || true
elif command -v kbuildsycoca >/dev/null 2>&1; then
  kbuildsycoca >/dev/null 2>&1 || true
fi

echo "Installed Dolphin Lutris Wine game service menu."
echo "Wine prefix: ${wine_prefix}"
echo "Restart Dolphin if the menu does not appear immediately."
