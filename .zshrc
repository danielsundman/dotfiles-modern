# Load aliases
source "$HOME/.dotfiles/.aliases"

# Load extra configuration (if it exists)
[ -f "$HOME/.extra" ] && source "$HOME/.extra"

# File name colors for lsd/ls (256-color, readable on dark backgrounds)
export LS_COLORS="di=1;38;5;75:ln=38;5;80:ex=38;5;114:so=38;5;176:pi=38;5;176:bd=38;5;221:cd=38;5;216:or=38;5;203:mi=38;5;203"

# Initialize Starship prompt
eval "$(starship init zsh)"

# Add dotfiles bin to PATH
export PATH="$HOME/.dotfiles/bin:$PATH"

# Add local node_modules/.bin to PATH
export PATH="./node_modules/.bin:$PATH"

# Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"
[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix nvm)/etc/bash_completion.d/nvm"

# History settings
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE="$HOME/.zsh_history"
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

# Enable case-insensitive completion
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
