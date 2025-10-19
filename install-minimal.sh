#!/bin/bash

# Minimal macOS Developer Setup
# Quick installation script for essential tools only

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Install Homebrew
if ! command -v brew &> /dev/null; then
    print_status "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi

# Install Xcode Command Line Tools
if ! xcode-select -p &> /dev/null; then
    print_status "Installing Xcode Command Line Tools..."
    xcode-select --install
    print_status "Please complete the installation in the popup window"
fi

# Install essential packages
print_status "Installing essential packages..."
brew install git node python@3.11 wget curl jq tree htop

# Install essential applications
print_status "Installing essential applications..."
brew install --cask visual-studio-code cursor docker

print_success "Minimal setup complete!"
print_status "Run './setup.sh' for full installation options"
