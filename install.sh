#!/usr/bin/env bash
set -euo pipefail

echo "==> apt packages"
sudo apt update
sudo apt install -y zstd zoxide fzf fish lsd

echo "==> neovim (binario manual, no apt)"
if ! command -v nvim >/dev/null 2>&1; then
    tmp_appimage="$(mktemp)"
    curl -fsSL -o "$tmp_appimage" https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
    chmod u+x "$tmp_appimage"
    sudo mv "$tmp_appimage" /usr/local/bin/nvim
else
    echo "nvim ya está instalado, se omite"
fi

echo "==> yazi"
sudo snap install yazi --classic

echo "==> Claude Code"
curl -fsSL https://claude.ai/install.sh | bash

echo "==> ollama"
curl -fsSL https://ollama.com/install.sh | sh

echo "==> herdr"
curl -fsSL https://herdr.dev/install.sh | sh

echo "==> chezmoi"
if ! command -v chezmoi >/dev/null 2>&1; then
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
else
    echo "chezmoi ya está instalado, se omite"
fi

echo "==> fisher + plugins"
fish -c "
    if not functions -q fisher
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
        fisher install jorgebucaran/fisher
    end
    fisher install ilancosman/tide jorgebucaran/autopair.fish jorgebucaran/nvm.fish
"

echo "==> Node vía nvm.fish"
fish -c "nvm install lts"

echo "==> chezmoi: clonando y aplicando dotfiles"
chezmoi init --apply adrianlaracore/wsl-ubuntu-init

cat <<'EOF'

==> Instalación completa. Pasos manuales pendientes (no automatizables desde aquí):

  1. Docker Desktop (Windows) → Settings → Resources → WSL Integration
     → activa el toggle para esta distro.

  2. Si quieres Hermes o Pi, se instalan y configuran aparte
     (no están incluidos en este script).

EOF
