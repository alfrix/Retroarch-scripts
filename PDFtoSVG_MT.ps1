# Alfrix 2017
# 
# Batch Convert PDF to SVG
[int]$jobs=4

$StartTime = $(get-date)
echo ""
Write-Host "Converting Ai PDFs to SVG" -ForegroundColor Green
echo ""
get-date -format T
echo ""

function pdftosvg
{
	param([string]$input_folder, [string]$output_folder)
	Write-Host "Processing ",$input_folder -ForegroundColor Yellow
	for ($i=0; $i -lt $jobs; $i++){
		$args = @($input_folder,$output_folder,$jobs,$i) 
		Start-Job -FilePath .\PDFtoSVG_MT_Worker.ps1 -ArgumentList $args
	}
}

#pdftosvg input_folder output_folder
$mainfolder="D:\Downloads\baxy-retroarch-themes-master"
pdftosvg "$mainfolder\retroactive\pdf" "$mainfolder\retroactive\svg"
Get-Job | Wait-Job # wait the jobs to finish to start another batch
pdftosvg "$mainfolder\retroactive\pdf_marked" "$mainfolder\retroactive\svg_marked"
Get-Job | Wait-Job
pdftosvg "$mainfolder\systematic\pdf" "$mainfolder\systematic\svg"
Get-Job | Wait-Job
pdftosvg "$mainfolder\monochrome_contributions\pdf" "$mainfolder\monochrome_contributions\svg"
Get-Job | Wait-Job
pdftosvg "$mainfolder\neoactive\pdf" "$mainfolder\neoactive\svg"
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