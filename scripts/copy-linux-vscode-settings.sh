#!/bin/bash

# Pfad zum chezmoi-Repo (ggf. anpassen, falls du ein anderes Home-Verzeichnis verwendest)
CHEZMOI_DIR="$HOME/.local/share/chezmoi"

echo "Kopiere settings.json von VSCode User-Ordner ins chezmoi-Repo..."
cp "$HOME/.config/Code/User/settings.json" "$CHEZMOI_DIR/settings.json.tmpl"

echo "Kopiere keybindings.json von VSCode User-Ordner ins chezmoi-Repo..."
cp "$HOME/.config/Code/User/keybindings.json" "$CHEZMOI_DIR/keybindings.json.tmpl"

echo "Fertig! Änderungen bitte prüfen (git status), committen und pushen."
