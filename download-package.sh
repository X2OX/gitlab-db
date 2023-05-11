#!/bin/bash

# Ubuntu `x86_64:amd64 aarch64:arm64`
arch="amd64"
if [[ ${uname -m} == "aarch64" ]]; then
  arch="arm64"
fi

# ${DOWNLOAD_URL} == https://packages.gitlab.com/gitlab/gitlab-ee/packages/ubuntu/focal/gitlab-ee_${VERSION}
URL="${DOWNLOAD_URL}_${arch}.deb/download.deb"

echo "Downloading package - ${URL}"
wget --quiet ${URL} -O /tmp/gitlab.deb

results=$?
if [ ${results} -ne 0 ]; then
    >&2 echo "There was an error downloading ${URL}. Please check the output for more information"
    exit ${results}
fi