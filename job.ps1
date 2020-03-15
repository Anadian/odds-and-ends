#powershell
# job.ps1
echo 'OddsandEnds\job.ps1' >> ~\scheduled_jobs.log;
Get-Date -Format 'FileDateTimeUniversal' >> ~\scheduled_jobs.log;

