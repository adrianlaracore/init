#!/usr/bin/env bash
set -euo pipefail

# herramientas que instalamos van a ~/.local/bin; lo exportamos ya mismo para
# que el resto de este script (chezmoi más abajo, etc.) las encuentre sin
# depender de que .profile se haya vuelto a leer.
export PATH="$HOME/.local/bin:$PATH"

echo "==> carpeta desktop"
mkdir -p "$HOME/desktop"

echo "==> apt packages"
sudo apt update
sudo apt install -y zstd zoxide fzf fish lsd unzip zip gcc

echo "==> neovim (binario manual, no apt)"
if ! command -v nvim >/dev/null 2>&1; then
    tmp_appimage="$(mktemp)"
    curl -fsSL -o "$tmp_appimage" https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
    chmod u+x "$tmp_appimage"
    sudo mv "$tmp_appimage" /usr/local/bin/nvim
else
    echo "nvim ya está instalado, se omite"
fi

echo "==> lazygit (binario manual, no apt)"
if ! command -v lazygit >/dev/null 2>&1; then
    tmp_dir="$(mktemp -d)"
    lazygit_version="$(curl -fsSL "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')"
    curl -fsSL -o "$tmp_dir/lazygit.tar.gz" "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${lazygit_version}_Linux_x86_64.tar.gz"
    tar -xf "$tmp_dir/lazygit.tar.gz" -C "$tmp_dir" lazygit
    sudo install "$tmp_dir/lazygit" /usr/local/bin
    rm -rf "$tmp_dir"
else
    echo "lazygit ya está instalado, se omite"
fi

echo "==> Claude Code"
curl -fsSL https://claude.ai/install.sh | bash

echo "==> herdr"
curl -fsSL https://herdr.dev/install.sh | sh

echo "==> superfile"
bash -c "$(curl -sLo- https://superfile.dev/install.sh)"

echo "==> chezmoi"
if ! command -v chezmoi >/dev/null 2>&1; then
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
else
    echo "chezmoi ya está instalado, se omite"
fi

echo "==> croc"
if ! command -v croc >/dev/null 2>&1; then
    curl https://getcroc.schollz.com | bash
else
    echo "croc ya está instalado, se omite"
fi

echo "==> fisher + plugins"
fish -c "
    if not functions -q fisher
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
        fisher install jorgebucaran/fisher
    end
    fisher install ilancosman/tide@v6 jorgebucaran/autopair.fish jorgebucaran/nvm.fish
"

echo "==> Node vía nvm.fish"
# nvm use y el npm install van en el mismo `fish -c`: el PATH que arma
# `nvm use` es una variable global de ese proceso, no sobrevive a otra
# invocación de `fish -c` (y el auto-use de conf.d/nvm.fish solo corre en
# shells interactivos, que no es el caso acá).
fish -c "
    nvm install lts
    nvm use lts
    set -U nvm_default_version (nvm current)
    npm install -g tree-sitter-cli
"

echo "==> variables universales de fish"
fish -c "tide configure --auto --style=Lean --prompt_colors='True color' --show_time=No --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Sparse --icons='Many icons' --transient=No"
fish -c "set -U tide_right_prompt_items status cmd_duration context jobs direnv bun node python rustc java php pulumi ruby go gcloud distrobox toolbox terraform aws nix_shell crystal elixir zig"

echo "==> shell por defecto: fish"
# ojo: NO comparar contra $SHELL — esa variable refleja el shell desde el que
# se lanzó esta terminal (podría ser fish si entraste manual antes de correr
# el script), no el shell de login real registrado en el sistema.
current_login_shell="$(getent passwd "$USER" | cut -d: -f7)"
if [ "$current_login_shell" != "$(command -v fish)" ]; then
    # chsh normal pide contraseña por PAM, lo cual no funciona bien bajo
    # `curl | bash` (no hay tty interactivo). Usamos sudo en su lugar, que ya
    # tiene la sesión cacheada desde el `apt install` de más arriba.
    sudo usermod --shell "$(command -v fish)" "$USER"
    echo "Shell cambiado a fish (toma efecto en una terminal nueva)."
else
    echo "fish ya es el shell por defecto, se omite"
fi

echo "==> chezmoi: clonando y aplicando dotfiles"
chezmoi init --apply adrianlaracore/init

echo "==> limpiando clon de bootstrap"
# chezmoi ya hizo su propio clon en ~/.local/share/chezmoi; este ~/init
# solo servía para arrancar el script, así que ya no hace falta.
cd "$HOME"
rm -rf "$HOME/init"

cat <<'EOF'

==> Instalación completa. Abre una terminal nueva para entrar directo a fish
    con todo aplicado (alias, plugins, PATH).

Pasos manuales pendientes (no automatizables desde aquí):

  1. Docker Desktop (Windows) → Settings → Resources → WSL Integration
     → activa el toggle para esta distro.

  2. ollama (opcional), con los modelos de Qwen recomendados:
       curl -fsSL https://ollama.com/install.sh | sh
       ollama pull qwen3-coder:30b-a3b
       ollama pull qwen2.5-coder:1.5b-base

EOF
