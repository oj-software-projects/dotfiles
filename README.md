# Dotfiles

Personal configuration files (dotfiles) for macOS, Windows, and Linux. This repository is structured to mirror the target locations on different operating systems, allowing for seamless cross-platform management.

## Cross-Platform Structure

To accommodate the differences between macOS, Windows, and Linux, the repository is organized into system-specific directories. Some configurations (like VS Code settings) are stored redundantly to ensure each platform receives the correct, optimized version for its specific environment.

*   **`.config/`**: Standard Unix-like configuration directory, primarily used for Linux and shared configurations across platforms.
*   **`Library/Application Support/`**: macOS-specific configuration paths.
*   **`windows_appdata/Roaming/`**: Windows-specific configuration paths.
*   **`.ideavimrc`**: Global configuration for Vim emulation in JetBrains IDEs.

## Applications & Tools

The following applications are configured in this repository:

*   **VS Code**: A powerful, extensible code editor with support for virtually every programming language.
    *   **Website**: [https://code.visualstudio.com/](https://code.visualstudio.com/)
    *   **Config**: `Library/Application Support/Code/User/` (Mac), `windows_appdata/Roaming/Code/User/` (Windows)
*   **Neovim**: A hyper-extensible Vim-based text editor focused on extensibility and usability.
    *   **Website**: [https://neovim.io/](https://neovim.io/)
    *   **Config**: `.config/nvim/`
*   **WezTerm**: A GPU-accelerated cross-platform terminal emulator and multiplexer.
    *   **Website**: [https://wezfurlong.org/wezterm/](https://wezfurlong.org/wezterm/)
    *   **Config**: `.config/wezterm/`
*   **Yazi**: A terminal file manager written in Rust, based on async I/O.
    *   **Website**: [https://yazi-rs.github.io/](https://yazi-rs.github.io/)
    *   **Config**: `.config/yazi/`
*   **Zed**: A high-performance, multiplayer code editor built for speed.
    *   **Website**: [https://zed.dev/](https://zed.dev/)
    *   **Config**: `.config/zed/`
*   **IdeaVim**: A Vim emulation plugin for IDEs based on the IntelliJ platform.
    *   **Website**: [https://github.com/JetBrains/ideavim](https://github.com/JetBrains/ideavim)
    *   **Config**: `.ideavimrc`

## Installation

Configurations should be linked to their respective system locations. 

### macOS
```bash
# Example for VS Code
ln -s ~/dotfiles/Library/Application\ Support/Code/User/settings.json ~/Library/Application\ Support/Code/User/settings.json
```

### Windows (PowerShell)
```powershell
# Example for VS Code
New-Item -ItemType SymbolicLink -Path "$env:APPDATA\Code\User\settings.json" -Target "$HOME\dotfiles\windows_appdata\Roaming\Code\User\settings.json"
```

### Linux
```bash
# Example for Neovim
ln -s ~/dotfiles/.config/nvim ~/.config/nvim
```
