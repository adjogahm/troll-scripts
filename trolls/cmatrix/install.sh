#!/usr/bin/env bash
# reference: https://adammusciano.com/2020/03/04/2020-03-04-clear-your-terminal-in-style/

#-------------------------------------------
# one-liner alternative deployment:
# brew install python || yum install -y python-pip || apt install -f python-pip && python -m pip install getgist && cd /tmp && getgist adjogahm /tmp/install_cmatrix.sh && bash /tmp/install_cmatrix.sh && cd - && clear 
#-------------------------------------------

if [ -f "${HOME}/.bash_aliases" ]; then
  FILE="${HOME}/.bash_aliases"
elif [ -f "${HOME}/.bashrc" ]; then
  FILE="${HOME}/.bashrc"
elif [ -f "${HOME}/.bash_profile" ]; then
  FILE="${HOME}/.bash_profile"
fi

set -e
unameOut=$(uname -s)
case ${unameOut} in
  Darwin*)    MACHINE=darwin;;
  Linux*)     MACHINE=linux;;
  *)          MACHINE="UNKNOWN:${unameOut}";;
esac

if [[ ${MACHINE} == "darwin" ]]; then
  brew install cmatrix
  sudo cat >> "${FILE}" <<EOF1

alias clear='[ $[$RANDOM % 20] = 0 ] && timeout 3 cmatrix; clear || clear'

EOF1
elif [[ ${MACHINE} == "linux" ]]; then
  [[ -n "$(command -v yum)" ]] && MACHINE=redhat
  [[ -n "$(command -v apt-get)" ]] && MACHINE=debian
  sudo cat >> "${FILE}" <<EOF1

alias clear='[ $[$RANDOM % 20] = 0 ] && timeout 3 cmatrix; clear || clear'

EOF1
  if [[ ${MACHINE} == "redhat" ]]; then
    yum install -y gcc make autoconf automake ncurses-devel
    git clone https://github.com/abishekvashok/cmatrix.git ${HOME}/cmatrix
    cd ${HOME}/cmatrix
    autoreconf -i # skip if using released tarball
    ./configure
    make
    make install
    rm -rf ${HOME}/cmatrix
    cd -
  elif [[ ${MACHINE} == "debian" ]]; then
    apt-get install -f cmatrix
  fi
else
  echo -e "\nOS unsupported!" && exit 1
fi
