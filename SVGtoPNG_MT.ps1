# Alfrix 2017
# Batch Convert SVG to PNG
$paths = @("D:\Documents\Github\Retrosystem-retroarch-theme\svg","D:\Documents\Github\Retrosystem-retroarch-theme\png") 
$StartTime = $(get-date)

echo ""
Write-Host "Converting SVG to PNG" -ForegroundColor Green
echo ""
get-date -format T
echo ""
Start-Job -FilePath .\SVGtoPNG_Jobs\Job1.ps1 -ArgumentList $paths
Start-Job -FilePath .\SVGtoPNG_Jobs\Job2.ps1 -ArgumentList $paths
Start-Job -FilePath .\SVGtoPNG_Jobs\Job3.ps1 -ArgumentList $paths
Start-Job -FilePath .\SVGtoPNG_Jobs\Job4.ps1 -ArgumentList $paths
Start-Job -FilePath .\SVGtoPNG_Jobs\Job5.ps1 -ArgumentList $paths
Start-Job -FilePath .\SVGtoPNG_Jobs\Job6.ps1 -ArgumentList $paths
Start-Job -FilePath .\SVGtoPNG_Jobs\Job7.ps1 -ArgumentList $paths
Start-Job -FilePath .\SVGtoPNG_Jobs\Job8.ps1 -ArgumentList $paths
 
#Wait for all jobs
Get-Job | Wait-Job
 
#Get all job results
Get-Job | Receive-Job | Out-GridView


$elapsedTime = $(get-date) - $StartTime
$totalTime = "{0:HH:mm:ss}" -f ([datetime]$elapsedTime.Ticks)
echo ""
get-date -format T
echo ""
echo $totalTime

pause