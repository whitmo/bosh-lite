#!/bin/bash

set_virtualbox_machine_folder() {
  VBoxManage setproperty machinefolder /var/vcap/data/vbox_machines
}

install_bundle() {
  sudo apt-get install -y postgresql-server-dev-9.3
  sudo apt-get install -y libsqlite3-dev
  sudo apt-get install -y libmysqlclient-dev
  gem install bundler
}

install_vagrant_prerequisites() {
  dpkg -s chefdk 2> /dev/null

  if [ $? -ne 0 ]; then
    wget http://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.3.2-1_amd64.deb

    dpkg -i chefdk_0.3.2-1_amd64.deb
  fi
}

install_vagrant_plugins() {
  installed_plugins=`vagrant plugin list`

  for plugin in "vagrant-vmware-fusion" "vagrant-aws" "vagrant-berkshelf" "vagrant-omnibus"; do
    echo $installed_plugins | grep $plugin > /dev/null

    if [ $? = 1 ]; then
      vagrant plugin install $plugin
    else
      echo "$plugin is already installed"
    fi
  done
}

install_s3cmd() {
  set -x
  sudo apt-get install -y python-dateutil
  s3cmd --version 2> /dev/null

  if [ $? -ne 0 ]; then
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8BAF9A6F
    sudo apt-get update
    sudo apt-get install -y python2.4-setuptools

    wget https://github.com/s3tools/s3cmd/archive/v1.5.0-rc1.tar.gz
    tar xvf v1.5.0-rc1.tar.gz

    pushd s3cmd-1.5.0-rc1
    sudo python setup.py install
    popd

    ln -s /usr/local/bin/s3cmd /usr/bin/s3cmd
  fi
}

install_aws_cli() {
  aws --version > /dev/null

  if [ $? -ne 0 ]; then
    sudo apt-get install -y python-pip
    sudo pip install awscli
    ln -s /usr/local/bin/aws /usr/bin/aws
  fi
}

get_bosh_stemcell_key() {
  new_key_path=$HOME/.ssh/id_rsa_bosh
  echo "-----BEGIN RSA PRIVATE KEY-----" > $new_key_path
  echo $ID_RSA_BOSH | sed 's/\s\+/\n/g' >> $new_key_path
  echo "-----END RSA PRIVATE KEY-----" >> $new_key_path
}

