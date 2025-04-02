#!/bin/bash

set -e  # Exit on error

# Define variables
JDK_VERSION=21
PYTHON_VERSION=3
TIMEZONE=Asia/Tashkent

# Update system and install dependencies
apt update -y
apt upgrade -y
apt install -y tzdata
apt install -y zip
apt install -y unzip
apt install -y curl
apt install -y openjdk$JDK_VERSION
apt install -y maven
apt install -y git
apt install -y npm
apt install -y yarn
apt install -y neovim
apt install -y zsh
apt install -y build-base
apt install -y libc6-compat
apt install -y gcc
apt install -y g++
apt install -y make
apt install -y cargo

# Set system timezone
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
echo "$TIMEZONE" > /etc/timezone

# Change default shell to ZSH
chsh -s /bin/zsh

# Install and configure Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="half-life"/g' ~/.zshrc
apt install -y zsh-vcs

echo "export SHELL=/bin/zsh" >> $HOME/.zshrc

# Git configuration
git config --global alias.pushall '!f() { for remote in $(git remote); do git push "$remote" "$@"; done; }; f'

# Install JVIM
mkdir -p ~/.config/nvim
git clone --depth 1 --branch master https://github.com/Israiloff/jvim.git ~/.config/nvim
nvim --headless "+Lazy! sync" +qa

# Repair Markdown Preview
cd $HOME/.local/share/nvim/lazy/markdown-preview.nvim && yarn install

# Setup ZSH syntax highlighting
apt install -y zsh-syntax-highlighting
echo "source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> $HOME/.zshrc

# Setup ZSH autosuggestions
apt install -y zsh-autosuggestions
echo "source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> $HOME/.zshrc
