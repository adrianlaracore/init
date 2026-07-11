# wsl-ubuntu-init

Bootstrap del entorno de dev de Adrian (WSL2 + fish) más las configuraciones (dotfiles) gestionadas con [chezmoi](https://www.chezmoi.io/).

## Cómo se ejecuta

```bash
git clone https://github.com/adrianlaracore/wsl-ubuntu-init.git ~/wsl-ubuntu-init
cd ~/wsl-ubuntu-init
bash install.sh
```

El script es idempotente: se puede volver a correr sin romper nada si ya tienes algunas herramientas instaladas.

## Qué instala `install.sh`

- **apt**: `zstd`, `zoxide`, `fzf`, `fish`, `lsd`
- **neovim**: binario manual (appimage más reciente) en `/usr/local/bin/nvim`
- **Claude Code**, **herdr**, **chezmoi**: vía sus instaladores oficiales por curl
- **fisher** + plugins de fish: `tide`, `autopair.fish`, `nvm.fish`
- **Node** (LTS) vía `nvm.fish`
- Aplica las configuraciones de este repo con `chezmoi init --apply`
- **ollama** (opcional, pregunta al final): si se confirma, también descarga los modelos `qwen3-coder:30b-a3b` (tareas pesadas) y `qwen2.5-coder:1.5b-base` (autocompletado)

Al final imprime recordatorios de pasos manuales que no se pueden automatizar desde WSL (activar WSL Integration en Docker Desktop, instalar Hermes/Pi si se quieren).

## Configuraciones incluidas (dotfiles vía chezmoi)

- **fish** (`~/.config/fish/`): `config.fish` (aliases, PATH, zoxide) y `fish_plugins` (lista de plugins de fisher)
- **herdr** (`~/.config/herdr/config.toml`): keybindings, tema y preferencias de UI

Se aplican automáticamente al final de `install.sh`. Para reaplicarlas manualmente en cualquier momento (por ejemplo después de editar algo en este repo):

```bash
chezmoi apply
```
