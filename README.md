# Entorno de desarrollo

Bootstrap del entorno de dev de Adrian (WSL2 + fish) más las configuraciones (dotfiles) gestionadas con [chezmoi](https://www.chezmoi.io/).

## Cómo se ejecuta

```bash
git clone https://github.com/adrianlaracore/init.git ~/init && cd ~/init && bash install.sh
```

El script es idempotente: se puede volver a correr sin romper nada si ya tienes algunas herramientas instaladas.

## Qué instala `install.sh`

- **apt**: `zstd`, `zoxide`, `fzf`, `fish`, `lsd`
- **neovim**: binario manual (appimage más reciente) en `/usr/local/bin/nvim`
- **Claude Code**, **herdr**, **chezmoi**: vía sus instaladores oficiales por curl
- **fisher** + plugins de fish: `tide`, `autopair.fish`, `nvm.fish`
- **Node** (LTS) vía `nvm.fish`
- Aplica las configuraciones de este repo con `chezmoi init --apply`

Al final imprime recordatorios de dos pasos manuales que no se automatizan desde el script:

1. Activar **WSL Integration** en Docker Desktop (Windows) → Settings → Resources.
2. **ollama** (opcional), con los modelos de Qwen recomendados:
   ```bash
   curl -fsSL https://ollama.com/install.sh | sh
   ollama pull qwen3-coder:30b-a3b       # tareas pesadas
   ollama pull qwen2.5-coder:1.5b-base   # autocompletado
   ```

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
