#!/usr/bin/env bash

# Neovim
curl -fL --output /tmp/bob.zip https://github.com/MordechaiHadad/bob/releases/latest/download/bob-linux-x86_64.zip
unzip -d /tmp /tmp/bob.zip
sudo install -v /tmp/bob-linux-x86_64/bob /usr/local/bin/

mkdir -p ~/.local/share/bash-completion/completions ~/.config/bob
bob complete bash >> ~/.local/share/bash-completion/completions/bob
cat >~/.config/bob/config.json <<EOF
{
  "downloads_location": "$HOME/.local/share/bob",
  "installation_location": "$HOME/.local/bin",
}
EOF

bob use stable
