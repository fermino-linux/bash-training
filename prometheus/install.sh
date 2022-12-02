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

# Cria os diretórios para gestão do prometheus
sudo mkdir /var/lib/prometheus # para armazenar dados
sudo mkdir /etc/prometheus

# move os arquivos 
sudo mv prometheus/{consoles,console_libraries,prometheus.yml} /etc/prometheus
sudo mv prometheus/{prometheus,promtool} /usr/sbin

# Cria a o serviço do prometheus
cat << EOF | sudo tee > /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Documentation=https://prometheus.io/docs/introduction
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=root
Group=root
ExecStart=/usr/sbin/prometheus \\
  --config.file=/etc/prometheus/prometheus.yml \\
  --storage.tsdb.path=/var/lib/prometheus \\
  --web.console.templates=/etc/prometheus/consoles \\
  --web.console.libraries=/etc/prometheus/consoles_libraries
ExecReload=/usr/bin/kill -s SIGHUP "\$MAINPID"
Restart=always
EOF


# Reinicia o systemd e inicializa o prometheus
sudo systemctl daemon-reload
sudo systemctl enable --now prometheus






