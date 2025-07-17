#!/bin/bash

sudo apt update
sudo apt install curl

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
sudo apt install zsh
exec zsh
sudo apt install git
sudo apt install gcc
sudo apt install unzip

# Install and configure Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="half-life"/g' ~/.zshrc

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

# Setup ZSH syntax highlighting
sudo apt install -y zsh-syntax-highlighting
echo "source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> $HOME/.zshrc

# Setup ZSH autosuggestions
sudo apt install -y zsh-autosuggestions
echo "source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> $HOME/.zshrc

# Synchronize Lazy.nvim plugins
nvim --headless "+Lazy! sync" +qa

# Fix markdown-preview.nvim dependency
npm install -g yarn
cd "$HOME/.local/share/nvim/lazy/markdown-preview.nvim" && yarn install

# Setup `pushall` alias for Git
git config --global alias.pushall '!f() { for remote in $(git remote); do git push "$remote" "$@"; done; }; f'
