# Entorno de desarrollo

Bootstrap del entorno de dev de Adrian —**Windows** (vía `winget configure`) y **WSL2 + fish** (vía `setup.sh`)— más las configuraciones (dotfiles) gestionadas con [chezmoi](https://www.chezmoi.io/). Ambos comandos aplican los dotfiles de este mismo repo; `home/.chezmoiignore` filtra automáticamente qué le corresponde a cada sistema operativo.

## 1. Windows

Si tu versión de winget es vieja y `winget configure` no anda, primero hay que habilitar el experimental feature (en versiones nuevas ya viene estable y este paso no hace falta — se puede chequear con `winget features`):

```powershell
winget settings
# agregar en el json:
# "experimentalFeatures": { "configuration": true }
```

```powershell
git clone https://github.com/adrianlaracore/init.git ~/init && winget configure -f ~/init/setup.dsc.yaml --accept-configuration-agreements --disable-interactivity ; Remove-Item -Recurse -Force ~/init
```

Las flags `--accept-configuration-agreements --disable-interactivity` evitan el prompt interactivo donde winget pide aceptar que la configuración va a instalar software y cambiar settings — sin ellas, el comando se queda esperando que confirmes a mano.

> Importante: no hagas `cd ~/init` antes de correr `winget configure`, y no muevas el borrado de `~/init` adentro del propio `setup.dsc.yaml` — `winget configure` deja su propio proceso con esa carpeta como directorio de trabajo mientras corre (para poder resolver rutas relativas dentro de la config), así que cualquier intento de borrarla desde un resource del mismo config choca con `IOException: ... being used by another process`. Por eso el borrado va al final del comando, después de que winget ya cerró y soltó el lock.

### Qué instala `setup.dsc.yaml`

- **winget**: `Git.Git`, `Microsoft.PowerShell`, `wez.wezterm`, `Neovim.Neovim`, `JesseDuffield.lazygit`, `CoreyButler.NVMforWindows`, `schollz.croc`, `twpayne.chezmoi`, `tree-sitter.tree-sitter-cli`, `Starship.Starship`, `ajeetdsouza.zoxide`, `Microsoft.Coreutils`, `sharkdp.fd`, `BurntSushi.ripgrep.MSVC`, `BrechtSanders.WinLibs.POSIX.UCRT`
- **fd** y **ripgrep**: los usa el picker de archivos/grep de `snacks.nvim` (prioriza `fd`/`rg` antes que `find`/`grep`)
- **WinLibs (mingw-w64 gcc)**: sirve como compilador C para que `nvim-treesitter` compile los parsers en Windows. Además de instalarlo, el YAML setea `CC` (a nivel de usuario) apuntando a su `gcc.exe` y agrega `mingw64\bin` al `PATH`, porque `tree-sitter build` en Windows por defecto intenta usar `cl.exe` (MSVC) sin importar qué compilador tengas instalado, a menos que `CC` esté seteado explícitamente
- Apenas se instala `nvm`, corre `nvm install lts` y `nvm use lts` para dejar Node activo sin pasos manuales
- **Claude Code** y **herdr** (beta en Windows): sin paquete winget oficial, se instalan con sus scripts propios
- Setea `XDG_CONFIG_HOME=%USERPROFILE%\.config` a nivel de usuario, para que Neovim (que en Windows por defecto busca su config en `%LOCALAPPDATA%\nvim`) use la misma carpeta `dot_config` que ya comparten WSL y Windows
- Aplica los dotfiles de Windows de este repo con `chezmoi init --apply` (queda en `~/.local/share/chezmoi`, no en `~/init`): WezTerm, perfil de PowerShell, herdr y nvim

El borrado del clon de bootstrap `~/init` **no** está en el YAML (a diferencia de `setup.sh` en WSL) — va como último paso del comando de instalación, por la razón explicada arriba.

> **Importante**: `CC` y `XDG_CONFIG_HOME` quedan seteadas como variables de usuario en el registro de Windows, pero cualquier terminal que ya estuviera abierta (incluso la misma desde la que corriste `winget configure`) sigue viendo el entorno viejo — Windows no les avisa que hay variables nuevas. Cerrá la terminal por completo y abrí una nueva antes de usar `nvim`.

## 2. WSL

```bash
git clone https://github.com/adrianlaracore/init.git ~/init && cd ~/init && bash setup.sh
```

El script es idempotente: se puede volver a correr sin romper nada si ya tienes algunas herramientas instaladas.

### Qué instala `setup.sh`

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
