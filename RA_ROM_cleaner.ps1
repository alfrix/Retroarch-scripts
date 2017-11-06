# Alfredo Monclús
cls
#
##
### Carpeta con roms

$rom_path="G:\Emuladores\ROMS"

###
##
#
$logfile=$rom_path+"\rom_cleanup.log"
$logfile2=$rom_path+"\thumb_cleanup.log"
$playlist_path="$env:appdata\RetroArch\playlists"

echo "-- $(date) --" >> "$logfile"
echo "-- $(date) --" >> "$logfile2"

function limpiar
{
	#limpiar subcarpeta_de_roms playlist
	param([string]$roms_path, [string]$playlist_name)
	
	Write-Host "Limpiando",$playlist_name -ForegroundColor yellow
	$roms_path=$rom_path+$roms_path
	$playlist=$playlist_path+"\"+$playlist_name+".lpl"
	$roms = Get-ChildItem $roms_path\* -Include *.7z, *.zip
	for ($i=0; $i -lt $roms.Count; $i++)
    {
		#rom clean
		$romname=$roms[$i].name
        if ("$romname" -like "neogeo.*") {continue}
		if ("$romname" -like "qsound.*") {continue}
		if ("$romname" -clike "*BIOS*") {continue}
		
		$playlist_item=$(Select-String -path "$playlist" -quiet -simplematch "$romname")
		if (-not $playlist_item )
		{
			rm $roms[$i].fullname
			Write-output $roms[$i].fullname`t"Fue eliminado " >> $logfile
			Write-Host $roms[$i].name,"Fue eliminado" -ForegroundColor Red
			
			
		}
	}
	for ($i=0; $i -lt 3; $i++) 
	{

		#thumbnail clean
		if ($i -eq 0) {$thumb_path="$env:appdata\RetroArch\thumbnails\"+$playlist_name+"\Named_Boxarts"}
		if ($i -eq 1) {$thumb_path="$env:appdata\RetroArch\thumbnails\"+$playlist_name+"\Named_Snaps"}
		if ($i -eq 2) {$thumb_path="$env:appdata\RetroArch\thumbnails\"+$playlist_name+"\Named_Titles"}
		$thumb = Get-ChildItem $thumb_path\* -Include *.png
		for ($j=0; $j -lt $thumb.Count; $j++)
		{
			$thumbname=$thumb[$j].name.split(".")[0]
			$thumbname=$thumbname.split("_")[0]
			$playlist_item=$(Select-String -literalpath "$playlist" -quiet -simplematch "$thumbname")
			if (-not $playlist_item )
			{
				rm $thumb[$j].fullname
				Write-output $playlist_name`t$thumbname`t"Miniatura eliminada " >> $logfile2
				Write-Host $playlist_name,$thumb[$j].name,"Miniatura eliminada" -ForegroundColor Magenta
			}
		}
	}
}

#limpiar "subcarpeta_de_roms" "nombre de la playlist"

limpiar "\MAME\Arcade - Action" "Arcade - Action"
limpiar "\MAME\Arcade - BeatEmUp" "Arcade - BeatEmUp"
limpiar "\MAME\Arcade - Driving" "Arcade - Driving"
limpiar "\MAME\Arcade - Fighting" "Arcade - Fighting"
limpiar "\MAME\Arcade - Mature" "Arcade - Mature"
limpiar "\MAME\Arcade - Maze" "Arcade - Maze"
limpiar "\MAME\Arcade - Misc" "Arcade - Misc"
limpiar "\MAME\Arcade - Platform" "Arcade - Platform"
limpiar "\MAME\Arcade - PlatformSingle" "Arcade - PlatformSingle"
limpiar "\MAME\Arcade - Puzzle" "Arcade - Puzzle"
limpiar "\MAME\Arcade - Sports" "Arcade - Sports"
limpiar "\MAME\Arcade - STGHori" "Arcade - STGHori"
limpiar "\MAME\Arcade - STGMisc" "Arcade - STGMisc"
limpiar "\MAME\Arcade - STGSingle" "Arcade - STGSingle"
limpiar "\MAME\Arcade - STGVert" "Arcade - STGVert"
limpiar "\MAME\Arcade - Lightgun" "Arcade - Lightgun"
limpiar "\N64" "Nintendo - Nintendo 64"
limpiar "\GBA" "Nintendo - Game Boy Advance"
limpiar "\GENESIS" "Sega - Mega Drive - Genesis"
limpiar "\NES" "Nintendo - Nintendo Entertainment System"
limpiar "\SNES" "Nintendo - Super Nintendo Entertainment System"

echo "Finished"
sleep 4