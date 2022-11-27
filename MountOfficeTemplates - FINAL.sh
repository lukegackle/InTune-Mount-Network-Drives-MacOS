#!/bin/bash
# Script created by Luke Gackle to Map Network Drives and set Office Template workgroup location
# function to delay until the user has finished setup assistant.
waitForDesktop () {
  until ps aux | grep /System/Library/CoreServices/Dock.app/Contents/MacOS/Dock | grep -v grep &>/dev/null; do
    delay=$(( $RANDOM % 50 + 10 ))
    echo "$(date) |  + Dock not running, waiting [$delay] seconds"
    sleep $delay
  done
  echo "$(date) | Dock is here, lets carry on"
}
waitForDesktop
smbcmd="smb://$LOGNAME@192.168.1.1/Folder"
mntcmd="mount volume \"$smbcmd\""
/usr/bin/osascript -e $mntcmd
sleep 50
if [ -d "/Volumes/Folder" ]; then
  echo "DIRECTORY does exist.";
  #Optionally: If the directory contains Office templates, uncomment the following line to map the path to Word
  #defaults write com.microsoft.office DocsUICustomWorkgroupTemplatesLocationKey -string "/Volumes/Folder";
fi