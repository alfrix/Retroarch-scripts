# Retroarch Core updater for Windows
#
# Based on linux script of github.com/cpinkus
# 
# Alfredo Monclús (2017)

cls

# Location variables
$cores_url="http://buildbot.libretro.com/nightly/windows/x86_64/latest"
$cores_path="$env:appdata\retroarch\cores"
$logfile="$env:appdata\retroarch\cores\cores_updater.log"

# Prepare files
if(-not(Test-Path "$cores_path\.timestamps.old")){$null > "$cores_path\.timestamps.old"}
if(-not(Test-Path "$cores_path\.timestamps.new")){$null > "$cores_path\.timestamps.new"}
mv "$cores_path\.timestamps.new" "$cores_path\.timestamps.old" -Force
# Grab timestamps from URL
Start-BitsTransfer -Source $cores_url/.index-extended -Destination $cores_path\.timestamps.new -TransferType Download

# Check if downloaded
if ($(Test-Path "$cores_path\.timestamps.new"))
{

	# New logfile entry
	echo "-- $(date) --" >> "$logfile"

	# Download and replace cores
	$cores = Get-ChildItem $cores_path -File *.dll
	for ($i=0; $i -lt $cores.Count; $i++) {
		if (-not($cores[$i].name.Contains("_libretro"))) {continue}
		$corename=$cores[$i].name
		$timestamp_old=$(Get-Content "$cores_path\.timestamps.old" | Select-String -simplematch $corename)
		$timestamp_new=$(Get-Content "$cores_path\.timestamps.new"| Select-String -simplematch $corename)
		$current_timestamp=$timestamp_new.ToString($timestamp_new).Split(" ")[0]
		if ( "$timestamp_new" -eq "$timestamp_old" )
		{
			Write-Host $current_timestamp,"SKIPPED ",$corename -ForegroundColor Gray
			Write-output $current_timestamp`t"SKIPPED "`t$corename >> $logfile
			continue
		}

		$core_full_url=$cores_url + "/" + $corename + ".zip"
		Start-BitsTransfer -Source $core_full_url -Destination $cores_path\$corename.zip -TransferType Download
		
		# Check if downloaded
		if ($(Test-Path $cores_path\$corename.zip))
		{
			rm $corename
			Expand-Archive "$cores_path\$corename.zip" "$cores_path" -force
			rm "$cores_path\$corename.zip"
				
			
			Write-Host $current_timestamp,"UPDATED ",$corename  -ForegroundColor Green
			Write-output $current_timestamp`t"UPDATED "`t$corename >> $logfile
		}
		else
		{
			Write-Host $current_timestamp,"FAILED ",$corename  -ForegroundColor Red
			Write-output $current_timestamp`t"FAILED "`t$corename >> $logfile
		}

	}
	echo "Done"
}
else
{
	Write-Host "FAILED to download timestamps" -ForegroundColor Red
}

sleep 4
pause
