#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Remove welcome message 
touch ~/.hushlogin

# Create zshrc file
touch ~/.zshrc

# Setup storage
termux-setup-storage

# Setup mirrors
termux-change-repo

# Update the system's package list and upgrade all installed packages.
pkg update && pkg upgrade -y

# List of packages to install.
pkg_packages=(
  stow
  neovim
  wol
  zoxide
  speedtest-go
  zsh
  starship
  ripgrep
  fd
  netcat-openbsd
)

echo "Installing required packages: ${pkg_packages[*]}..."
pkg install -y "${pkg_packages[@]}"


# Dotfiles Setup
DOTFILES_DIR="$HOME/dotfiles-termux"

# List of dotfiles to symlink using stow.
stow_packages=(
  nvim
  zshrc
  starship
)

# Set up dotfiles
echo "Setting up dotfiles..."
if [[ -d "$DOTFILES_DIR" ]]; then
  cd "$DOTFILES_DIR" || { echo "Error: Could not enter $DOTFILES_DIR"; exit 1; }

  # Loop through the list of stow packages.
  for package in "${stow_packages[@]}"; do
    if [[ -d "$package" ]]; then
      echo "Stowing $package..."
      stow --restow --target="$HOME" "$package"
    else
      echo "Warning: Package directory '$package' not found in '$DOTFILES_DIR'. Skipping."
    fi
  done
else
  echo "Warning: Dotfiles directory '$DOTFILES_DIR' not found. Skipping stow setup."
fi

# Change shell to zsh
chsh -s zsh

# install zsh plugins
mkdir -p ~/.zsh/plugins
cd ~/.zsh/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git


# Installation complete
echo "Installation complete!"
