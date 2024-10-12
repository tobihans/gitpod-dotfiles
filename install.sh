#!/usr/bin/env bash

sudo apt update
sudo apt upgrade -y
sudo apt install -y luarocks

# Neovim
curl -fL --output /tmp/bob.zip https://github.com/MordechaiHadad/bob/releases/latest/download/bob-linux-x86_64.zip
unzip -d /tmp /tmp/bob.zip
sudo install -v /tmp/bob-linux-x86_64/bob /usr/local/bin/

mkdir -p ~/.local/share/bash-completion/completions ~/.config/bob
bob complete bash >> ~/.local/share/bash-completion/completions/bob
cat >~/.config/bob/config.json <<EOF
{
  "installation_location": "$HOME/.local/bin"
}
EOF

curl -fL https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz | gunzip > tree-sitter
chmod +x tree-sitter
sudo install -v ./tree-sitter /usr/local/bin/

bob use stable
