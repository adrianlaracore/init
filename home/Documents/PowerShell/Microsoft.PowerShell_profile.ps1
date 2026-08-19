Invoke-Expression (&starship init powershell)

Set-Alias w wsl

function wd { wsl -d @args }

function wl { wsl -l @args }

function wu { wsl --unregister @args }

function wi { wsl --install Ubuntu --name @args }
