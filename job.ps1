#powershell
# job.ps1
Write-Output 'OddsandEnds\job.ps1' >> ~\scheduled_jobs.log;
Get-Date -Format 'FileDateTimeUniversal' >> ~\scheduled_jobs.log;
$script_directory = $PSScriptRoot;
Write-Output $script_directory;
Set-Location -Path $script_directory;
git add --all .;
git commit -m 'job.ps1 auto commit';
if( $LastExitCode -eq 0 ){
	git push origin master;
} else{
	git pull origin master;
}
