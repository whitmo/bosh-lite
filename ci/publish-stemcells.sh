#!/usr/bin/env bash
set -ex
source $(dirname $0)/ci_helpers.sh
sudo apt-get update
install_s3cmd

env | sort

for os in "ubuntu-trusty" "centos"; do
  s3cmd put --mime-type=application/x-gtar --no-preserve -P ./bosh-stemcell-$BOSH_LITE_CANDIDATE_BUILD_NUMBER-warden-boshlite-$os-go_agent.tgz s3://bosh-lite-ci-pipeline/
  s3cmd put --mime-type=application/x-gtar --no-preserve -P ./bosh-stemcell-$BOSH_LITE_CANDIDATE_BUILD_NUMBER-warden-boshlite-$os-go_agent.tgz s3://bosh-lite-ci-pipeline/latest-bosh-stemcell-warden-$os-go_agent.tgz
done

# trusty is the default ubuntu stemcell
s3cmd put -P ./bosh-stemcell-$BOSH_LITE_CANDIDATE_BUILD_NUMBER-warden-boshlite-ubuntu-trusty-go_agent.tgz s3://bosh-lite-ci-pipeline/latest-bosh-stemcell-warden-ubuntu.tgz
s3cmd put -P ./bosh-stemcell-$BOSH_LITE_CANDIDATE_BUILD_NUMBER-warden-boshlite-ubuntu-trusty-go_agent.tgz s3://bosh-lite-ci-pipeline/latest-bosh-stemcell-warden.tgz
