# wsl-ubuntu-init

Bootstrap del entorno de dev de Adrian (WSL2 + fish) más las configuraciones (dotfiles) gestionadas con [chezmoi](https://www.chezmoi.io/).

## Cómo se ejecuta

```bash
git clone https://github.com/adrianlaracore/wsl-ubuntu-init.git ~/wsl-ubuntu-init
cd ~/wsl-ubuntu-init
bash install.sh
```

**Nota:** no correr como `curl | bash`. El script tiene pasos interactivos (contraseña de sudo, confirmación de ollama) que necesitan una terminal real — bajo un pipe, el stdin queda ocupado por el propio script y esos pasos fallan silenciosamente.

El script es idempotente: se puede volver a correr sin romper nada si ya tienes algunas herramientas instaladas.

## Qué instala `install.sh`

- **apt**: `zstd`, `zoxide`, `fzf`, `fish`, `lsd`
- **neovim**: binario manual (appimage más reciente) en `/usr/local/bin/nvim`
- **Claude Code**, **herdr**, **chezmoi**: vía sus instaladores oficiales por curl
- **fisher** + plugins de fish: `tide`, `autopair.fish`, `nvm.fish`
- **Node** (LTS) vía `nvm.fish`
- Aplica las configuraciones de este repo con `chezmoi init --apply`
- **ollama** (opcional, pregunta al final): si se confirma, también descarga los modelos `qwen3-coder:30b-a3b` (tareas pesadas) y `qwen2.5-coder:1.5b-base` (autocompletado)

Al final imprime un recordatorio de un paso manual que no se puede automatizar desde WSL: activar WSL Integration en Docker Desktop.

## herdr

Prefix: `ctrl+space`

| Acción | Tecla |
|---|---|
| Split horizontal | `prefix+minus` |
| Split vertical | `prefix+=` |
| Settings | `prefix+comma` |
| Nueva tab | `prefix+shift+n` |
| Tab anterior | `prefix+shift+j` |
| Tab siguiente | `prefix+shift+k` |
| Cerrar tab | `prefix+shift+q` |
| Renombrar tab | `prefix+shift+r` |
| Detach | `` prefix+` `` |
| Cerrar pane | `prefix+q` |
| Nuevo workspace | `prefix+alt+n` |
| Renombrar workspace | `prefix+alt+r` |
| Cerrar workspace | `prefix+alt+q` |
| Workspace anterior | `prefix+alt+k` |
| Workspace siguiente | `prefix+alt+j` |
| Cambiar a workspace N | `prefix+1..9` |
| Copy mode | `prefix+y` |
| Toggle sidebar | `prefix+tab` |

Tema: `gruvbox`. Config completa en `~/.config/herdr/config.toml`, aplicada vía chezmoi.
