#!/bin/bash

arch=$(arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/)

# ${DOWNLOAD_URL} == https://packages.gitlab.com/gitlab/gitlab-ee/packages/ubuntu/focal/gitlab-ee_${VERSION}
URL="${DOWNLOAD_URL}_${arch}.deb/download.deb"

if [[ ${arch} == "amd64" ]]; then
  URL=${URL/focal/bionic}
fi

echo "Downloading package - ${URL}"
wget --quiet ${URL} -O /tmp/gitlab.deb

results=$?
if [ ${results} -ne 0 ]; then
    >&2 echo "There was an error downloading ${URL}. Please check the output for more information"
    exit ${results}
fi