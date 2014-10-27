#!/usr/bin/env bash
set -ex

export STEMCELL_BUILD_NUMBER=${BOSH_LITE_CANDIDATE_BUILD_NUMBER}
export TMPDIR="/var/vcap/data/tmp"

source $(dirname $0)/test_helpers.sh

trap cleanup EXIT

rm -rf $TMPDIR
rm -rf output

mkdir -p $TMPDIR

chruby 2.0.0

fetch_latest_bosh

(
  cd bosh
  bundle exec rake stemcell:build[warden,boshlite,$OS_NAME,$OS_VERSION,go,bosh-os-images,bosh-$OS_NAME-$OS_VERSION-os-image.tgz]
)

mkdir -p output
cp /mnt/stemcells/warden/boshlite/$OS_NAME/work/work/*.tgz output/
