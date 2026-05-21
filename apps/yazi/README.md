Here is the English version of the **README.md**. It is designed to be clear and professional, perfect for your GitHub repository or local documentation.

---

# Yazi Configuration - Quick Start

These dotfiles contain my personal **Yazi** configuration, including plugins, themes, and custom keymaps. To ensure everything works correctly after copying these files to your system, follow these steps.

## 1. Prerequisites
Make sure you have **Yazi** and the CLI tool **`ya`** installed.
* **Linux/macOS:** Usually via `brew`, `pacman`, or `cargo`.
* **Windows:** Via `winget` or `scoop`.

---

## 2. The Essential First Step: Install Plugins
After copying the configuration files, the actual plugin scripts are not yet present (as they should generally be ignored by Git). 

Open your terminal and run:

```bash
ya pkg install
```

**What does this do?**
`ya` reads your `package.toml` file, identifies all registered plugins (like `full-border`, `git`, etc.), and automatically downloads them into your local `packages/` folder.

---

## 3. Shell Integration (CWD on Quit)
To start Yazi with the `yy` command and have your shell automatically "follow" you to the last directory upon quitting (`q`), add this wrapper to your shell configuration:

### Linux & macOS (`.zshrc` or `.bashrc`)
```bash
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
```

### Windows (`$PROFILE` in PowerShell)
```powershell
function yy {
    $tmp = New-TemporaryFile
    yazi --cwd-file "$tmp" $args
    if (Test-Path $tmp) {
        $cwd = Get-Content $tmp
        if ($cwd -and $cwd -ne $pwd.Path) { cd $cwd }
        Remove-Item -Force $tmp
    }
}
```

---

## 4. Configuration Paths
In case you need to move files manually, here are the default configuration paths:

| OS | Path |
| :--- | :--- |
| **Linux / macOS** | `~/.config/yazi/` |
| **Windows** | `%AppData%\yazi\config\` |

---

## 5. Maintenance
To keep all your plugins up to date, occasionally run:
```bash
ya pkg update
```

