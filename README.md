# Entorno de desarrollo

Bootstrap del entorno de dev de Adrian —**Windows** (vía `winget configure`) y **WSL2 + fish** (vía `install.sh`)— más las configuraciones (dotfiles) gestionadas con [chezmoi](https://www.chezmoi.io/). Ambos comandos aplican los dotfiles de este mismo repo; `home/.chezmoiignore` filtra automáticamente qué le corresponde a cada sistema operativo.

## 1. Windows

```powershell
git clone https://github.com/adrianlaracore/init.git ~/init && cd ~/init && winget configure -f configuration.dsc.yaml
```

### Qué instala `configuration.dsc.yaml`

- **winget**: `Git.Git`, `Microsoft.PowerShell`, `wez.wezterm`, `Neovim.Neovim`, `JesseDuffield.lazygit`, `CoreyButler.NVMforWindows`, `schollz.croc`, `twpayne.chezmoi`, `tree-sitter.tree-sitter-cli`, `Starship.Starship`, `ajeetdsouza.zoxide`
- **Claude Code** y **herdr** (beta en Windows): sin paquete winget oficial, se instalan con sus scripts propios
- Setea `XDG_CONFIG_HOME=%USERPROFILE%\.config` a nivel de usuario, para que Neovim (que en Windows por defecto busca su config en `%LOCALAPPDATA%\nvim`) use la misma carpeta `dot_config` que ya comparten WSL y Windows
- Aplica los dotfiles de Windows de este repo con `chezmoi init --apply` (queda en `~/.local/share/chezmoi`, no en `~/init`): WezTerm, perfil de PowerShell, herdr y nvim

## 2. WSL

```bash
git clone https://github.com/adrianlaracore/init.git ~/init && cd ~/init && bash install.sh
```

El script es idempotente: se puede volver a correr sin romper nada si ya tienes algunas herramientas instaladas.

### Qué instala `install.sh`

- Crea `~/desktop`, que queda como carpeta por defecto al abrir una terminal nueva
- **apt**: `zstd`, `zoxide`, `fzf`, `fish`, `lsd`, `unzip`, `zip`, `gcc`
- **neovim**: binario manual (appimage más reciente) en `/usr/local/bin/nvim`
- **lazygit**: binario manual (última release de GitHub) en `/usr/local/bin/lazygit`, con alias `gg`
- **Claude Code**, **herdr**, **superfile**, **chezmoi**, **croc**: vía sus instaladores oficiales por curl
- **fisher** + plugins de fish: `tide`, `autopair.fish`, `nvm.fish`
- **Node** (LTS) vía `nvm.fish`
- **tree-sitter-cli** vía `npm install -g`
- Aplica las configuraciones de este repo con `chezmoi init --apply` (queda en `~/.local/share/chezmoi`, no en `~/init`): fish, herdr y nvim
- Borra el clon de bootstrap `~/init`, ya que chezmoi hizo su propio clon

Al final imprime recordatorios de dos pasos manuales que no se automatizan desde el script:

1. Activar **WSL Integration** en Docker Desktop (Windows) → Settings → Resources.
2. **ollama** (opcional), con los modelos de Qwen recomendados:
   ```bash
   curl -fsSL https://ollama.com/install.sh | sh
   ollama pull qwen3-coder:30b-a3b       # tareas pesadas
   ollama pull qwen2.5-coder:1.5b-base   # autocompletado
   ```

## 3. Herramientas

### fish

Aliases definidos en `~/.config/fish/config.fish`:

| Alias | Comando |
|---|---|
| `ls` | `lsd --icon=auto -la --group-directories-first -t` |
| `h` | `herdr` |
| `v` | `nvim` |
| `c` | `claude` |
| `gg` | `lazygit` |
| `cz` | `chezmoi` |

El explorador de archivos por defecto es **superfile**, con su propio comando corto `spf` (no requiere alias adicional).

### herdr

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

### WezTerm (Windows)

Config en `~/.config/wezterm/wezterm.lua`, aplicada vía chezmoi. Modificador: `ctrl+alt`

| Acción | Tecla |
|---|---|
| Split vertical | `ctrl+alt+-` |
| Split horizontal | `ctrl+alt+=` |
| Cerrar pane | `ctrl+alt+q` |
| Toggle zoom | `ctrl+alt+z` |
| Foco izquierda | `ctrl+alt+h` |
| Foco abajo | `ctrl+alt+j` |
| Foco arriba | `ctrl+alt+k` |
| Foco derecha | `ctrl+alt+l` |
| Nueva tab | `ctrl+alt+t` |

### Perfil de PowerShell (Windows)

En `Documents/PowerShell/Microsoft.PowerShell_profile.ps1`, aplicado vía chezmoi. Inicializa el prompt de **starship** y **zoxide**, y define atajos para WSL además de los mismos alias que fish (salvo `ls`):

| Alias/función | Comando |
|---|---|
| `w` | `wsl` |
| `wd` | `wsl -d` |
| `wl` | `wsl -l` |
| `wu` | `wsl --unregister` |
| `wi` | `wsl --install Ubuntu --name` |
| `h` | `herdr` |
| `v` | `nvim` |
| `c` | `claude` |
| `gg` | `lazygit` |
| `cz` | `chezmoi` |
