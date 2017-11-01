# Alfrix 2017
#
# Batch Convert SVG to PNG
param([string]$svg_path, [string]$png_path, [int]$job_total, [int]$this_job)
cd "$env:programfiles\Inkscape"

$svgs = Get-ChildItem $svg_path\* -Include *.svg
for ($i=$this_job; $i -lt $svgs.Count; $i=$i+$job_total) {
	$svg_fullname=$svgs[$i].fullname
	$svg_name=$svgs[$i].basename
	if (($svg_name -eq "bg") -OR ($svg_name -eq "bg2")) {
		.\inkscape.com -f "$svg_fullname"  -w=3840 -h=2160 -z -e="$png_path\$svg_name.png"
		continue
		}
	.\inkscape.com -f "$svg_fullname"  -w=256 -h=256 -z -e="$png_path\$svg_name.png"
}
