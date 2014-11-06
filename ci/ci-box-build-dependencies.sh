#!/usr/bin/env bash

main() {
  install_packer_bosh
}

install_packer_bosh() {
  if [ ! -e packer-bosh ]; then
    git clone https://github.com/cppforlife/packer-bosh.git 
  fi

  (
    cd packer-bosh
    git fetch
    git pull
    git submodule update  --init --recursive
  )

  PACKER_BOSH_PATH=`pwd`/packer-bosh

  cat << EOF > $HOME/.packerconfig
{
  "provisioners": {
    "packer-bosh": "$PACKER_BOSH_PATH"
  }
}
EOF

}

main
