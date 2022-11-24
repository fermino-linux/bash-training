#!/usr/bin/env bash
#
# Autor: 
#    Fermino
# Versão:
#   1.0
# Descrição:
#   Faz a instalação do prometheus
# Exemplos:
#   Instala o prometheus
#       ./install.sh 

prom_url='https://github.com/prometheus/prometheus/releases/download/v2.40.3/prometheus-2.40.3.linux-amd64.tar.gz'

sudo yum install -y wget 

wget -qO prometheus.tar.gz

tar -xf prometheus.tar.gz