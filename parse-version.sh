#!/bin/bash

SEARCH_PAGES='3'

if [ -f ./version.list ]; then
    rm version.list
fi

for i in $(seq 1 ${SEARCH_PAGES}); do
    curl -s "https://packages.gitlab.com/gitlab/gitlab-ee?page=${i}" | grep "ubuntu" | grep "jammy" | grep "_arm64.deb" | grep -v '\-rc' | grep -Eo '(\d+)\.(\d+)\.(\d+)' >> version.list;
done

sort -rVu version.list -o version.list
