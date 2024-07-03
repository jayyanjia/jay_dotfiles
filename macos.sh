#!/bin/bash

# Sync time
sudo sntp -sS time.apple.com

# Check if Xcode Command Line Tools are installed
if ! command -v xcode-select &> /dev/null; then
    echo "Xcode Command Line Tools not found. Installing..."
    xcode-select --install
else
    echo "Xcode Command Line Tools already installed."
fi

# Disable natural scroll direction
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Enable dark mode
defaults write NSGlobalDomain AppleInterfaceStyle Dark

# Restart necessary apps to apply changes
killall SystemUIServer
killall Finder
