#!/bin/bash

# Zielpfade im chezmoi-Repo (ggf. Pfad anpassen)
CHEZMOI_DIR="$HOME/.local/share/chezmoi"

echo "Kopiere settings.json von VSCode User-Ordner ins chezmoi-Repo..."
cp "$HOME/Library/Application Support/Code/User/settings.json" "$CHEZMOI_DIR/settings.json.tmpl"

echo "Kopiere keybindings.json von VSCode User-Ordner ins chezmoi-Repo..."
cp "$HOME/Library/Application Support/Code/User/keybindings.json" "$CHEZMOI_DIR/keybindings.json.tmpl"

echo "Fertig! Änderungen bitte prüfen (git status), committen und pushen."
