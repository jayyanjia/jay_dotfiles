#!/bin/bash

echo "Sync time..."
sudo sntp -sS time.apple.com

echo "Check if Xcode Command Line Tools are installed..."
if ! command -v xcode-select &> /dev/null; then
    echo "Xcode Command Line Tools not found. Installing..."
    xcode-select --install
else
    echo "Xcode Command Line Tools already installed."
fi

echo "Disabling Natural Scrolling..."
defaults write -g com.apple.swipescrolldirection -bool false

echo "Setting Mouse Speed to 2.0..."
defaults write -g com.apple.mouse.scaling -float 2.0

echo "Enable dark mode..."
defaults write NSGlobalDomain AppleInterfaceStyle Dark

# Restart necessary apps to apply changes
echo "Applying changes..."
killall SystemUIServer
killall Finder
