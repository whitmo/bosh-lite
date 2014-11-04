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

main() {
  chruby 2.1.2

  install_bundle_prerequisites
  gem install bundler

  install_vagrant_prerequisites
}

main
