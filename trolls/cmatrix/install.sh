#!/usr/bin/env bash
# reference: https://adammusciano.com/2020/03/04/2020-03-04-clear-your-terminal-in-style/

if [ -f "${HOME}/.bash_aliases" ]; then
  FILE="${HOME}/.bash_aliases"
elif [ -f "${HOME}/.bashrc" ]; then
  FILE="${HOME}/.bashrc"
elif [ -f "${HOME}/.bash_profile" ]; then
  FILE="${HOME}/.bash_profile"
fi

# Will popup on 66% of the clear requests on the terminal, with a timeout of 3 seconds
sudo cat >> "${FILE}" <<EOF1

alias clear='[ $[$RANDOM % 66] = 0 ] && timeout 3 cmatrix; clear || clear'

EOF1

if [[ ${MACHINE} == "darwin" ]]; then
  brew install cmatrix
else
  if [[ ${MACHINE} == "redhat" ]]; then
    yum install -y gcc make autoconf automake ncurses-devel
    git clone https://github.com/abishekvashok/cmatrix.git /tmp/cmatrix
    cd /tmp/cmatrix
    autoreconf -i # skip if using released tarball
    ./configure
    make
    make install
    cd -
  elif [[ ${MACHINE} == "debian" ]]; then
    apt-get install -f cmatrix
  else
    echo -e "\nOS unsupported!"
  fi
fi
