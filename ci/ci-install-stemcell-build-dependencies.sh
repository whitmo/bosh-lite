#!/bin/bash

main() {
  chruby 2.1.2

  gem install bundler

  # prerequisites for running bundle on bosh
  sudo apt-get update
  sudo apt-get install -y postgresql-server-dev-9.3
  sudo apt-get install -y libsqlite3-dev
  sudo apt-get install -y libmysqlclient-dev

  # prerequisites for vagrant

  dpkg -s chefdk 2> /dev/null

  if [ $? -ne 0 ]; then
    wget http://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.3.2-1_amd64.deb

    dpkg -i chefdk_0.3.2-1_amd64.deb
  fi
}

main
