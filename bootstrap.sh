#!/bin/bash

echo "🚀 Starting dotfiles bootstrap..."

# Install Homebrew if not installed
if ! command -v brew &>/dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "✅ Homebrew already installed"
fi

# Install all Brewfile packages
echo "📦 Installing Brewfile packages..."
brew bundle --file="$HOME/.dotfiles/Brewfile"

# Symlink dotfiles
echo "🔗 Symlinking dotfiles..."
ln -sf "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
mkdir -p "$HOME/.config"
ln -sf "$HOME/.dotfiles/.config/starship.toml" "$HOME/.config/starship.toml"
mkdir -p "$HOME/.config/fish"
ln -sf "$HOME/.dotfiles/.config/fish/config.fish" "$HOME/.config/fish/config.fish"

# Set zsh as default shell
if [[ "$SHELL" != "/bin/zsh" ]]; then
    echo "🐚 Setting zsh as default shell..."
    chsh -s /bin/zsh
fi

echo "✅ Bootstrap complete. Open a new terminal to enjoy your setup!"

