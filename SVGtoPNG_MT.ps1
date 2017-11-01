# Alfrix 2017
# 
# Batch Convert SVG to PNG
[int]$jobs=4
[string]$input_folder="D:\Documents\Github\Retrosystem-retroarch-theme\svg"
[string]$output_folder="D:\Documents\Github\Retrosystem-retroarch-theme\png"
$StartTime = $(get-date)
echo ""
Write-Host "Converting SVG to PNG" -ForegroundColor Green
echo ""
get-date -format T
echo ""
for ($i=0; $i -lt $jobs; $i++){
	$args = @($input_folder,$output_folder,$jobs,$i) 
	Start-Job -FilePath .\SVGtoPNG_MT_Worker.ps1 -ArgumentList $args
}

 
Get-Job | Wait-Job

$elapsedTime = $(get-date) - $StartTime
$totalTime = "{0:HH:mm:ss}" -f ([datetime]$elapsedTime.Ticks)
echo ""
get-date -format T
echo ""
echo $totalTime
echo ""
echo "Show results?"
pause

Get-Job | Receive-Job | Out-GridView
pause