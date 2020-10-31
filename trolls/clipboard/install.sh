#!/bin/sh

# For 120 mins
export end_date=$(($(date +%s) + (120 * 60)))

if [[ ${MACHINE} == "darwin" ]]; then
  while [[ $(date +%s) -le ${end_date} ]]; do echo -n "poop" | pbcopy; done &
else
  if [[ ${MACHINE} == "redhat" ]]; then
    yum install -y xsel
    while [[ $(date +%s) -le ${end_date} ]]; do echo -n "poop" | xsel; done &
  elif [[ ${MACHINE} == "debian" ]]; then
    apt-get install -f xclip
    while [[ $(date +%s) -le ${end_date} ]]; do echo -n "poop" | xclip; done &
  else
    echo -e "\nOS unsupported!"
  fi
fi
