#!/bin/bash

echo "🚀 Starting dotfiles bootstrap..."

# Install Homebrew if not installed
if ! command -v brew &>/dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "✅ Homebrew already installed"
    brew update
fi

# Function to install CLI tools only if missing
install_cli() {
    for pkg in "$@"; do
        if brew list "$pkg" &>/dev/null; then
            echo "✅ $pkg already installed"
        else
            echo "📦 Installing $pkg..."
            brew install "$pkg"
        fi
    done
}

# Function to install GUI apps only if missing
install_cask() {
    for app in "$@"; do
        if brew list --cask "$app" &>/dev/null; then
            echo "✅ $app already installed"
        else
            echo "🖥 Installing $app..."
            brew install --cask "$app"
        fi
    done
}

# CLI tools
install_cli git node nvm python fzf ripgrep tmux starship fish atuin lazygit

# GUI apps
install_cask iterm2 visual-studio-code rectangle raycast warp font-jetbrains-mono font-meslo-lg-nerd-font

# Trackpad & mouse settings
echo "🖱 Optimizing trackpad settings..."
# Enable tap-to-click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1
echo "✅ Tap-to-click enabled"

# Enable natural scrolling
defaults write -g com.apple.swipescrolldirection -bool true
echo "✅ Natural scrolling enabled"

# Enable three-finger drag
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
echo "✅ Three-finger drag enabled"

killall SystemUIServer 2>/dev/null || true

# Symlink dotfiles
echo "🔗 Symlinking dotfiles..."
ln -sf "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
ln -sf "$HOME/.dotfiles/.aliases" "$HOME/.aliases"
mkdir -p "$HOME/.config"
ln -sf "$HOME/.dotfiles/.config/starship.toml" "$HOME/.config/starship.toml"
mkdir -p "$HOME/.config/fish"
ln -sf "$HOME/.dotfiles/.config/fish/config.fish" "$HOME/.config/fish/config.fish"
ln -sfn "$HOME/.dotfiles/.config/lsd" "$HOME/.config/lsd"

# Exile the Dock (hide and disable animations)
echo "🛠 Configuring Dock..."
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock no-bouncing -bool true
defaults write com.apple.dock tilesize -int 16
# Remove pinned apps from Dock
defaults write com.apple.dock persistent-apps -array
killall Dock
echo "✅ Dock exiled"

