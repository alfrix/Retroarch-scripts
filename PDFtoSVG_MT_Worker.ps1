# Alfrix 2017
#
# Batch Convert Ai PDF to SVG
param([string]$pdf_path, [string]$svg_path, [int]$job_total, [int]$this_job)

cd "$env:programfiles\Inkscape"

$pdfs = Get-ChildItem $pdf_path\* -Include *.pdf
for ($i=$this_job; $i -lt $pdfs.Count; $i=$i+$job_total) {
	$pdf_fullname=$pdfs[$i].fullname
	$pdf_name=$pdfs[$i].basename
	.\inkscape.com -f "$pdf_fullname" -D -z -l="$svg_path\$pdf_name.svg"
	
	#alternative to inkscape
	#.\pdf2svg.exe "$pdf_fullname" "$svg_path\$pdf_name.svg"
	
	# the next bit is here to fix baxys pdfs which are in points
	if (($svg_name -eq "bg") -OR ($svg_name -eq "bg2")) {continue}
	$fix =  Get-Content "$svg_path\$pdf_name.svg"
	$fix=$fix -Replace 'width="341.33334"', 'width="256"'
	$fix=$fix -Replace 'height="341.33334"', 'height="256"'
	#$fix=$fix -Replace '256pt', '256' #for https://github.com/dawbarton/pdf2svg
	Set-Content -Path "$svg_path\$pdf_name.svg" -Value $fix
}
