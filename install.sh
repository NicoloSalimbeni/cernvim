#!/bin/bash 

mkdir -p ssh
mkdir -p nvim 

cp ~/.gitconfig .
cp -r ~/.config/nvim/* nvim/.

docker build --build-arg USER="$USER" -t cernvim .


# Define the target directory for executables
TARGET_DIR="$HOME/.local/bin"

# Ensure the target directory exists
mkdir -p "$TARGET_DIR"

# Make the script executable
chmod +x cernvim

# Move the script to the target directory
cp cernvim "$TARGET_DIR/"

# Verify the target directory is in PATH
if [[ ":$PATH:" != *":$TARGET_DIR:"* ]]; then
    echo "Adding $TARGET_DIR to PATH in your shell configuration file..."
    echo "export PATH=\"$TARGET_DIR:\$PATH\"" >> "$HOME/.bashrc"
    export PATH="$TARGET_DIR:$PATH"
fi

echo -e "\nInstallation complete. You can now use cernvim"
