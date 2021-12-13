#!/bin/bash

dnf -y remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

dnf -y install dnf-plugins-core


dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo

dnf -y config-manager --set-enabled docker-ce-nightly

dnf -y install docker-ce docker-ce-cli containerd.io

install_docker_compose () {
        curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url  | grep docker-compose-linux-x86_64 | cut -d '"' -f 4 | wget -qi -
        shasum -a 256 -s -c docker-compose-linux-x86_64.sha256 && mv ./docker-compose-linux-x86_64 /usr/local/sbin/docker-compose && chmod +x /usr/local/sbin/docker-compose && rm -f docker-compose-linux-x86_64.sha256 && return 0
        echo "problem installing docker compose"
        exit 666
}

install_docker_compose
