#!/usr/bin/env bash
#
# Autor: 
#    Fermino
# Versão:
#   1.1
# Descrição:
#   Faz a instalação do docker
# Exemplos:
#   Instala o docker
#       ./install.sh 
#   Instala o docker garantindo acesso a um usuário em especifico
#       ./install.sh USUÁRIO


# Instações anteriores?
pacotes='docker-ce docker-ce-cli containerd.io docker-compose-plugin'
sudo yum rm -y $pacotes &>/dev/null

echo "Preparando pré-requisitos"
sudo yum in -y yum-utils &>/dev/null
sudo yum in -y config-manager --enable extras &>/dev/null

echo "Adicionando repositório..."
sudo yum config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo &>/dev/null

echo "Instalando Docker e suas dependências"
sudo yum in -y $pacotes &>/dev/null

echo "Habilitando o serviço..."
sudo systemctl enable --now docker &>/dev/null

# Se um usuário for informado, ele recebe acesso ao docker
if [[ $# -gt 0 ]] ; then
    control_user="$1"
    grep "$control_user" /etc/passwd &>/dev/null
    [[ $? -eq 0 ]] && usermod -aG docker "$control_user" && newgrp docker
fi
