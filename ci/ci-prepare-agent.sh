#!/bin/bash

source $(dirname $0)/ci_helpers.sh

main() {
  chruby 2.1.2

  install_bundle

  install_vagrant_prerequisites
  install_vagrant_plugins
  install_s3cmd
  install_aws_cli

  get_bosh_stemcell_key
}

main
