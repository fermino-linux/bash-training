#!/usr/bin/env bash
#
# Autor: 
#    Fermino
# Versão:
#   1.0
# Descrição:
#   Faz a instalação do ansible via pip
# Exemplos:
#   Instala o ansible
#       ./install.sh 
#   Instala o ansible para um usuário especifico
#       ./install.sh USUÁRIO

pkgs_deps='python39 python39-pip'
pkgs_utils='vim tree sshpass'
pkgs_ansible='ansible ansible-lint'

sudo yum in -y $pkgs_deps $pkgs_utils &>/dev/null

# Usuário informado?
if [[ $# -gt 0 ]] ; then
    grep $1 /etc/passwd &>/dev/null
    [[ $? -ne 1 ]] && user="$1" || exit 1
else 
    user="$(whoami)"
fi

sudo -u $user pip3.9 install --user $pkgs_ansible &>/dev/null