#!/usr/bin/bash

# Atualiza os pacotes
sudo  apt update -y && sudo apt upgrade -y
# Instala o gerenciador de sessão
sudo apt install -y gdm
# Instala o gnome
sudo apt install -y gnome gnome-*
# Habilita os serviço necessários
sudo systemctl set-default graphical.target
sudo systemctl enable --now gdm