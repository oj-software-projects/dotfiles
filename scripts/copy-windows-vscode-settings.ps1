
# PowerShell Skript zum Kopieren der VSCode-Settings ins chezmoi-Repo
# Ziel: .tmpl-Dateien im chezmoi-Repo aktualisieren

# Passe diesen Pfad ggf. an, falls dein Home-Verzeichnis anders ist!
$ChezmoiDir = "$env:USERPROFILE\.local\share\chezmoi"

Write-Output "Kopiere settings.json von VSCode User-Ordner ins chezmoi-Repo..."
Copy-Item -Path "$env:APPDATA\Code\User\settings.json" -Destination "$ChezmoiDir\settings.json.tmpl" -Force

Write-Output "Kopiere keybindings.json von VSCode User-Ordner ins chezmoi-Repo..."
Copy-Item -Path "$env:APPDATA\Code\User\keybindings.json" -Destination "$ChezmoiDir\keybindings.json.tmpl" -Force

Write-Output "Fertig! Änderungen bitte prüfen (git status), committen und pushen."
