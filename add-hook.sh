#!/bin/bash
repo=$1
if [ x$repo == "x" ]; then
    echo "pls specify a repo"
    exit 1
fi

add-hook \
  --hmac-path=/Users/songxuetao/temp/hmac-token \
  --github-token-path=/Users/songxuetao/temp/git-token \
  --hook-url http://prow.magicsong.xyz:32439/hook \
  --repo $repo \
  --confirm=true%
  