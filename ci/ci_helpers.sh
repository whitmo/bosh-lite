#!/bin/bash

download_box() {
  box_type=$1
  candidate_build_number=$2
  box_name=bosh-lite-${box_type}-ubuntu-trusty-${candidate_build_number}.box

  rm -f bosh-lite-${box_type}-ubuntu-trusty-*.box
  wget "https://s3.amazonaws.com/bosh-lite-build-artifacts/${box_name}"
}

upload_box() {
  box_type=$1
  candidate_build_number=$2

  box_name=bosh-lite-${box_type}-ubuntu-trusty-${candidate_build_number}.box
  bucket_url=s3://bosh-lite-ci-pipeline/
  s3cmd --access_key=$BOSH_AWS_ACCESS_KEY_ID --secret_key=$BOSH_AWS_SECRET_ACCESS_KEY put $box_name $bucket_url
}

set_virtualbox_machine_folder() {
  VBoxManage setproperty machinefolder /var/vcap/data/vbox_machines
}

install_bundle() {
  sudo apt-get update
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
  s3cmd --version

  if [ $? -ne 0 ]; then
    sudo apt-get install -y python2.4-setuptools

    wget https://github.com/s3tools/s3cmd/archive/v1.5.0-rc1.tar.gz
    tar xf v1.5.0-rc1.tar.gz

    (
      cd v1.5.0-rc1
      sudo python setup.py install
    )
  fi
}

install_aws_cli() {
  install_pip
  sudo pip install awscli
}

install_pip() {
  wget https://bootstrap.pypa.io/get-pip.py
  sudo python get-pip.py
}

get_bosh_stemcell_key() {
  new_key_path=$HOME/.ssh/id_rsa_bosh
  echo "-----BEGIN RSA PRIVATE KEY-----" > $new_key_path
  echo $ID_RSA_BOSH | sed 's/\s\+/\n/g' >> $new_key_path
  echo "-----END RSA PRIVATE KEY-----" >> $new_key_path
}

