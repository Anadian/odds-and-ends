#powershell
# remove_duplicate_helpfiles.ps1 by SavindraSingh from https://serverfault.com/questions/313570/powershell-2-how-to-eliminate-duplicate-help-entries
$sys32Help = Get-ChildItem -Path "C:\Windows\System32\WindowsPowerShell\v1.0\en-US\" -Filter {*help*}
$sys32ModHelp = Get-ChildItem -Path "C:\Windows\System32\WindowsPowerShell\v1.0\Modules" -Filter {*help*} -Recurse -File
$compare = Compare-Object -ReferenceObject $sys32Help -DifferenceObject $sys32ModHelp -Property name -IncludeEqual
$compEQ = $compare | where sideIndicator -eq == | Select name | %{ $_.Name }
$sys32ModHelp | ?{ $_.Name -in $compEQ } | %{ Remove-Item -Path $_.FullName -Force -ErrorAction SilentlyContinue}
