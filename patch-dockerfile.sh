#!/bin/bash

sed -i '/^MAINTAINER/ a\LABEL version="Development Beta"' omnibus-gitlab/docker/Dockerfile
sed -i '/^ENV PATH /opt/gitlab/embedded/bin a\RUN patch-db-license.sh' omnibus-gitlab/docker/Dockerfile
cp patch-db-license.sh omnibus-gitlab/docker
