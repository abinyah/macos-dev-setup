#!/bin/bash

# Initialize Git repository and prepare for GitHub

echo "Initializing Git repository..."

# Initialize git repository
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: macOS Developer Setup

- Interactive CLI setup script with colored output
- Homebrew installation and package management
- Essential development tools (Git, Node.js, Python, etc.)
- Development applications (VS Code, Cursor, Docker, etc.)
- Professional applications (1Password, Adobe Creative Suite, Final Cut Pro, etc.)
- Communication tools (Slack, Chrome, Zoom, etc.)
- Utilities (Maccy, Rectangle, Alfred, etc.)
- Shell configuration with zsh and plugins
- Comprehensive documentation and contributing guidelines"

echo ""
echo "Repository initialized successfully!"
echo ""
echo "Next steps:"
echo "1. Create a new repository on GitHub"
echo "2. Add the remote origin:"
echo "   git remote add origin https://github.com/YOUR_USERNAME/macos-dev-setup.git"
echo "3. Push to GitHub:"
echo "   git branch -M main"
echo "   git push -u origin main"
echo ""
echo "Then you can use this repository on any fresh macOS installation!"
