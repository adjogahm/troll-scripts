#!/bin/sh

script_dir=$(dirname $(realpath $0))
NB_PROCESS=5

echo "Creating ${NB_PROCESS} process..."

for ((i = 0; i < $NB_PROCESS; i++)); do
  nohup ${script_dir}/mp3/playRandomMp3.sh 0</dev/null >/dev/null &
  sleep $(( ( RANDOM % 300 ) )); # random based on 5 min
done
