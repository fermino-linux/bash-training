#!/usr/bin/env bash
#
# Autor: 
#    Fermino
# Versão:
#   2.0
# Descrição:
#   Faz a instalação do prometheus
# Exemplos:
#   Instala o prometheus
#       ./install.sh 


## Obtem o prometheus
prom_url='https://github.com/prometheus/prometheus/releases/download/v2.40.3/prometheus-2.40.3.linux-amd64.tar.gz'
prom_filename='prometheus.tar.gz'

curl -fsSLo $prom_filename $prom_url && mkdir prometheus 

tar -C prometheus --strip-components 1 -xf $prom_filename

rm -f $prom_filename

# move o diretório
sudomv prometheus /opt/
# cria o diretório para armazenamento de dados
sudo mkdir /var/lib/prometheus

# Definições de usuário
sudo groupadd --system prometheus
sudo useradd -s /sbin/nologin --system -g prometheus prometheus


# Cria a o serviço do prometheus
cat << EOF | sudo tee > /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Documentation=https://prometheus.io/docs/introduction/overview
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=prometheus
Group=prometheus
ExecReload=/bin/kill -HUP $MAINPID
ExecStart=/opt/prometheus/prometheus \
    --config.file=/opt/prometheus/prometheus.yaml
    --storage.tsdb.path=/var/lib/prometheus
    --web.console.templates=/opt/prometheus/consoles \
    --web.console.libraries=/opt/prometheus/consoles_libraries \
    --web.listen-address=0.0.0.0:9090 \
    --web.external-url=

SyslogIdentifier=prometheus
Restart=always
EOF

# Reinicia o systemd e inicializa o prometheus
sudo systemctl daemon-reload
sudo systemctl enable --now prometheus






