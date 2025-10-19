# macOS Developer Setup

A comprehensive script to set up your macOS development environment after a fresh install. This repository contains everything you need to quickly restore your development tools, applications, and configurations.

## Features

- 🍺 **Homebrew Installation**: Automatically installs Homebrew package manager
- 🛠️ **Developer Tools**: Installs Xcode Command Line Tools, Git, and essential development utilities
- 📱 **Applications**: Installs popular developer and professional applications
- ⚙️ **Configuration**: Sets up shell configurations and development environments
- 🎨 **Professional Tools**: Installs Adobe Creative Suite, Final Cut Pro, and other professional applications
- 🔧 **Customizable**: Interactive CLI with options to select what to install

## Quick Start

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/macos-dev-setup.git
   cd macos-dev-setup
   ```

2. Make the script executable:
   ```bash
   chmod +x setup.sh
   ```

3. Run the setup script:
   ```bash
   ./setup.sh
   ```

## What Gets Installed

### Development Tools
- Homebrew (package manager)
- Xcode Command Line Tools
- Git and GitHub CLI
- Node.js, Python, Ruby
- Docker Desktop
- VS Code, Cursor, Sublime Text
- Postman, Figma
- Terminal applications (Ghostty)

### Professional Applications
- 1Password
- Adobe Creative Suite (Photoshop, Lightroom Classic)
- Final Cut Pro
- Logic Pro
- iMovie, GarageBand
- Microsoft Office alternatives (Keynote, Pages, Numbers)

### Communication & Productivity
- Slack
- Google Chrome, Firefox
- Google Workspace (Docs, Sheets, Slides, Drive)
- Zoom

### Utilities
- Maccy (clipboard manager)
- Awesome Screenshot & Recorder

## Customization

The script is designed to be interactive. You can choose which categories of applications to install:

- **Essential Development Tools** (always installed)
- **Additional Development Tools** (optional)
- **Professional Applications** (optional)
- **Communication & Productivity** (optional)
- **Utilities** (optional)

## Requirements

- macOS 10.15 (Catalina) or later
- Administrator privileges
- Internet connection

## Manual Installation

If you prefer to install applications manually, check the `applications/` directory for individual installation scripts for each category.

## Contributing

Feel free to submit issues and enhancement requests!

## License

MIT License - see LICENSE file for details.
