#!/bin/bash

# ezhhtrack - a simple bash script for automating single-page httrack downloads
# I mostly use httrack to archive interesting webpages for later reading - this
# script will download only the requested page, but will download all external 
# resources (such as images) required to make the page display identically to
# the online version.

# REQUIREMENTS:
# httrack (brew install httrack)
# recode (brew install recode)

# USAGE:
# ./ezhttrack.sh https://your-webpage-url-here.com/article/blah/blah/blah

# get title of webpage and format it (for folder name)
input=`curl -sL "$1" | grep '<title>' | recode html..ascii`
articleTitle=`echo $input | sed 's/<title>//g' | sed 's#</title>##g' | sed -e "s/[^A-Za-z0-9._' -]/ /g"`

homeDirectory=`printenv HOME`
fullSavePath="${homeDirectory}/websites/${articleTitle}"

httrack "$1" -O "${fullSavePath}" "$1" -v -s0 --ext-depth=0 --depth=1 -n