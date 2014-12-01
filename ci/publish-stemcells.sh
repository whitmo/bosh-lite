#!/usr/bin/env bash
set -ex

env | sort

s3_cmd_cp() {
  s3cmd --access_key=$BOSH_AWS_ACCESS_KEY_ID --secret_key=$BOSH_AWS_SECRET_ACCESS_KEY --mime-type=application/x-gtar --no-preserve -P cp $1 $2
}

main() {
  BUCKET="s3://bosh-lite-ci-pipeline/$BOSH_LITE_CANDIDATE_BUILD_NUMBER/bosh-stemcell/warden"

  for os in "ubuntu-trusty" "centos"; do
    STEMCELL="bosh-stemcell-${BOSH_LITE_CANDIDATE_BUILD_NUMBER}-warden-boshlite-${os}-go_agent.tgz"
    s3_cmd_cp $BUCKET/$STEMCELL s3://bosh-lite-build-artifacts2/
    s3_cmd_cp $BUCKET/$STEMCELL s3://bosh-lite-build-artifacts2/latest-bosh-stemcell-warden-$os-go_agent.tgz
  done

  # trusty is the default ubuntu stemcell
  STEMCELL="bosh-stemcell-${BOSH_LITE_CANDIDATE_BUILD_NUMBER}-warden-boshlite-ubuntu-go_agent.tgz"
  s3_cmd_cp $BUCKET/$STEMCELL s3://bosh-lite-build-artifacts2/latest-bosh-stemcell-warden-ubuntu.tgz
  s3_cmd_cp $BUCKET/$STEMCELL s3://bosh-lite-build-artifacts2/latest-bosh-stemcell-warden.tgz
}

main
