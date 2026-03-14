# Dotfiles

Personal configuration files (dotfiles) for macOS, Windows, and Linux. This repository is structured to manage configurations across multiple operating systems, dealing with the different paths and variations required by each platform.

## Cross-Platform Structure

To accommodate the differences between macOS, Windows, and Linux, the repository is organized into directories that reflect the structure of the respective operating system. Files might be duplicated across these OS-specific directories if the configuration requires slight variations depending on the system (e.g., different terminal paths or keyboard shortcuts in VS Code).

*   **`.config/`**: Standard Unix-like configuration directory, used primarily for Linux, macOS, and tools that share the exact same configuration across platforms.
*   **`Library/Application Support/`**: macOS-specific configuration paths (e.g., VS Code on Mac).
*   **`windows_appdata/Roaming/`**: Windows-specific configuration paths (e.g., VS Code on Windows).
*   **`.ideavimrc`**: Global configuration for Vim emulation in JetBrains IDEs.
*   **`.zshrc` & `.p10k.zsh`**: Zsh terminal configuration and Powerlevel10k theme settings.

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

## Usage

Instead of using symlinks, these files are intended to be copied or managed by a dotfiles manager (like Chezmoi or a custom script) to their respective locations on each operating system. Because paths and settings differ, ensure you deploy the files from the directory corresponding to your current OS.

### Zsh & Powerlevel10k Setup (macOS / Linux)

If you want to use the included terminal configuration (`.zshrc` and `.p10k.zsh`), you need to install Oh My Zsh and the Powerlevel10k theme first.

1.  **Install Oh My Zsh:**
    ```bash
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ```
2.  **Install Powerlevel10k theme:**
    ```bash
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    ```
3.  **Apply Configurations:**
    Copy the `.zshrc` and `.p10k.zsh` files from this repository to your home directory (`~/`).
4.  **Restart Terminal:** 
    Restart your terminal or run `source ~/.zshrc`. If prompted by the Powerlevel10k configuration wizard, you can usually abort it since your `.p10k.zsh` already contains your preferences.
