#!/bin/sh
MENU="\033[0;33m"   # Yellow
ERROR="\033[1;31m"  # Bold Red
OFF="\033[0m"       # Color off
script_dir=$(dirname $(realpath $0))
PS3='Select an option and press Enter: '
options=("clipboard (level 0)" "mindBlow (level 1)" "goat (level 2)" "cmatrix (techie 0)" "all")

unameOut=$(uname -s)
case ${unameOut} in
  Darwin*)
    export MACHINE=darwin
  ;;
  Linux*)
    [[ -n "$(command -v yum)" ]] && export MACHINE=redhat
    [[ -n "$(command -v apt-get)" ]] && export MACHINE=debian
  ;;
  *)
    export MACHINE="UNKNOWN:${unameOut}"
  ;;
esac

clear
COLUMNS=1 
select opt in "${options[@]}"
do
  case $opt in
    "clipboard (level 0)")
      print "${MENU}Clipboard${OFF}"
      sh ${script_dir}/trolls/clipboard/install.sh
      break
    ;;
    "mindBlow (level 1)")
      print "${MENU}MindBlow${OFF}"
      sh ${script_dir}/trolls/mindBlow/install.sh
      break
    ;;
    "goat (level 2)")
      print "${MENU}Goat${OFF}"
      sh ${script_dir}/trolls/goat/install.sh
      break
    ;;
    "cmatrix (techie 0)")
      print "${MENU}Cmatrix${OFF}"
      sh ${script_dir}/trolls/cmatrix/install.sh
      break
    ;;
    "all")
      print "${MENU}All${OFF}"
      for folder in $(ls -d ${script_dir}/trolls/*); do
        sh ${folder}/install.sh
      done
      break
    ;;
    *)
      print "${ERROR}Invalid option${OFF}"
      break
    ;;
  esac
done
