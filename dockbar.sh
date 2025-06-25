#!/bin/bash

# Application name, e.g., "Safari", "Mail", "Notes"
APP_NAME="$1"

if [ -z "$APP_NAME" ]; then
  echo "Usage: $0 <Application Name>"
  exit 1
fi

# Get the path to the app
APP_PATH=$(mdfind "kMDItemKind == 'Application'" | grep -i "/${APP_NAME}.app$" | head -n 1)

if [ -z "$APP_PATH" ]; then
  echo "Application '$APP_NAME' not found."
  exit 1
fi

# Escape slashes for use in sed
ESCAPED_APP_PATH=$(echo "$APP_PATH" | sed 's/\//\\\//g')

# Backup Dock plist
cp ~/Library/Preferences/com.apple.dock.plist ~/Library/Preferences/com.apple.dock.plist.backup

# Remove the app from persistent-apps
defaults read com.apple.dock persistent-apps | \
  plutil -convert xml1 - -o - | \
  sed "/$ESCAPED_APP_PATH/d" | \
  plutil -convert binary1 - -o ~/Library/Preferences/com.apple.dock.plist

# Restart the Dock
killall Dock

echo "Removed '$APP_NAME' from the Dock."
