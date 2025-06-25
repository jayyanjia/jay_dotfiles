#!/bin/bash

# Exit on error
set -e

echo "🔧 Starting macOS setup..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null
then
    echo "📦 Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "✅ Homebrew is already installed."
fi

echo "🔄 Updating Homebrew..."
brew update

echo "🍺 Installing apps via Homebrew Cask..."

brew install --cask google-chrome
brew install --cask firefox
brew install --cask brave-browser
brew install --cask visual-studio-code
brew install --cask rectangle
brew install --cask iterm2
brew install --cask vlc

echo "🎉 All apps installed successfully!"
