#!/bin/bash

# List of allowed applications (case-sensitive, as found in /Applications or ~/Applications)
ALLOWED_APPS=("Safari" "Calendar" "Notes" "System Settings" "Terminal")

# Function to generate Dock entry for a given app
generate_dock_entry() {
  local app_name="$1"
  local app_path=$(mdfind "kMDItemKind == 'Application'" | grep -i "/${app_name}.app$" | head -n 1)

  if [ -z "$app_path" ]; then
    echo "Warning: $app_name not found."
    return
  fi

  echo "
    <dict>
      <key>tile-data</key>
      <dict>
        <key>file-data</key>
        <dict>
          <key>_CFURLString</key>
          <string>file://${app_path}</string>
          <key>_CFURLStringType</key>
          <integer>15</integer>
        </dict>
      </dict>
      <key>tile-type</key>
      <string>file-tile</string>
    </dict>"
}

# Begin writing new Dock plist content
NEW_ITEMS=""
for app in "${ALLOWED_APPS[@]}"; do
  NEW_ITEMS+=$(generate_dock_entry "$app")
done

# Assemble complete plist structure
PLIST_CONTENT="<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\">
<dict>
  <key>persistent-apps</key>
  <array>
    $NEW_ITEMS
  </array>
</dict>
</plist>"

# Backup current Dock plist
DOCK_PLIST=~/Library/Preferences/com.apple.dock.plist
cp "$DOCK_PLIST" "${DOCK_PLIST}.backup.$(date +%s)"

# Write new plist to temporary file and convert to binary
echo "$PLIST_CONTENT" > /tmp/new_dock.plist
plutil -convert binary1 /tmp/new_dock.plist -o "$DOCK_PLIST"

# Restart the Dock
killall Dock

echo "Dock updated. Only the following apps are kept: ${ALLOWED_APPS[*]}"
