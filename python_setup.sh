#!/bin/bash

set -e

echo "🛠️ Starting Python + VS Code setup on macOS..."

# 1. Install Homebrew if not present
if ! command -v brew &> /dev/null; then
  echo "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "✅ Homebrew is already installed."
fi

brew update

# 2. Install Python
echo "🐍 Installing Python..."
brew install python

# 3. Install uv
echo "⚡ Installing uv..."
brew install uv
eval "$(/opt/homebrew/bin/brew shellenv)"  # Just in case

# 4. Install VS Code
echo "🧠 Installing Visual Studio Code..."
brew install --cask visual-studio-code

# 5. Install Python tools using uv
echo "📦 Installing Python tools via uv..."
uv pip install \
  black ruff mypy pytest pre-commit ipython \
  httpx pydantic requests python-dotenv \
  cookiecutter taskipy

# 6. Install VS Code Python extension
echo "🧩 Installing Python extension for VS Code..."
code --install-extension ms-python.python

# (Optional) 7. Create a project folder and a uv-based virtual environment
# echo "📁 Setting up example project..."
# PROJECT_DIR="$HOME/python-project"
# mkdir -p "$PROJECT_DIR"
# cd "$PROJECT_DIR"
# uv venv
# source .venv/bin/activate

# Create example main.py
# echo 'print("Hello from Python + uv + VS Code!")' > main.py

# 8. Open project in VS Code
# echo "🚀 Opening project in VS Code..."
# code .

echo "🎉 Python development environment is ready!"
