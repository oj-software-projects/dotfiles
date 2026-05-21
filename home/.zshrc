# ==============================================================================
# 1. POWERLEVEL10K INSTANT PROMPT (Muss ganz oben stehen)
# ==============================================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ==============================================================================
# 2. OH MY ZSH INITIALISIERUNG
# ==============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
ENABLE_CORRECTION="true"

# Plugins (plattformunabhängig geladen)
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
  docker
  node
  python
)

source $ZSH/oh-my-zsh.sh

# ==============================================================================
# 3. LAUFZEIT-WEICHE: OS-SPEZIFISCHE PFADE & SETTINGS
# ==============================================================================

if [[ "$OSTYPE" == "darwin"* ]]; then
    # --------------------------------------------------------------------------
    # macOS SPEZIFISCH (Dein MacBook Pro)
    # --------------------------------------------------------------------------
    export GOOGLE_CLOUD_PROJECT="gemma-mac"
    
    # Homebrew (Falls auf Mac genutzt, initialisieren)
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    # Mac-spezifische App-Pfade anhängen
    export PATH="$PATH:/Users/oliverjazic/.lmstudio/bin"
    export PATH="/Users/oliverjazic/.antigravity/antigravity/bin:$PATH"

elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # --------------------------------------------------------------------------
    # LINUX SPEZIFISCH (Server / Linux-Maschinen)
    # --------------------------------------------------------------------------
    export GOOGLE_CLOUD_PROJECT="gemma-linux"
    
    # Linux-Standardpfade für lokale Binaries sicherstellen
    export PATH="$HOME/.local/bin:$PATH"
fi

# ==============================================================================
# 4. GEMEINSAME WORKFLOWS & TOOLS (Gilt für Mac & Linux)
# ==============================================================================

# Zoxide (Prüft sauber und ohne Syntax-Fehler, ob das Tool existiert)
if (( $+commands[zoxide] )); then
    eval "$(zoxide init zsh)"
fi

# Yazi Smart-CD Funktion
yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# Version-Manager: NVM (Lädt nur, wenn die Ordnerstruktur existiert)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Version-Manager: SDKMAN (Lädt dynamisch am Ende der Datei)
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Powerlevel10k Theme laden (sucht die .p10k.zsh immer sauber im Home-Verzeichnis)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
