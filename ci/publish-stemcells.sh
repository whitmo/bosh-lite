#!/usr/bin/env bash
set -ex

env | sort

for os in "ubuntu-trusty" "centos"; do
  s3cmd put --mime-type=application/x-gtar --no-preserve -P ./bosh-stemcell-$BOSH_LITE_CANDIDATE_BUILD_NUMBER-warden-boshlite-$os-go_agent.tgz s3://bosh-jenkins-artifacts/bosh-stemcell/warden/
  s3cmd put --mime-type=application/x-gtar --no-preserve -P ./bosh-stemcell-$BOSH_LITE_CANDIDATE_BUILD_NUMBER-warden-boshlite-$os-go_agent.tgz s3://bosh-jenkins-artifacts/bosh-stemcell/warden/latest-bosh-stemcell-warden-$os-go_agent.tgz
done

# trusty is the default ubuntu stemcell
s3cmd put -P ./bosh-stemcell-$BOSH_LITE_CANDIDATE_BUILD_NUMBER-warden-boshlite-ubuntu-trusty-go_agent.tgz s3://bosh-jenkins-artifacts/bosh-stemcell/warden/latest-bosh-stemcell-warden-ubuntu.tgz
s3cmd put -P ./bosh-stemcell-$BOSH_LITE_CANDIDATE_BUILD_NUMBER-warden-boshlite-ubuntu-trusty-go_agent.tgz s3://bosh-jenkins-artifacts/bosh-stemcell/warden/latest-bosh-stemcell-warden.tgz