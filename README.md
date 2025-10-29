# Dotfiles Managed with chezmoi

This repository is the source state for my cross-platform dotfiles, managed with [chezmoi](https://www.chezmoi.io/). The layout follows chezmoi conventions (`dot_` prefix for dotfiles, OS-specific suffixes, templates, etc.), letting the same repo provision macOS, Linux, and Windows machines.

## Managed Targets by Platform

- **Shared across platforms**
  - `~/.config/wezterm/wezterm.lua` generated from `dot_config/wezterm/wezterm.lua.tmpl` (default shell adapts per OS).
  - `~/.config/Code/User/{settings,keybindings}.json` used primarily on Linux.
  - The full Neovim setup in `~/.config/nvim` (LazyVim-based) including plugin configuration, stylua formatting, and helper utilities.
  - `~/.ideavimrc` IDE keybinding configuration.

- **macOS**
  - `~/Library/Application Support/Code/User/{settings,keybindings}.json` via templates with the `.tmpl.os=darwin` suffix.
  - Helper script `scripts/copy-mac-vscode-settings.sh` to pull VS Code preferences from the live system back into the source tree.

- **Windows**
  - `%AppData%\Code\User\{settings,keybindings}.json` via `.tmpl.os=windows` templates.
  - Helper script `scripts/copy-windows-vscode-settings.ps1` to sync VS Code settings from a Windows machine.

- **Linux**
  - Shares the common VS Code path under `~/.config/Code/User/`.
  - Script `scripts/copy-linux-vscode-settings.sh` keeps the repository in sync with a Linux install.

## Typical Workflow

```bash
# Inspect pending changes that would be applied to the destination system
chezmoi diff

# Apply all managed files to the current machine
chezmoi apply

# Show which files chezmoi currently tracks
chezmoi managed
```

## Applying Individual Configurations

Use `chezmoi apply --source-path <entry>` with the source-state path (the path shown by `chezmoi managed`). A few common examples:

- **WezTerm (all platforms)**
  ```bash
  chezmoi apply --source-path dot_config/wezterm/wezterm.lua.tmpl
  ```

- **VS Code settings**
  - Linux:
    ```bash
    chezmoi apply --source-path dot_config/Code/User/settings.json
    chezmoi apply --source-path dot_config/Code/User/keybindings.json
    ```
  - macOS:
    ```bash
    chezmoi apply --source-path 'Library/Application Support/Code/User/settings.json.tmpl.os=darwin'
    chezmoi apply --source-path 'Library/Application Support/Code/User/keybindings.json.tmpl.os=darwin'
    ```
  - Windows (PowerShell):
    ```powershell
    chezmoi apply --source-path 'AppData/Roaming/Code/User/settings.json.tmpl.os=windows'
    chezmoi apply --source-path 'AppData/Roaming/Code/User/keybindings.json.tmpl.os=windows'
    ```

For any other managed file, copy its source-state path from `chezmoi managed` and pass it to `chezmoi apply --source-path`.

