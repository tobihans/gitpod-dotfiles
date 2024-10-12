#!/usr/bin/env bash

sudo apt update
sudo apt upgrade -y
sudo apt install -y luarocks

# Neovim
install_neovim() {
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux64.tar.gz

    # shellcheck disable=2016
    echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >>~/.bashrc

    wget -O /tmp/main.zip https://github.com/tobihans/dotfiles/archive/refs/heads/main.zip
    unzip /tmp/main.zip -d /tmp
    cp -r /tmp/dotfiles-main/dot_config/nvim/ ~/.config/nvim
}

install_treesitter() {
    # Tree-sitter
    curl -fL https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz | gunzip >tree-sitter
    chmod +x tree-sitter
    sudo install -v ./tree-sitter /usr/local/bin/
}

install_gh_cli() {
    (type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) &&
        sudo mkdir -p -m 755 /etc/apt/keyrings &&
        wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null &&
        sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg &&
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
        sudo apt update &&
        sudo apt install gh -y
}

install_gh_cli & install_neovim & install_treesitter
