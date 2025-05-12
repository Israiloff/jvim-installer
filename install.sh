#!/bin/bash

TIMEZONE=Asia/Tashkent

# Set system timezone
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
echo "$TIMEZONE" > /etc/timezone

sudo apt update
sudo apt install zsh
sudo exec zsh
sudo apt install git
sudo apt install curl
sudo apt install gcc
sudo apt install unzip

# Install and configure Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="half-life"/g' ~/.zshrc

# Install latest version of Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
echo "export PATH=\"$PATH:/opt/nvim-linux-x86_64/bin\"" >> $HOME/.zshrc

#Install Java
curl -O https://download.oracle.com/java/24/latest/jdk-24_linux-x64_bin.deb
sudo dpkg -i jdk-24_linux-x64_bin.deb

# install Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 22

# Clone Jvim project
git clone https://github.com/Israiloff/jvim.git $HOME/.config/nvim/

# Repair Markdown Preview plugin
npm install -g yarn
cd $HOME/.local/share/nvim/lazy/markdown-preview.nvim && yarn install

# Setup `pushall` alias for Git
git config --global alias.pushall '!f() { for remote in $(git remote); do git push "$remote" "$@"; done; }; f'

# Setup ZSH syntax highlighting
apt install -y zsh-syntax-highlighting
echo "source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> $HOME/.zshrc

# Setup ZSH autosuggestions
apt install -y zsh-autosuggestions
echo "source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> $HOME/.zshrc

# Synchronize Lazy.nvim plugins
nvim --headless "+Lazy! sync" +qa
