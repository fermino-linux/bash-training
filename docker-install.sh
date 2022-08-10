#!/usr/bin/env bash

# Remove instalações anteriores
pacotes='docker-ce docker-ce-cli containerd.io docker-compose-plugin'
sudo yum rm -y $pacotes &>/dev/null

# Prepara os requisitos para a instalação do docker
echo "Preparando pré-requisitos"
sudo yum in -y yum-utils &>/dev/null
sudo yum in -y config-manager --enable extras &>/dev/null

# Adicionando o repositório do Docker
echo "Adicionando repositório..."
sudo yum config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo &>/dev/null

# Instalando
echo "Instalando Docker e suas dependências"
sudo yum in -y $pacotes &>/dev/null

# Habilitando o serviço
sudo systemctl enable --now docker

