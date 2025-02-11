#!/bin/bash

# Define paths
DOTFILES_DIR="$HOME/repos/dotfiles"
SYMLINKS=(
  "$DOTFILES_DIR/nvim:$HOME/.config/nvim"
  "$DOTFILES_DIR/ghostty:$HOME/.config/ghostty/config"
  "$DOTFILES_DIR/.zshrc:$HOME/.zshrc"
  "$DOTFILES_DIR/.gitconfig:$HOME/.gitconfig"
)

# Function to create or update symlink
create_symlink() {
  local source="$1"
  local target="$2"

  if [ -e "$target" ]; then
    # If the target exists (file or directory), remove it
    echo "Removing existing target: $target"
    rm -rf "$target"
  fi

  # Create the new symlink
  ln -s "$source" "$target"
  echo "Created symlink: $target -> $source"
}

# Loop through the symlinks and create/update them
for symlink in "${SYMLINKS[@]}"; do
  IFS=":" read -r source target <<< "$symlink"
  create_symlink "$source" "$target"
done

