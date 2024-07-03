#!/bin/bash

# Remove all items from the Dock
defaults delete com.apple.dock persistent-apps
defaults delete com.apple.dock persistent-others

# Add Finder to the Dock
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="file-tile"; "tile-data" = {"file-label"="Finder";}}'

# Add System Preferences to the Dock
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="file-tile"; "tile-data" = {"file-label"="System Preferences";}}'

# Add Safari to the Dock
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="file-tile"; "tile-data" = {"file-label"="Safari";}}'

# Function to check if an application exists
app_exists() {
    if [ -d "/Applications/$1.app" ]; then
        return 0  # Application exists
    else
        return 1  # Application does not exist
    fi
}

# Add Google Chrome if it exists
if app_exists "Google Chrome"; then
    defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="file-tile"; "tile-data" = {"file-label"="Google Chrome";}}'
fi

# Add Visual Studio Code if it exists
if app_exists "Visual Studio Code"; then
    defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="file-tile"; "tile-data" = {"file-label"="Visual Studio Code";}}'
fi

# Add iTerm2 if it exists
if app_exists "iTerm"; then
    defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="file-tile"; "tile-data" = {"file-label"="iTerm";}}'
fi

# Restart the Dock to apply changes
killall Dock

# To revert to the default Dock configuration later:
# defaults delete com.apple.dock persistent-apps
# killall Dock






