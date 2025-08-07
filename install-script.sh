#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Remove welcome message 
touch .hushlogin

# Update the system's package list and upgrade all installed packages.
pkg update && pkg upgrade -y

# List of packages to install.
pkg_packages=(
  stow
  neovim
  python
  wol
  zoxide
  speedtest-go
  zsh
  starship
)

echo "Installing required packages: ${pkg_packages[*]}..."
# The -y flag automatically answers yes to prompts.
pkg install -y "${pkg_packages[@]}"

# ---
# Dotfiles Setup
# ---

# Directory where your dotfiles are located.
DOTFILES_DIR="$HOME/dotfiles-termux"

# List of dotfiles to symlink using stow.
stow_packages=(
  nvim
  zshrc
  starship
)

echo "Attempting to set up dotfiles..."
# Check if the dotfiles directory exists.
if [ -d "$DOTFILES_DIR" ]; then
  # Change into the dotfiles directory to run stow.
  cd "$DOTFILES_DIR" || { echo "Error: Could not enter $DOTFILES_DIR"; exit 1; }

  # Loop through the list of stow packages.
  for package in "${stow_packages[@]}"; do
    # Check if the subdirectory for the package exists before trying to stow it.
    if [ -d "$package" ]; then
      echo "Stowing $package..."
      # --restow is useful for updating existing symlinks.
      stow --restow --target="$HOME" "$package"
    else
      # If the directory doesn't exist, print a warning and continue.
      echo "Warning: Package directory '$package' not found in '$DOTFILES_DIR'. Skipping."
    fi
  done
else
  # If the dotfiles directory doesn't exist, print a warning and skip the whole section.
  echo "Warning: Dotfiles directory '$DOTFILES_DIR' not found. Skipping stow setup."
fi

# Change shell to zsh
chsh -s zsh

# Installation complete
echo "Installation complete!"
