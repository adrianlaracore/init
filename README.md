# Entorno de desarrollo

Bootstrap del entorno de dev de Adrian (WSL2 + fish) más las configuraciones (dotfiles) gestionadas con [chezmoi](https://www.chezmoi.io/).

## Cómo se ejecuta

```bash
git clone https://github.com/adrianlaracore/init.git ~/init && cd ~/init && bash install.sh
```

El script es idempotente: se puede volver a correr sin romper nada si ya tienes algunas herramientas instaladas.

## Qué instala `install.sh`

- Crea `~/desktop`, que queda como carpeta por defecto al abrir una terminal nueva
- **apt**: `zstd`, `zoxide`, `fzf`, `fish`, `lsd`, `unzip`, `zip`, `gcc`
- **neovim**: binario manual (appimage más reciente) en `/usr/local/bin/nvim`
- **lazygit**: binario manual (última release de GitHub) en `/usr/local/bin/lazygit`, con alias `gg`
- **Claude Code**, **herdr**, **superfile**, **chezmoi**, **croc**: vía sus instaladores oficiales por curl
- **fisher** + plugins de fish: `tide`, `autopair.fish`, `nvm.fish`
- **Node** (LTS) vía `nvm.fish`
- **tree-sitter-cli** vía `npm install -g`
- Aplica las configuraciones de este repo con `chezmoi init --apply` (queda en `~/.local/share/chezmoi`, no en `~/init`)
- Borra el clon de bootstrap `~/init`, ya que chezmoi hizo su propio clon

Al final imprime recordatorios de dos pasos manuales que no se automatizan desde el script:

1. Activar **WSL Integration** en Docker Desktop (Windows) → Settings → Resources.
2. **ollama** (opcional), con los modelos de Qwen recomendados:
   ```bash
   curl -fsSL https://ollama.com/install.sh | sh
   ollama pull qwen3-coder:30b-a3b       # tareas pesadas
   ollama pull qwen2.5-coder:1.5b-base   # autocompletado
   ```

## Aliases de fish

Definidos en `~/.config/fish/config.fish`:

| Alias | Comando |
|---|---|
| `ls` | `lsd --icon=auto -la --group-directories-first -t` |
| `h` | `herdr` |
| `v` | `nvim` |
| `c` | `claude` |
| `gg` | `lazygit` |
| `cz` | `chezmoi` |

El explorador de archivos por defecto es **superfile**, con su propio comando corto `spf` (no requiere alias adicional).

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
