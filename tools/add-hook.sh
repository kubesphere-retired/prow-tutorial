#!/bin/bash
repo=$1
if [ x$repo == "x" ]; then
    echo "pls specify a repo"
    exit 1
fi

add-hook \
  --hmac-path=/Users/songxuetao/temp/hmac-token \
  --github-token-path=/Users/songxuetao/temp/test-token \
  --hook-url http://139.198.121.161:8180/hook \
  --repo $repo \
  --confirm=true
  
  