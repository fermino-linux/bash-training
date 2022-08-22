#!/usr/bin/env bash

# httpd instalado?
if [[ ! -x '/usr/sbin/httpd' ]]
    echo "Instalando o httpd..."
    sudo yum in -y httpd &>/dev/null
fi

echo "Subindo o serviço do httpd"
sudo systemctl enable --now httpd &>/dev/null