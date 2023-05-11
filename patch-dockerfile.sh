#!/bin/bash

sed -i 's/^MAINTAINER/r i LABEL version="Development Beta"/' omnibus-gitlab/docker/Dockerfile
sed -i '/^ENV PATH /opt/gitlab/embedded/bin/r i RUN patch-db-license.sh' omnibus-gitlab/docker/Dockerfile
cp patch-db-license.sh omnibus-gitlab/docker
