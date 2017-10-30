# Retroarch Test playlist generator for Windows
# 
# Alfredo Monclús (2017)

cls

# Location variables

$assets_path="$env:appdata\retroarch\assets\xmb\monochrome\png"
$playlist_path="$env:appdata\retroarch\playlists"
$systems = Get-ChildItem $assets_path -File *.png

mkdir "$playlist_path\all" -force

for ($i=0; $i -lt $systems.Count; $i++) {

	# the assets that have -content contain the name of the system
	if (-not($systems[$i].name.Contains("-content"))) {continue}
	if ($systems[$i].name.Contains("favorites")) {continue}
	
	$systemname=$systems[$i].basename

	# cut -content
	$systemname = $systemname.Substring(0,$systemname.Length -8)

	# create playlists
	if(-not(Test-Path "$playlist_path\all\$systemname.lpl")){		
		
		Write-output $systemname
		
		# put some empty content in the playlists
		for ($j=0; $j -lt 3; $j++){

			# Retroarch doesn't like unicode
			Write-output "DETECT" | out-file -append -encoding ascii "$playlist_path\all\$systemname.lpl"
			Write-output "TEST" | out-file -append -encoding ascii "$playlist_path\all\$systemname.lpl"
			for ($l=0; $l -lt 3; $l++){
				Write-output "DETECT" | out-file -append -encoding ascii "$playlist_path\all\$systemname.lpl"
			}
			Write-output "$systemname.lpl" | out-file -append -encoding ascii "$playlist_path\all\$systemname.lpl"
		}
	}
}
echo "Done"
start explorer $playlist_path\all
