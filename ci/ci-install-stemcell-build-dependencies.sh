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
  wget https://opscode-omnibus-packages.s3.amazonaws.com/mac_os_x/10.8/x86_64/chefdk-0.3.2-1.dmg
  dpkg -i chefdk-0.3.2-1.dmg
}

main
