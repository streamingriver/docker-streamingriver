#!/bin/bash

sudo apt-get remove docker docker-engine docker.io containerd runc

apt-get -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get -y install docker-ce docker-ce-cli containerd.io

install_docker_compose () {
        curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url  | grep docker-compose-linux-x86_64 | cut -d '"' -f 4 | wget -qi -
        shasum -a 256 -s -c docker-compose-linux-x86_64.sha256 && mv ./docker-compose-linux-x86_64 /usr/local/sbin/docker-compose && rm -f docker-compose-linux-x86_64.sha256 && return 0
        echo "problem installing docker compose"
        exit 666
}

install_docker_compose
