# Jvim Installer for Debian 12 OS

## Overview

The Jvim Installer provides a script to set up a fully configured [Neovim](https://neovim.io) Java IDE environment directly on your system. It includes JDK, Python, and essential development tools, along with pre-configured Neovim settings for an optimized coding experience.

## Getting Started

### 1. Install Jvim Using One Command

Run the following command to install Jvim on your system:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Israiloff/jvim-installer/master/install.sh)"
```

### 2. Manual Installation

If you prefer to download and install manually, use:

```sh
wget https://raw.githubusercontent.com/Israiloff/jvim-installer/master/install.sh -O install.sh
chmod +x install.sh
./install.sh
```

### 3. Launching Jvim

Once installed, you can start Neovim by running:

```sh
nvim
```

## Features

- Pre-configured [Neovim](https://neovim.io) with Java support.
- Includes [Maven](https://maven.apache.org/), [Git](https://git-scm.com/), and other essential development tools.
- Zsh shell with [Oh My Zsh](https://ohmyz.sh/) for enhanced productivity.
- Syntax highlighting and autosuggestions for an improved terminal experience.

## Customization

You can customize Jvim by modifying the configurations in `~/.config/nvim` or adding new plugins to enhance your workflow.

## Support

For any issues or further improvements, visit the [Jvim Installer repository](https://github.com/Israiloff/jvim-installer).
