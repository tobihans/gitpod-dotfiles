#!/usr/bin/env bash
# shellcheck disable=2016

sudo apt update
sudo apt upgrade -y
sudo apt install -y luarocks

# Neovim
install_neovim() {
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux64.tar.gz

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
    wget https://github.com/cli/cli/releases/download/v2.58.0/gh_2.58.0_linux_amd64.tar.gz
    tar -xzvf gh_2.58.0_linux_amd64.tar.gz
    sudo install -v gh_2.58.0_linux_amd64/bin/gh /usr/local/bin/
}

install_mise() {
    mkdir -p ~/.config/mise
    cp ./mise.toml ~/.config/mise/config.toml
    curl https://mise.run | sh
    echo 'eval "$(~/.local/bin/mise activate bash)"' >>~/.bashrc
}

setup_aliases_n_commands() {
    cat <<EOF >>~/.bashrc
setup_base() {
    mise install
    false; while [[ "$?" -ne "0" ]]; do nvim --headless +q; done
    nvim --headless +"e /tmp/test.txt" +"sleep 30" +SupermavenUseFree +q
}
alias nvim='mise exec -- nvim'
EOF
}

install_gh_cli &
install_neovim &
install_treesitter &
install_mise &
setup_aliases_n_commands

wait
