#!/bin/bash

main() {
  set_virtualbox_machine_folder
}

set_virtualbox_machine_folder() {
  VBoxManage setproperty machinefolder /var/vcap/data/vbox_machines
}

main
