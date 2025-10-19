#!/bin/bash

# macOS Developer Setup Script
# Author: Abinyah Walker
# Date: October 2025
# This script installs development tools and applications after a fresh macOS install
#
# DISCLAIMER: This script is provided "as is" without warranty of any kind.
# Use at your own risk. The author assumes no responsibility for any damage
# or issues that may arise from using this script.
# For comments or support, contact: info@mydmdi.com

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${PURPLE}================================${NC}"
    echo -e "${PURPLE}$1${NC}"
    echo -e "${PURPLE}================================${NC}"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if application is installed
app_exists() {
    [ -d "/Applications/$1" ]
}

# Function to install Homebrew
install_homebrew() {
    print_header "Installing Homebrew"
    
    if command_exists brew; then
        print_success "Homebrew is already installed"
        return 0
    fi
    
    print_status "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    
    print_success "Homebrew installed successfully"
}

# Function to install Xcode Command Line Tools
install_xcode_tools() {
    print_header "Installing Xcode Command Line Tools"
    
    if xcode-select -p >/dev/null 2>&1; then
        print_success "Xcode Command Line Tools already installed"
        return 0
    fi
    
    print_status "Installing Xcode Command Line Tools..."
    xcode-select --install
    
    print_warning "Please complete the Xcode Command Line Tools installation in the popup window"
    print_warning "Press any key to continue after installation is complete..."
    read -n 1 -s
}

# Function to install essential development tools
install_essential_tools() {
    print_header "Installing Essential Development Tools"
    
    local packages=(
        "git"
        "gh"  # GitHub CLI
        "node"
        "python@3.11"
        "ruby"
        "wget"
        "curl"
        "jq"
        "tree"
        "htop"
        "neofetch"
        "zsh"
        "zsh-autosuggestions"
        "zsh-syntax-highlighting"
    )
    
    for package in "${packages[@]}"; do
        if brew list "$package" >/dev/null 2>&1; then
            print_status "$package is already installed"
        else
            print_status "Installing $package..."
            brew install "$package"
        fi
    done
    
    print_success "Essential development tools installed"
}

# Function to install development applications
install_dev_apps() {
    print_header "Installing Development Applications"
    
    local apps=(
        "visual-studio-code"
        "cursor"
        "sublime-text"
        "postman"
        "figma"
        "docker"
        "ghostty"
    )
    
    for app in "${apps[@]}"; do
        if app_exists "${app//-/\ }"; then
            print_status "${app//-/\ } is already installed"
        else
            print_status "Installing ${app//-/\ }..."
            brew install --cask "$app"
        fi
    done
    
    print_success "Development applications installed"
}

# Function to install professional applications
install_professional_apps() {
    print_header "Installing Professional Applications"
    
    local apps=(
        "1password"
        "adobe-creative-cloud"
        "final-cut-pro"
        "logic-pro"
        "imovie"
        "garageband"
        "keynote"
        "pages"
        "numbers"
    )
    
    for app in "${apps[@]}"; do
        if app_exists "${app//-/\ }"; then
            print_status "${app//-/\ } is already installed"
        else
            print_status "Installing ${app//-/\ }..."
            brew install --cask "$app"
        fi
    done
    
    print_success "Professional applications installed"
}

# Function to install communication and productivity apps
install_communication_apps() {
    print_header "Installing Communication & Productivity Apps"
    
    local apps=(
        "slack"
        "google-chrome"
        "firefox"
        "zoom"
        "google-drive"
    )
    
    for app in "${apps[@]}"; do
        if app_exists "${app//-/\ }"; then
            print_status "${app//-/\ } is already installed"
        else
            print_status "Installing ${app//-/\ }..."
            brew install --cask "$app"
        fi
    done
    
    print_success "Communication & productivity apps installed"
}

# Function to install utilities
install_utilities() {
    print_header "Installing Utilities"
    
    local apps=(
        "maccy"
        "awesome-screenshot-and-recorder"
        "rectangle"
        "alfred"
        "cleanmymac"
    )
    
    for app in "${apps[@]}"; do
        if app_exists "${app//-/\ }"; then
            print_status "${app//-/\ } is already installed"
        else
            print_status "Installing ${app//-/\ }..."
            brew install --cask "$app"
        fi
    done
    
    print_success "Utilities installed"
}

# Function to setup shell configuration
setup_shell() {
    print_header "Setting up Shell Configuration"
    
    # Set zsh as default shell
    if [ "$SHELL" != "/bin/zsh" ] && [ "$SHELL" != "/opt/homebrew/bin/zsh" ]; then
        print_status "Setting zsh as default shell..."
        chsh -s /bin/zsh
    fi
    
    # Create .zshrc if it doesn't exist
    if [ ! -f ~/.zshrc ]; then
        print_status "Creating .zshrc..."
        touch ~/.zshrc
    fi
    
    # Add Homebrew to PATH
    if ! grep -q "brew shellenv" ~/.zshrc; then
        print_status "Adding Homebrew to PATH..."
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
    fi
    
    # Add zsh plugins
    if ! grep -q "zsh-autosuggestions" ~/.zshrc; then
        print_status "Adding zsh plugins..."
        echo 'source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
        echo 'source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc
    fi
    
    print_success "Shell configuration completed"
}

# Function to display menu
show_menu() {
    echo -e "${CYAN}"
    echo "=========================================="
    echo "    macOS Developer Setup Script"
    echo "=========================================="
    echo -e "${NC}"
    echo "This script will help you set up your macOS development environment."
    echo "You can choose which components to install:"
    echo ""
    echo "1. Essential Development Tools (Always installed)"
    echo "   - Homebrew, Xcode Command Line Tools, Git, Node.js, Python, etc."
    echo ""
    echo "2. Development Applications (Optional)"
    echo "   - VS Code, Cursor, Sublime Text, Postman, Figma, Docker, etc."
    echo ""
    echo "3. Professional Applications (Optional)"
    echo "   - 1Password, Adobe Creative Suite, Final Cut Pro, Logic Pro, etc."
    echo ""
    echo "4. Communication & Productivity (Optional)"
    echo "   - Slack, Chrome, Firefox, Zoom, Google Drive, etc."
    echo ""
    echo "5. Utilities (Optional)"
    echo "   - Maccy, Awesome Screenshot, Rectangle, Alfred, etc."
    echo ""
    echo "6. Install Everything (Recommended for first-time setup)"
    echo ""
    echo "7. View Author & Warranty Information"
    echo ""
    echo "8. System Analysis & Recommendations"
    echo ""
    echo "0. Exit"
    echo ""
}

# Function to get user choice
get_user_choice() {
    while true; do
        echo -n "Enter your choice (0-8): " >&2
        read -r choice
        case $choice in
            [0-8]) echo "$choice"; return ;;
            *) echo -e "${RED}Invalid choice. Please enter a number between 0-8.${NC}" >&2 ;;
        esac
    done
}

# Function to confirm installation
confirm_installation() {
    local category="$1"
    echo ""
    echo -e "${YELLOW}You have selected: $category${NC}"
    echo -n "Do you want to proceed? (y/N): "
    read -r confirm
    case $confirm in
        [Yy]|[Yy][Ee][Ss]) return 0 ;;
        *) return 1 ;;
    esac
}

# Function to display author and warranty information
show_author_info() {
    echo ""
    echo "=========================================="
    echo "    Author & Warranty Information"
    echo "=========================================="
    echo ""
    echo "Author: Abinyah Walker"
    echo "Date: October 2025"
    echo ""
    echo "DISCLAIMER:"
    echo "This script is provided 'as is' without warranty of any kind."
    echo "Use at your own risk. The author assumes no responsibility for any damage"
    echo "or issues that may arise from using this script."
    echo ""
    echo "For comments or support, contact: info@mydmdi.com"
    echo ""
}

# Function to analyze system and provide recommendations
analyze_system() {
    print_header "System Analysis & Recommendations"
    
    echo -e "${CYAN}Analyzing your system...${NC}"
    echo ""
    
    local recommendations=()
    local installed_count=0
    local total_count=0
    local missing_apps=()
    
    # First, let's see what's actually installed in /Applications
    echo -e "${YELLOW}📁 Scanning /Applications folder...${NC}"
    installed_apps=()
    if [ -d "/Applications" ]; then
        while IFS= read -r -d '' app; do
            app_name=$(basename "$app" .app)
            installed_apps+=("$app_name")
        done < <(find /Applications -maxdepth 1 -name "*.app" -print0 2>/dev/null)
    fi
    
    echo -e "Found ${#installed_apps[@]} applications in /Applications folder"
    echo ""
    
    # Check Homebrew
    echo -e "${YELLOW}Checking Homebrew...${NC}"
    if command_exists brew; then
        echo -e "  ${GREEN}✓${NC} Homebrew is installed"
        installed_count=$((installed_count + 1))
    else
        echo -e "  ${RED}✗${NC} Homebrew is not installed"
        recommendations+=("1")
    fi
    total_count=$((total_count + 1))
    
    # Check Xcode Command Line Tools
    echo -e "${YELLOW}Checking Xcode Command Line Tools...${NC}"
    if xcode-select -p >/dev/null 2>&1; then
        echo -e "  ${GREEN}✓${NC} Xcode Command Line Tools are installed"
        installed_count=$((installed_count + 1))
    else
        echo -e "  ${RED}✗${NC} Xcode Command Line Tools are not installed"
        recommendations+=("1")
    fi
    total_count=$((total_count + 1))
    
    # Check essential development tools
    echo -e "${YELLOW}Checking Essential Development Tools...${NC}"
    local essential_tools=("git" "node" "python3" "ruby" "wget" "curl" "jq" "tree" "htop")
    local missing_essential=()
    
    for tool in "${essential_tools[@]}"; do
        if command_exists "$tool"; then
            echo -e "  ${GREEN}✓${NC} $tool is installed"
        else
            echo -e "  ${RED}✗${NC} $tool is not installed"
            missing_essential+=("$tool")
        fi
    done
    
    if [ ${#missing_essential[@]} -gt 0 ]; then
        recommendations+=("1")
    fi
    
    # Check development applications with better matching
    echo -e "${YELLOW}Checking Development Applications...${NC}"
    local dev_apps=("Visual Studio Code" "Cursor" "Sublime Text" "Postman" "Figma" "Docker" "Ghostty" "iTerm2" "Hyper" "Insomnia" "DBeaver" "Sequel Pro" "MySQLWorkbench")
    local missing_dev=()
    local found_dev=()
    
    for app in "${dev_apps[@]}"; do
        local found=false
        for installed in "${installed_apps[@]}"; do
            if [[ "$installed" == *"$app"* ]] || [[ "$app" == *"$installed"* ]]; then
                echo -e "  ${GREEN}✓${NC} $app is installed (found: $installed)"
                found_dev+=("$app")
                found=true
                break
            fi
        done
        if [ "$found" = false ]; then
            echo -e "  ${RED}✗${NC} $app is not installed"
            missing_dev+=("$app")
        fi
    done
    
    if [ ${#missing_dev[@]} -gt 0 ]; then
        recommendations+=("2")
    fi
    
    # Check professional applications with better matching
    echo -e "${YELLOW}Checking Professional Applications...${NC}"
    local prof_apps=("1Password" "Adobe Creative Cloud" "Photoshop" "Lightroom" "Final Cut Pro" "Logic Pro" "iMovie" "GarageBand" "Keynote" "Pages" "Numbers" "Sketch" "Principle" "Framer")
    local missing_prof=()
    local found_prof=()
    
    for app in "${prof_apps[@]}"; do
        local found=false
        for installed in "${installed_apps[@]}"; do
            if [[ "$installed" == *"$app"* ]] || [[ "$app" == *"$installed"* ]]; then
                echo -e "  ${GREEN}✓${NC} $app is installed (found: $installed)"
                found_prof+=("$app")
                found=true
                break
            fi
        done
        if [ "$found" = false ]; then
            echo -e "  ${RED}✗${NC} $app is not installed"
            missing_prof+=("$app")
        fi
    done
    
    if [ ${#missing_prof[@]} -gt 0 ]; then
        recommendations+=("3")
    fi
    
    # Check communication apps with better matching
    echo -e "${YELLOW}Checking Communication & Productivity Apps...${NC}"
    local comm_apps=("Slack" "Google Chrome" "Chrome" "Firefox" "Zoom" "Google Drive" "Microsoft Office" "Word" "Excel" "PowerPoint" "Notion" "Obsidian" "Bear" "Todoist" "Toggl")
    local missing_comm=()
    local found_comm=()
    
    for app in "${comm_apps[@]}"; do
        local found=false
        for installed in "${installed_apps[@]}"; do
            if [[ "$installed" == *"$app"* ]] || [[ "$app" == *"$installed"* ]]; then
                echo -e "  ${GREEN}✓${NC} $app is installed (found: $installed)"
                found_comm+=("$app")
                found=true
                break
            fi
        done
        if [ "$found" = false ]; then
            echo -e "  ${RED}✗${NC} $app is not installed"
            missing_comm+=("$app")
        fi
    done
    
    if [ ${#missing_comm[@]} -gt 0 ]; then
        recommendations+=("4")
    fi
    
    # Check utilities with better matching
    echo -e "${YELLOW}Checking Utilities...${NC}"
    local util_apps=("Maccy" "Awesome Screenshot" "Rectangle" "Alfred" "CleanMyMac" "Bartender" "BetterTouchTool" "Karabiner" "Hazel" "Dropzone")
    local missing_util=()
    local found_util=()
    
    for app in "${util_apps[@]}"; do
        local found=false
        for installed in "${installed_apps[@]}"; do
            if [[ "$installed" == *"$app"* ]] || [[ "$app" == *"$installed"* ]]; then
                echo -e "  ${GREEN}✓${NC} $app is installed (found: $installed)"
                found_util+=("$app")
                found=true
                break
            fi
        done
        if [ "$found" = false ]; then
            echo -e "  ${RED}✗${NC} $app is not installed"
            missing_util+=("$app")
        fi
    done
    
    if [ ${#missing_util[@]} -gt 0 ]; then
        recommendations+=("5")
    fi
    
    # Calculate total installed apps
    local total_found=$(( ${#found_dev[@]} + ${#found_prof[@]} + ${#found_comm[@]} + ${#found_util[@]} ))
    local total_checked=$(( ${#dev_apps[@]} + ${#prof_apps[@]} + ${#comm_apps[@]} + ${#util_apps[@]} ))
    
    echo ""
    echo "=========================================="
    echo -e "${CYAN}ANALYSIS SUMMARY${NC}"
    echo "=========================================="
    echo -e "Core System: ${GREEN}$installed_count${NC} out of $total_count components"
    echo -e "Applications: ${GREEN}$total_found${NC} out of $total_checked checked"
    echo -e "Total Apps in /Applications: ${CYAN}${#installed_apps[@]}${NC}"
    echo ""
    
    if [ ${#recommendations[@]} -eq 0 ]; then
        echo -e "${GREEN}🎉 Congratulations! Your system appears to be fully set up.${NC}"
        echo -e "All major development tools and applications are installed."
    else
        echo -e "${YELLOW}📋 RECOMMENDATIONS:${NC}"
        echo ""
        
        # Remove duplicates and sort recommendations
        local unique_recommendations=($(printf '%s\n' "${recommendations[@]}" | sort -u))
        
        for rec in "${unique_recommendations[@]}"; do
            case $rec in
                1) echo -e "  ${CYAN}Option 1:${NC} Essential Development Tools - Install Homebrew, Xcode tools, and core development packages" ;;
                2) echo -e "  ${CYAN}Option 2:${NC} Development Applications - Install VS Code, Cursor, Docker, and other dev tools" ;;
                3) echo -e "  ${CYAN}Option 3:${NC} Professional Applications - Install 1Password, Adobe Creative Suite, Final Cut Pro, etc." ;;
                4) echo -e "  ${CYAN}Option 4:${NC} Communication & Productivity - Install Slack, Chrome, Zoom, and productivity apps" ;;
                5) echo -e "  ${CYAN}Option 5:${NC} Utilities - Install Maccy, Rectangle, Alfred, and system utilities" ;;
            esac
        done
        
        echo ""
        if [ ${#unique_recommendations[@]} -gt 3 ]; then
            echo -e "${PURPLE}💡 Tip:${NC} Consider running ${CYAN}Option 6 (Install Everything)${NC} for a complete setup"
        fi
    fi
    
    echo ""
    echo -e "${GREEN}Press any key to return to the main menu...${NC}"
    read -n 1 -s
}

# Main execution
main() {
    clear
    print_header "macOS Developer Setup"
    
    # Check if running on macOS
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "This script is designed for macOS only"
        exit 1
    fi
    
    # Check for admin privileges
    if [[ $EUID -eq 0 ]]; then
        print_error "Please don't run this script as root"
        exit 1
    fi
    
    while true; do
        show_menu
        choice=$(get_user_choice)
        
        case $choice in
            0)
                print_success "Setup cancelled by user"
                exit 0
                ;;
            1)
                if confirm_installation "Essential Development Tools"; then
                    install_homebrew
                    install_xcode_tools
                    install_essential_tools
                    setup_shell
                fi
                ;;
            2)
                if confirm_installation "Development Applications"; then
                    install_homebrew
                    install_dev_apps
                fi
                ;;
            3)
                if confirm_installation "Professional Applications"; then
                    install_homebrew
                    install_professional_apps
                fi
                ;;
            4)
                if confirm_installation "Communication & Productivity Apps"; then
                    install_homebrew
                    install_communication_apps
                fi
                ;;
            5)
                if confirm_installation "Utilities"; then
                    install_homebrew
                    install_utilities
                fi
                ;;
            6)
                if confirm_installation "Everything"; then
                    install_homebrew
                    install_xcode_tools
                    install_essential_tools
                    install_dev_apps
                    install_professional_apps
                    install_communication_apps
                    install_utilities
                    setup_shell
                    print_success "All components installed successfully!"
                fi
                ;;
            7)
                show_author_info
                ;;
            8)
                analyze_system
                ;;
        esac
        
        echo ""
        echo -n "Press any key to return to menu..."
        read -n 1 -s
        clear
    done
}

# Run main function
main "$@"
