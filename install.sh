#!/bin/bash

TIMEZONE=Asia/Tashkent

# Set system timezone
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
echo "$TIMEZONE" > /etc/timezone

# Update package list and install necessary packages
sudo apt update
sudo apt install git
sudo apt install zsh
sudo apt install curl
sudo apt install gcc
sudo apt install unzip

# Install Neovim itself
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz\nsudo rm -rf /opt/nvim\nsudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
echo "export PATH=\"$PATH:/opt/nvim-linux-x86_64/bin\"" >> $HOME/.zshrc

# Download and install the latest version of Java (JDK 24)
curl -O https://download.oracle.com/java/24/latest/jdk-24_linux-x64_bin.deb
sudo dpkg -i jdk-24_linux-x64_bin.deb

# Install NVM (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
# Install Node.js version 22 using NVM
nvm install 22

# Install Jvim project
git clone https://github.com/Israiloff/jvim.git $HOME/.config/nvim/

# Fixing markdown-preview.nvim dependency issues
npm install -g yarn
cd $HOME/.local/share/nvim/lazy/markdown-preview.nvim && yarn install

# Set up `pushall` alias for git
git config --global alias.pushall '!f() { for remote in $(git remote); do git push "$remote" "$@"; done; }; f'
