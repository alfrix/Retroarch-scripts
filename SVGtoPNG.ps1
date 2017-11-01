# Alfrix 2017
# Batch Convert SVG to PNG
$StartTime = $(get-date)

cd "$env:programfiles\Inkscape"

echo ""
Write-Host "Converting SVG to PNG" -ForegroundColor Green
echo ""

function svgtopng
{
	param([string]$svg_path, [string]$png_path)
	$svgs = Get-ChildItem $svg_path\* -Include *.svg
	for ($i=0; $i -lt $svgs.Count; $i++) {
		$svg_fullname=$svgs[$i].fullname
		$svg_name=$svgs[$i].basename
		#Write-Host "Processing ",$svg_path
		Write-Host "Processing ",$svg_name -ForegroundColor Yellow
		if (($svg_name -eq "bg") -OR ($svg_name -eq "bg2")) {
			.\inkscape.com -f "$svg_fullname"  -w=3840 -h=2160 -z -e="$png_path\$svg_name.png"
			continue
			}
		.\inkscape.com -f "$svg_fullname"  -w=256 -h=256 -z -e="$png_path\$svg_name.png"
	}
}

# svgtopng "input_path" "output_path"
# both paths must exist

svgtopng "D:\Documents\Github\Retrosystem-retroarch-theme\svg" "D:\Documents\Github\Retrosystem-retroarch-theme\png"


$elapsedTime = $(get-date) - $StartTime
$totalTime = "{0:HH:mm:ss}" -f ([datetime]$elapsedTime.Ticks)
echo $totalTime
pause