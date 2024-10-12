#!/usr/bin/env bash

sudo apt update
sudo apt upgrade -y
sudo apt install -y luarocks

# Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# shellcheck disable=2016
echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/.bashrc

# Tree-sitter
curl -fL https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz | gunzip > tree-sitter
chmod +x tree-sitter
sudo install -v ./tree-sitter /usr/local/bin/

wget -O /tmp/main.zip https://github.com/tobihans/dotfiles/archive/refs/heads/main.zip
unzip  /tmp/main.zip -d /tmp
cp -r /tmp/dotfiles-main/dot_config/nvim/ ~/.config/nvim
