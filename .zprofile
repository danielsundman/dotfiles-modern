# Login shell setup: runs before .zshrc

# Homebrew (Apple Silicon installs to /opt/homebrew, which is not on the default PATH)
eval "$(/opt/homebrew/bin/brew shellenv)"

# Docker Desktop CLI tools
export PATH="$PATH:$HOME/.docker/bin"
