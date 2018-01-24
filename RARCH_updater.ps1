# Retroarch updater for Windows
# 
# Alfredo Monclús (2017)

cls

$buildbot="http://buildbot.libretro.com/nightly/windows/x86_64"
$rarch_location="$env:appdata\RetroArch\"

Start-BitsTransfer -Source $buildbot/RetroArch.7z -Destination $env:temp -TransferType Download

# Check if downloaded
if ($(Test-Path "$env:temp\RetroArch.7z"))
{
	& 'C:\Program Files\7-Zip\7z.exe' x "$env:temp\RetroArch.7z" -o$rarch_location -y
	rm $env:temp\RetroArch.7z
}
else
{
	Write-Host "FAILED to download" -ForegroundColor Red
}
sleep 3
pause