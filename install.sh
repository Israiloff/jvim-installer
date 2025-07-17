#!/bin/bash

# Update package list and install curl
sudo apt update -y
sudo apt install -y curl

# Download the .env file
curl -O https://raw.githubusercontent.com/Israiloff/jvim-installer/master/.env

set -e

# Load .env
if [ -f ".env" ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo ".env file not found!"
  exit 1
fi

# Set system timezone
sudo ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

# Install necessary packages
sudo apt install -y git
sudo apt install -y gcc
sudo apt install -y unzip

# Install Neovim
curl -LO "https://github.com/neovim/neovim/releases/${NEOVIM_VERSION}/download/nvim-linux-x86_64.tar.gz"
rm -rf /opt/nvim
tar -C /opt -xzf nvim-linux-x86_64.tar.gz
echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> "$HOME/.zshrc"

# Install Java (JDK)
curl -O "https://download.oracle.com/java/${JAVA_VERSION}/latest/jdk-${JAVA_VERSION}_linux-x64_bin.deb"
sudo dpkg -i "jdk-${JAVA_VERSION}_linux-x64_bin.deb"

# Install NVM and Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1090
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install "$NODE_VERSION"

# Install Jvim
git clone https://github.com/Israiloff/jvim.git "$HOME/.config/nvim/"

# Synchronize Lazy.nvim plugins
nvim --headless "+Lazy! sync" +qa

# Fix markdown-preview.nvim dependency
npm install -g yarn
cd "$HOME/.local/share/nvim/lazy/markdown-preview.nvim" && yarn install
