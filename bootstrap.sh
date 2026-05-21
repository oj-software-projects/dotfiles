#!/bin/bash
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

MODE=$1
if [[ "$MODE" != "to-system" && "$MODE" != "to-repo" ]]; then
  echo "Bitte Modus angeben: ./bootstrap.sh [to-system | to-repo]"
  exit 1
fi

# Pfade für Unix definieren
CONFIG_HOME="$HOME/.config"
if [[ "$OSTYPE" == "darwin"* ]]; then
  VSCODE_TARGET="$HOME/Library/Application Support/Code/User"
else
  VSCODE_TARGET="$HOME/.config/Code/User"
fi

# --- FUNKTION: REPO -> SYSTEM ---
sync_to_system() {
  echo "🔄 Kopiere Dotfiles vom Repo auf das System..."

  # Home-Files kopieren
  cp "$DOTFILES_DIR/home/.zshrc" "$HOME/.zshrc"
  cp "$DOTFILES_DIR/home/.p10k.zsh" "$HOME/.p10k.zsh"
  cp "$DOTFILES_DIR/home/.ideavimrc" "$HOME/.ideavimrc"
  cp "$DOTFILES_DIR/home/.luarc.json" "$HOME/.luarc.json" 2>/dev/null || true

  # CLI/Terminal Tools kopieren (Ordner vorher leeren, um Reste zu vermeiden)
  for app in nvim wezterm yazi zed; do
    if [ -d "$DOTFILES_DIR/apps/$app" ]; then
      mkdir -p "$CONFIG_HOME/$app"
      rm -rf "${CONFIG_HOME:?}/$app"/*
      cp -r "$DOTFILES_DIR/apps/$app"/* "$CONFIG_HOME/$app/"
    fi
  done

  # VS Code Sonderfall
  mkdir -p "$VSCODE_TARGET"
  cp "$DOTFILES_DIR/apps/vscode/settings.json" "$VSCODE_TARGET/settings.json"
  cp "$DOTFILES_DIR/apps/vscode/keybindings.json" "$VSCODE_TARGET/keybindings.json"

  echo "✅ Fertig! System ist auf dem Stand des Repos."
}

# --- FUNKTION: SYSTEM -> REPO ---
sync_to_repo() {
  echo "📥 Hole aktuelle Files vom System ins Repo..."

  # Home-Files zurückholen
  cp "$HOME/.zshrc" "$DOTFILES_DIR/home/.zshrc"
  cp "$HOME/.p10k.zsh" "$DOTFILES_DIR/home/.p10k.zsh"
  cp "$HOME/.ideavimrc" "$DOTFILES_DIR/home/.ideavimrc"
  [ -f "$HOME/.luarc.json" ] && cp "$HOME/.luarc.json" "$DOTFILES_DIR/home/.luarc.json"

  # CLI/Terminal Tools zurückholen
  for app in nvim wezterm yazi zed; do
    if [ -d "$CONFIG_HOME/$app" ]; then
      mkdir -p "$DOTFILES_DIR/apps/$app"
      rm -rf "$DOTFILES_DIR/apps/$app"/*
      cp -r "$CONFIG_HOME/$app"/* "$DOTFILES_DIR/apps/$app/"
    fi
  done

  # VS Code Sonderfall zurückholen
  if [ -d "$VSCODE_TARGET" ]; then
    mkdir -p "$DOTFILES_DIR/apps/vscode"
    [ -f "$VSCODE_TARGET/settings.json" ] && cp "$VSCODE_TARGET/settings.json" "$DOTFILES_DIR/apps/vscode/settings.json"
    [ -f "$VSCODE_TARGET/keybindings.json" ] && cp "$VSCODE_TARGET/keybindings.json" "$DOTFILES_DIR/apps/vscode/keybindings.json"
  fi

  echo "✅ Fertig! Repo ist auf dem neuesten Stand. Bereit für git commit."
}

# Modus ausführen
if [[ "$MODE" == "to-system" ]]; then
  # Vorher eventuell kaputte Symlinks im System weghauen, falls vorhanden
  [ -L "$HOME/.zshrc" ] && rm "$HOME/.zshrc"
  [ -L "$VSCODE_TARGET" ] && rm "$VSCODE_TARGET"
  sync_to_system
else
  sync_to_repo
fi
