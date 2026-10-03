#!/bin/bash
# Set up a Mac from scratch (or bring an existing one up to date). Safe to re-run.

set -euo pipefail

DOTFILES="$HOME/.dotfiles"

echo "🚀 Starting dotfiles bootstrap..."

# Xcode Command Line Tools (git, compilers; required by Homebrew)
if ! xcode-select -p &>/dev/null; then
    echo "🔧 Installing Xcode Command Line Tools..."
    xcode-select --install
    until xcode-select -p &>/dev/null; do sleep 5; done
fi

# Homebrew
if [ ! -x /opt/homebrew/bin/brew ]; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "📦 Installing packages from Brewfile..."
brew update
brew bundle --file="$DOTFILES/Brewfile"

# Symlink dotfiles into $HOME. Stow refuses to overwrite real files, so list
# any conflicts and let the user move them aside.
echo "🔗 Linking dotfiles..."
if ! stow --dir="$DOTFILES" --target="$HOME" --restow . ; then
    echo "⚠️  Stow found existing files in the way (listed above)."
    echo "   Move them aside (or into the repo) and re-run this script."
    exit 1
fi

echo "🛠 Applying macOS preferences..."
"$DOTFILES/macos.sh"

echo "🧰 Installing runtimes with mise..."
mise install

echo "✅ Done. Open a new terminal to load the new shell config."
