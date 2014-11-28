#!/bin/bash

main() {
  gem install bundler

  # prerequisites for running bundle on bosh
  sudo apt-get update
  sudo apt-get install -y postgresql-server-dev-9.3
  sudo apt-get install -y libsqlite3-dev
  sudo apt-get install -y libmysqlclient-dev
}

main
