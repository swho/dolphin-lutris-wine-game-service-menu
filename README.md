# Dolphin Lutris Wine Game Service Menu

KDE Dolphin right-click action for adding a selected Windows executable as a
local Lutris Wine game.

## Install

```bash
./install.sh
```

Default Wine prefix is `$HOME/AAA`. To use another prefix:

```bash
./install.sh --wine-prefix /path/to/prefix
```

Restart Dolphin if the menu does not appear immediately.

## Usage

In Dolphin, right-click a Windows executable and choose:

`新增為 Lutris Wine 遊戲`

The plugin sets:

- name: inferred from the game directory
- runner: Wine
- executable: the selected file
- Wine prefix: configured during install
- artwork: fills missing cover, banner, and icon from the executable icon

Existing cover art, banners, and icons are left untouched. Other Lutris settings
are left to Lutris defaults.

## Uninstall

```bash
./uninstall.sh
```

## Files Installed

- `~/.local/bin/lutris-add-dolphin-wine-game`
- `~/.local/share/kio/servicemenus/lutris-add-wine-game.desktop`
- `~/.config/lutris-dolphin-wine-game/config.ini`
