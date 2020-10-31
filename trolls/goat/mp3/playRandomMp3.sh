#!/bin/sh

SCRIPT_DIR=$(dirname $(realpath $0))
MP3_DIR=$SCRIPT_DIR/mp3
MP3_LIST=($(ls -d $MP3_DIR/*.mp3))

while true;
do
  afplay -v 100 ${MP3_LIST[$(( ( RANDOM % ${#MP3_LIST[@]} )))]};
  sleep $(( ( RANDOM % 300 ) )); # random based on 5 min
done
