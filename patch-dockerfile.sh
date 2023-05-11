#!/bin/bash

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
DOWNLOAD_URL=https://packages.gitlab.com/gitlab/gitlab-ee/packages/ubuntu/focal/gitlab-ee_$GITLAB_VERSION

EOF
