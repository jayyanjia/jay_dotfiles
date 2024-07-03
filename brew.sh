#!/bin/bash

# Define an array of packages to install using Homebrew
packages=(
    "git"
    "python"
    "pyenv"
)

# Define an array of applications to install using Homebrew Cask.
apps=(
    "google-chrome"
    "firefox"
    "visual-studio-code"
    "vlc"
    "rectangle"
    "iterm2"
)

# Define an array of fonts to install using Homebrew Cask.
fonts=(
    "font-fira-code"
    "font-source-code-pro"
)

# Function to check if a package is installed
is_installed() {
    brew list "$1" &> /dev/null
}

# Function to check if an application is installed
is_app_installed() {
    brew list --cask "$1" &> /dev/null
}

# Check if Homebrew is installed; if not, install it
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install packages using Homebrew
echo "Installing packages..."
for package in "${packages[@]}"; do
    if is_installed "$package"; then
        echo "$package is already installed"
    else
        echo "Installing $package..."
        brew install "$package"
    fi
done

# Install applications using Homebrew Cask
echo "Installing applications..."
for app in "${apps[@]}"; do
    if is_app_installed "$app"; then
        echo "$app is already installed"
    else
        echo "Installing $app..."
        brew install --cask "$app"
    fi
done

# Install fonts using Homebrew Cask
echo "Installing fonts..."
for font in "${fonts[@]}"; do
    if is_app_installed "$font"; then
        echo "$font is already installed"
    else
        echo "Installing $font..."
        brew install --cask "$font"
    fi
done

echo "All packages, applications, and fonts installed successfully."
