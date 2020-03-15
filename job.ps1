#powershell
# job.ps1
Write-Output 'OddsandEnds\job.ps1' >> ~\scheduled_jobs.log;
Get-Date -Format 'FileDateTimeUniversal' >> ~\scheduled_jobs.log;
$script_directory = $PSScriptRoot;
Write-Output $script_directory >> ~\scheduled_jobs.log;
Set-Location -Path $script_directory;
git add --all . >> ~\scheduled_jobs.log;
git commit -m 'job.ps1 auto commit' >> ~\scheduled_jobs.log;
if( $LastExitCode -eq 0 ){
	git push origin master >> ~\scheduled_jobs.log;
} else{
	git pull origin master >> ~\scheduled_jobs.log;
}
exit;
