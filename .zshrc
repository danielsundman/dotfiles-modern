# PATH (typeset -U drops duplicate entries)
typeset -U path
path=("$HOME/.dotfiles/bin" $path)

# Load aliases
source "$HOME/.aliases"

# Load extra configuration (if it exists)
[ -f "$HOME/.extra" ] && source "$HOME/.extra"

# File name colors for lsd/ls (256-color, readable on dark backgrounds)
export LS_COLORS="di=1;38;5;75:ln=38;5;80:ex=38;5;114:so=38;5;176:pi=38;5;176:bd=38;5;221:cd=38;5;216:or=38;5;203:mi=38;5;203"

# Runtime versions (Node, Python, ...) via mise
eval "$(mise activate zsh)"

# History settings
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE="$HOME/.zsh_history"
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

# Completion: only rebuild the cache once a day, case-insensitive matching
autoload -Uz compinit
stale_dump=(${ZDOTDIR:-$HOME}/.zcompdump(N.mh+24))
if (( ${#stale_dump} )); then
  compinit
else
  compinit -C
fi
unset stale_dump
zstyle ":completion:*" matcher-list "m:{a-zA-Z}={A-Za-z}"

# Initialize Starship prompt
eval "$(starship init zsh)"

# Claude Code
export CLAUDE_CODE_PACKAGE_MANAGER_AUTO_UPDATE=1
