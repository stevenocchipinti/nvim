#!/bin/bash

# Homebrew
if ! hash brew 2>/dev/null; then
  echo "You need brew, installing it now..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  (
    echo
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
  ) >>/Users/steve.occhipinti/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Setup dotfiles
brew install chezmoi
chezmoi --source ~/.dotfiles apply

# The important stuff
brew install fish git neovim

# Better tools
brew install zoxide fzf eza bat fd git-delta ripgrep gnu-sed wget

# Casks
brew install raycast ghostty visual-studio-code docker font-caskaydia-cove-nerd-font

# NodeJS
curl -fsSL https://fnm.vercel.app/install | bash
fish --command="fnm install --lts"
