#!/bin/bash

echo "🧼 Removing all Dock apps and folders..."
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-others -array

echo "↪️ Moving Dock to the left side of the screen..."
defaults write com.apple.dock orientation -string left

echo "🔍 Setting Dock size to 40..."
defaults write com.apple.dock tilesize -int 40

echo "♻️ Restarting Dock to apply changes..."
killall Dock

echo "✅ Done! Dock is now empty, on the left, and set to size 40."
