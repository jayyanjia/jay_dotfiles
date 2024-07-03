#!/bin/bash

# Clear all Dock items
defaults write com.apple.dock persistent-apps -array empty

# Add specific apps to persistent apps
apps=(
  "Finder"
  "System Preferences"
  "Safari"
  "Google Chrome"
  "Visual Studio Code"
  "iTerm"
)

for app in "${apps[@]}"; do
  # Get path to the application
  app_path=$(osascript -e "tell application \"System Events\" to get the path of (path to application \"$app\")")
  
  # Add app to persistent apps
  defaults write com.apple.dock persistent-apps -array-add string:"$app_path"
done

# Kill Dock process to refresh (optional)
killall Dock
