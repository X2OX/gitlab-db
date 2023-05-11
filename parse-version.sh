#!/bin/bash

SEARCH_PAGES='3'

if [ -f ./version.list ]; then
    rm version.list
fi

for i in $(seq 1 ${SEARCH_PAGES}); do
    curl -s "https://packages.gitlab.com/gitlab/gitlab-ee?page=${i}" | grep "_arm64.deb" | grep -v '\-rc' | sed 's/.*>\(.*\)<.*/\1/' | grep -Eo '(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)' >> version.list;
done

sort -rVu version.list -o version.list
