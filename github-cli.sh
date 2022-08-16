#!/usr/bin/env bash

repo='https://cli.github.com/packages/rpm/gh-cli.repo'

# Adiciona o repositório
echo "Instalando repositórios..."
sudo yum config-manager --add-repo $repo &>/dev/null
# Efetua a instalação
echo "Instalando o GitHub CLI"
sudo yum in -y gh &>/dev/null

# Verifica se tudo ocorreu bem
gh --version