# Alfrix 2017
# Batch Convert SVG to PNG
param([string]$svg_path, [string]$png_path)
cd "$env:programfiles\Inkscape"

$svgs = Get-ChildItem $svg_path\* -Include *.svg
for ($i=0; $i -lt $svgs.Count; $i=$i+8) {
	if ($i -eq 0) {$i=$i+2; continue}
	$svg_fullname=$svgs[$i].fullname
	$svg_name=$svgs[$i].basename
	if (($svg_name -eq "bg") -OR ($svg_name -eq "bg2")) {
		.\inkscape.com -f "$svg_fullname"  -w=3840 -h=2160 -z -e="$png_path\$svg_name.png"
		continue
		}
	.\inkscape.com -f "$svg_fullname"  -w=256 -h=256 -z -e="$png_path\$svg_name.png"
}



