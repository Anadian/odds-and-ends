#powershell
# install.ps1
# Profile
New-Item -Type HardLink -Path ~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 -Value .\scripts\powershell\powershell_profile.ps1 -Force;
# VIM
New-Item -Type HardLink -Path ~\.vimrc -Value .\config\vimrc -Force;
New-Item -Type HardLink -Path ~\.expansions -Value .\scripts\vim\expansions.vim -Force;
# NVIM
New-Item -Type Directory -Path ~\AppData\local\nvim;
New-Item -Type HardLink -Path ~\AppData\local\nvim\init.vim -Value .\config\nvim_init.vim -Force;
