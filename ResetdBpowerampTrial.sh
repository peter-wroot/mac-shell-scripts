#!/bin/bash

# Clears the terminal window.
clear

# Find existing dBpoweramp process if it's running and kills it.
dBpowerampPID=`ps x | grep "[d]Bpoweramp Music Converter" | awk '{print $1}'`
if [ -z "$dBpowerampPID" ]
then
	echo -e "dBpoweramp is not currently running. Good to go!\n"
else
	echo -e "dBpoweramp is currently running. Killing process...\n"
	kill -9 $dBpowerampPID
fi

# Locates the 'dBpoweramp' directory in the user's Library.
homeDirectory=`printenv HOME`
fullPath="${homeDirectory}/Library/dBpoweramp"
backupFileName="dBpoweramp - `date`.zip"

if [ -d $fullPath ]
then
	# Zips up the 'dBpoweramp' directory and places it in the root of the user's Library.
	echo -e "Backing up existing ${fullPath} directory... \n"
	zip -r "${homeDirectory}/Library/${backupFileName}" $fullPath
	echo -e "\nBacked up to ${homeDirectory}/Library/${backupFileName}\n"

	# Deletes the 'dBpoweramp' directory
	echo -e "Deleting ${fullPath}...\n"
	rm -rf $fullPath
else
	echo -e "Cannot find ${fullPath}. Do you have dbPoweramp installed?\n"
fi

# Opens a new instance of dBpoweramp
echo -e "Your trial has been re-set! Opening dBpoweramp...\n"
open -a "dBpoweramp Music Converter"
