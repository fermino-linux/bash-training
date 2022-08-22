#!/usr/bin/env bash

repo='https://cli.github.com/packages/rpm/gh-cli.repo'

echo "Adicionando repositórios..."
sudo yum config-manager --add-repo $repo &>/dev/null

echo "Adicionando o GitHub CLI"
sudo yum in -y gh &>/dev/null
