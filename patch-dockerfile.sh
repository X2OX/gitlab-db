#!/bin/bash

sed -i '/^MAINTAINER/ a\LABEL version="Development Beta"' omnibus-gitlab/docker/Dockerfile
sed -i '/^ENV PATH /opt/gitlab/embedded/bin a\RUN patch-db-license.sh' omnibus-gitlab/docker/Dockerfile
cp patch-db-license.sh omnibus-gitlab/docker

cp -f download-package.sh omnibus-gitlab/docker/assets/setup/download-package

cat > omnibus-gitlab/docker/RELEASE <<EOF
PACKAGECLOUD_REPO=gitlab-ee
RELEASE_PACKAGE=gitlab-ee
RELEASE_VERSION=`GITLAB_VERSION`
DOWNLOAD_URL=https://packages.gitlab.com/gitlab/gitlab-ee/packages/ubuntu/focal/gitlab-ce_`GITLAB_VERSION`

EOF
