# ===================================================================
# ZSH CONFIGURATION
# ===================================================================

# ===================================================================
# TERMINAL DETECTION
# ===================================================================
# Check if we're in an IDE/editor terminal (for conditional loading)
_is_ide_terminal() {
  [[ "$TERM_PROGRAM" == "vscode" ]] || \
  [[ "$TERM_PROGRAM" == "cursor" ]] || \
  [[ "$TERM_PROGRAM" == "kiro" ]] || \
  [[ -n "$VSCODE_INJECTION" ]] || \
  [[ -n "$WINDSURF_TERMINAL" ]] || \
  [[ "$TERMINAL_EMULATOR" == "JetBrains-JediTerm" ]]
}

# ===================================================================
# POWERLEVEL10K INSTANT PROMPT (Must be at the top)
# ===================================================================
# Only load Powerlevel10k instant prompt if not in IDE terminal
if ! _is_ide_terminal; then
  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi

# ===================================================================
# PATH CONFIGURATION
# ===================================================================
# Base PATH setup
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# ===================================================================
# OH MY ZSH CONFIGURATION
# ===================================================================
# Only load Oh My Zsh if not in IDE terminal
if ! _is_ide_terminal; then
  # Path to Oh My Zsh installation
  export ZSH="$HOME/.oh-my-zsh"

  # Theme configuration
  ZSH_THEME="powerlevel10k/powerlevel10k"
  # Alternative themes (commented out):
  # ZSH_THEME="robbyrussell"
  # ZSH_THEME="dst"

  # Plugins configuration
  plugins=(git zsh-autosuggestions)

  # Oh My Zsh settings (uncomment to enable)
  # CASE_SENSITIVE="true"                    # Use case-sensitive completion
  # HYPHEN_INSENSITIVE="true"               # Use hyphen-insensitive completion
  # DISABLE_MAGIC_FUNCTIONS="true"          # Disable magic functions if pasting URLs is messed up
  # DISABLE_LS_COLORS="true"                # Disable colors in ls
  # DISABLE_AUTO_TITLE="true"               # Disable auto-setting terminal title
  # ENABLE_CORRECTION="true"                # Enable command auto-correction
  # COMPLETION_WAITING_DOTS="true"          # Display red dots whilst waiting for completion
  # DISABLE_UNTRACKED_FILES_DIRTY="true"    # Don't mark untracked files as dirty (faster for large repos)
  # HIST_STAMPS="mm/dd/yyyy"                # History timestamp format

  # Update behavior
  # zstyle ':omz:update' mode disabled      # disable automatic updates
  # zstyle ':omz:update' mode auto          # update automatically without asking
  # zstyle ':omz:update' mode reminder      # just remind me to update when it's time
  # zstyle ':omz:update' frequency 13       # update frequency in days

  # Load Oh My Zsh
  source $ZSH/oh-my-zsh.sh
else
  # Minimal setup for IDE terminals
  # Set a simple prompt
  export PS1="%n@%m:%~$ "
  
  # Enable basic completion
  autoload -Uz compinit
  compinit
  
  # Basic git aliases (since we're not loading oh-my-zsh git plugin)
  alias gs='git status'
  alias ga='git add'
  alias gc='git commit'
  alias gp='git push'
  alias gl='git pull'
fi

# ===================================================================
# USER CONFIGURATION
# ===================================================================
# Language environment
# export LANG=en_US.UTF-8

# Manual pages path
# export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# ===================================================================
# CUSTOM ALIASES AND FUNCTIONS
# ===================================================================
# Load custom aliases and macOS-specific configurations
source $ZSH_CUSTOM/aliases.zsh
source $ZSH_CUSTOM/macos.zsh

# Example aliases (commented out):
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ===================================================================
# POWERLEVEL10K CONFIGURATION
# ===================================================================
# Only load Powerlevel10k configuration if not in IDE terminal
if ! _is_ide_terminal; then
  # Load Powerlevel10k configuration
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi

# ===================================================================
# DEVELOPMENT TOOLS
# ===================================================================
# Local environment
. "$HOME/.local/bin/env"

# Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # Load nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # Load nvm bash_completion

# Zoxide (better cd)
eval "$(zoxide init zsh)"

# UV (Python package manager)
eval "$(uv generate-shell-completion zsh)"

# ===================================================================
# EXTERNAL TOOLS PATH ADDITIONS
# ===================================================================
### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Windsurf (AI-powered code editor)
export PATH="$HOME/.codeium/windsurf/bin:$PATH"

# ===================================================================
# TERMINAL AND SHELL INTEGRATIONS
# ===================================================================
# Kiro terminal integration
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# 1Password CLI plugins
source $HOME/.config/op/plugins.sh
