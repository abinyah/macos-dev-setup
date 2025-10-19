# macOS Developer Setup - Zsh Configuration

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="robbyrussell"

# Plugins to load
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    colored-man-pages
    command-not-found
)

# Load Oh My Zsh
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
    source $ZSH/oh-my-zsh.sh
fi

# Homebrew
if [[ $(uname -m) == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Add Homebrew to PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# Node.js
export NODE_PATH="/opt/homebrew/lib/node_modules"
export PATH="/opt/homebrew/bin/node:$PATH"

# Python
export PATH="/opt/homebrew/bin/python3:$PATH"
export PATH="/opt/homebrew/lib/python3.11/bin:$PATH"

# Ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"

# Git
export GIT_EDITOR="code --wait"

# Aliases
alias ll="ls -la"
alias la="ls -la"
alias l="ls -l"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias c="clear"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# Git aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline"
alias gd="git diff"
alias gb="git branch"
alias gco="git checkout"
alias gcm="git checkout main"
alias gcb="git checkout -b"

# Development aliases
alias serve="python3 -m http.server"
alias py="python3"
alias pip="pip3"
alias node="node"
alias npm="npm"
alias yarn="yarn"

# macOS specific
alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES && killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO && killall Finder"
alias flushdns="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder"

# Functions
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Load additional configurations
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
