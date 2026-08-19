Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })

Set-Alias w wsl

function wd { wsl -d @args }

function wl { wsl -l @args }

function wu { wsl --unregister @args }

function wi { wsl --install Ubuntu --name @args }

Set-Alias h herdr
Set-Alias v nvim
Set-Alias c claude
Set-Alias gg lazygit
Set-Alias cz chezmoi
