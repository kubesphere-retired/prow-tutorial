#!/bin/bash
pwd=$PWD
prow_path="/Users/songxuetao/go/src/github.com/kubesphere/test-infra"
cd ${prow_path}
bazel run //prow/cmd/checkconfig -- --plugin-config=${pwd}/samples/plugins.yaml --config-path=${pwd}/samples/config.yaml