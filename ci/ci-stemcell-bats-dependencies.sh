#!/bin/bash

source $(dirname $0)/ci_helpers.sh

main() {
  set_virtualbox_machine_folder
}

main
