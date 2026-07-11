#!/usr/bin/env bash
set -euo pipefail

# herramientas que instalamos van a ~/.local/bin; lo exportamos ya mismo para
# que el resto de este script (chezmoi más abajo, etc.) las encuentre sin
# depender de que .profile se haya vuelto a leer.
export PATH="$HOME/.local/bin:$PATH"

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

echo "==> Claude Code"
curl -fsSL https://claude.ai/install.sh | bash

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

echo "==> variables universales de fish"
fish -c "set -U nvm_default_version v24.18.0"
fish -c "set -U tide_right_prompt_items status cmd_duration context jobs direnv bun node python rustc java php pulumi ruby go gcloud distrobox toolbox terraform aws nix_shell crystal elixir zig"

echo "==> shell por defecto: fish"
if [ "$SHELL" != "$(command -v fish)" ]; then
    chsh -s "$(command -v fish)"
    echo "Shell cambiado a fish (toma efecto en una terminal nueva)."
else
    echo "fish ya es el shell por defecto, se omite"
fi

echo "==> chezmoi: clonando y aplicando dotfiles"
chezmoi init --apply adrianlaracore/wsl-ubuntu-init

echo "==> ollama (opcional, al final)"
if ! command -v ollama >/dev/null 2>&1; then
    read -rp "ollama no está instalado. ¿Instalarlo junto con los modelos de Qwen (qwen3-coder:30b-a3b para tareas pesadas, qwen2.5-coder:1.5b-base para autocompletado)? [y/N] " install_ollama < /dev/tty
    if [[ "$install_ollama" =~ ^[Yy]$ ]]; then
        curl -fsSL https://ollama.com/install.sh | sh
        ollama pull qwen3-coder:30b-a3b
        ollama pull qwen2.5-coder:1.5b-base
    else
        echo "Se omite ollama."
    fi
else
    echo "ollama ya está instalado, se omite."
fi

cat <<'EOF'

==> Instalación completa. Abre una terminal nueva para entrar directo a fish
    con todo aplicado (alias, plugins, PATH).

Pasos manuales pendientes (no automatizables desde aquí):

  1. Docker Desktop (Windows) → Settings → Resources → WSL Integration
     → activa el toggle para esta distro.

  2. Si quieres Hermes o Pi, se instalan y configuran aparte
     (no están incluidos en este script).

EOF
