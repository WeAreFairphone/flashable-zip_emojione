#!/bin/bash
set -e

#_______________________________________________________________________________
#                              Configurations
ZIP_PREFIX='emojione'
FONT_URL='https://github.com/Ranks/emojione/raw/2.2.7/assets/fonts/emojione-android.ttf'
FONT_NAME='emojione-android.ttf'

#_______________________________________________________________________________
#                              Inner functions
function fetch() {
  local URL=$1
  local FILENAME=$2

  wget \
  --no-verbose \
  --output-document=$FILENAME \
  $URL
}

function generate_zip() {
  local ZIP_NAME="$1_$(date +%Y-%m-%d).zip"

  local ZIP_FILES=./*

  zip \
  --quiet \
  --recurse-path $ZIP_NAME \
  $ZIP_FILES \
  --exclude '*.asc' '*.xml'
  echo "Result: $ZIP_NAME"
}

#_______________________________________________________________________________
#                                 Main
echo "~~~ Fetching latest free version of the EmojiOne font"
fetch $FONT_URL $FONT_NAME

echo "~~~ Packing up"
generate_zip $ZIP_PREFIX

echo "~~~ Cleaning up"
rm --verbose $FONT_NAME

echo "~~~ Finished"
