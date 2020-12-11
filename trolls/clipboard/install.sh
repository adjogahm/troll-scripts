#!/bin/sh

# For 120 mins
export end_date=$(($(date +%s) + (120 * 60)))

if [[ ${MACHINE} == "darwin" ]]; then
  nohup $(while [[ $(date +%s) -le ${end_date} ]]; do sleep 1; echo -n "poop" | pbcopy; done) &
else
  if [[ ${MACHINE} == "redhat" ]]; then
    yum install -y xsel
    nohup $(while [[ $(date +%s) -le ${end_date} ]]; do sleep 1; echo -n "poop" | xsel; done) &
  elif [[ ${MACHINE} == "debian" ]]; then
    apt-get install -f xclip
    nohup $(while [[ $(date +%s) -le ${end_date} ]]; do sleep 1; echo -n "poop" | xclip; done) &
  else
    print "\nOS unsupported!"
  fi
fi
