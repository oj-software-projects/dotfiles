# Dotfiles

Personal cross-platform configuration files (dotfiles) optimized for **macOS**, **Linux**, and **Windows**. 

This repository uses a modular, tool-centric architecture. Instead of maintaining complex or fragile symbolic links that fail with app sandboxing (like VS Code under macOS), this setup relies on a clean, deterministic **Push & Pull Copy Strategy**. Central configurations are stored once and synchronized safely via native scripts.

---

## Repository Structure

The repository is divided into two main areas: `apps/` for application-specific configurations and `home/` for global configuration files that live directly in the user's home directory.

```text
.
├── apps/
│   ├── nvim/             # Full LazyVim / Neovim configuration
│   ├── vscode/           # VS Code settings.json & keybindings.json (Shared)
│   ├── wezterm/          # WezTerm configuration (wezterm.lua)
│   ├── yazi/             # Yazi async terminal file manager configuration
│   └── zed/              # Zed high-performance editor configuration
├── home/
│   ├── .ideavimrc        # Global Vim emulation for JetBrains IDEs
│   ├── .luarc.json       # Lua development server configurations
│   ├── .p10k.zsh         # Powerlevel10k theme configuration
│   └── .zshrc            # Zsh shell configuration (with runtime OS-switches)
├── .gitignore            # Clean filtering for OS clutter and editor caches
├── bootstrap.sh          # Sync script for macOS & Linux (Bash)
└── bootstrap.ps1         # Sync script for Windows (PowerShell)

```

---

## Applications & Target Paths

Every tool is maintained exactly **once** inside the `apps/` directory and mapped to the respective system paths:

* **Neovim (LazyVim)**: `~/.config/nvim` (Unix) | `AppData\Local\nvim` (Windows)
* **WezTerm**: `~/.config/wezterm` (Unix) | `AppData\Local\wezterm` (Windows)
* **Yazi**: `~/.config/yazi` (Unix) | `AppData\Roaming\yazi\config` (Windows)
* **VS Code**: `~/Library/Application Support/Code/User` (macOS) | `~/.config/Code/User` (Linux) | `AppData\Roaming\Code\User` (Windows)
* **Zed**: `~/.config/zed` (Unix)
* **IdeaVim**: `~/.ideavimrc` (All Platforms)

---

## Sync Workflow (How to use)

The sync scripts (`bootstrap.sh` and `bootstrap.ps1`) require an argument to determine the data flow direction.

### 1. On macOS & Linux

Before the very first run, ensure the script is executable:

```bash
chmod +x bootstrap.sh

```

* **Deploy to local machine** (e.g., after `git pull` or on a new system):
```bash
./bootstrap.sh to-system


```



```
* **Pull local changes back into the repository** (e.g., after modifying settings in VS Code or Neovim):
  ```bash
  ./bootstrap.sh to-repo
  

```

### 2. On Windows (PowerShell Core)

* **Deploy to local machine**:
```powershell
.\bootstrap.ps1 to-system

```


* **Pull local changes back into the repository**:
```powershell
.\bootstrap.ps1 to-repo


```



```

---

## Shell Setup (macOS / Linux)

The included `.zshrc` automatically handles OS-specific paths natively on execution and relies on **Oh My Zsh** and the **Powerlevel10k** prompt. On a fresh Unix setup, install the prerequisites before pushing the dotfiles:

1. **Install Oh My Zsh:**
   ```bash
   sh -c "$(curl -fsSL [https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh](https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh))"

```

2. **Install Powerlevel10k Theme:**
```bash
git clone --depth=1 [https://github.com/romkatv/powerlevel10k.git](https://github.com/romkatv/powerlevel10k.git) ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

```


3. **Deploy Configurations:** Run `./bootstrap.sh to-system` to copy the pre-configured `.zshrc` and `.p10k.zsh` to your home directory.
4. **Reload Shell:** Run `source ~/.zshrc`.

```

```