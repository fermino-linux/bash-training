#!/usr/bin/env bash

user="${1:=vagrant}"
groups='ubridge libvirt kvm wireshark docker'

# Adiciona o repositório e instala o gns3
sudo add-apt-repository ppa:gns3/ppa
sudo apt update -y
sudo apt install -y gns3-server gns3-gui

# Adiciona os repositórios e prepara o Docker
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable"

sudo apt update -y
sudo apt install -y docker-ce

# Adiciona o usuário nos grupos necessários
sudo usermod -aG $groups $user
