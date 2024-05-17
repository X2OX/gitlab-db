#!/bin/bash

sed -i 's/^FROM ubuntu.*/FROM ubuntu\:jammy/' omnibus-gitlab/docker/Dockerfile
sed -i 's/\-recommends/\-recommends libatomic1/' omnibus-gitlab/docker/Dockerfile
sed -i 's/libperl5\.30/libperl5\.34/' omnibus-gitlab/docker/Dockerfile
sed -i 's/lsb-release/os-release/' omnibus-gitlab/docker/assets/setup

sed -i '/^MAINTAINER/ a\LABEL version="Development Beta"' omnibus-gitlab/docker/Dockerfile
sed -i 's/# Allow to access embedded tools/RUN \/assets\/patch-db-license.sh/' omnibus-gitlab/docker/Dockerfile
cp patch-db-license.sh omnibus-gitlab/docker/assets

cp -f download-package.sh omnibus-gitlab/docker/assets/download-package

GITLAB_VERSION="${GITHUB_REF:11}+ee.0"
GITLAB_VERSION=${GITLAB_VERSION/+/-}
echo "$GITLAB_VERSION"

cat > omnibus-gitlab/docker/RELEASE <<EOF
PACKAGECLOUD_REPO=gitlab-ee
RELEASE_PACKAGE=gitlab-ee
RELEASE_VERSION=$GITLAB_VERSION
TARGETARCH=$(arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/)
DOWNLOAD_URL_amd64="https://packages.gitlab.com/gitlab/gitlab-ee/packages/ubuntu/jammy/gitlab-ee_${GITLAB_VERSION}_amd64.deb/download.deb"
DOWNLOAD_URL_arm64="https://packages.gitlab.com/gitlab/gitlab-ee/packages/ubuntu/jammy/gitlab-ee_${GITLAB_VERSION}_arm64.deb/download.deb"
DOWNLOAD_URL=https://packages.gitlab.com/gitlab/gitlab-ee/packages/ubuntu/jammy/gitlab-ee_$GITLAB_VERSION

EOF
