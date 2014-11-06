#!/bin/bash

install_bundle_prerequisites() {
  sudo apt-get update
  sudo apt-get install -y postgresql-server-dev-9.3
  sudo apt-get install -y libsqlite3-dev
  sudo apt-get install -y libmysqlclient-dev
}

install_vagrant_prerequisites() {
  dpkg -s chefdk 2> /dev/null

  if [ $? -ne 0 ]; then
    wget http://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.3.2-1_amd64.deb

    dpkg -i chefdk_0.3.2-1_amd64.deb
  fi
}

install_vagrant_plugins() {
  vagrant plugin install vagrant-vmware-fusion
  vagrant plugin install vagrant-aws
  vagrant plugin install vagrant-berkshelf
  vagrant plugin install vagrant-omnibus
}

get_bosh_stemcell_key() {
  new_key_path=$HOME/.ssh/id_rsa_bosh
  echo "-----BEGIN RSA PRIVATE KEY-----" > $new_key_path
  echo $ID_RSA_BOSH | sed 's/\s\+/\n/g' >> $new_key_path
  echo "-----END RSA PRIVATE KEY-----" >> $new_key_path
}

main() {
  chruby 2.1.2

  install_bundle_prerequisites
  gem install bundler

  install_vagrant_prerequisites
  install_vagrant_plugins
  get_bosh_stemcell_key
}

main
