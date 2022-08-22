#!/usr/bin/env bash

prom_link='https://github.com/prometheus/prometheus/releases/download/v2.38.0/prometheus-2.38.0.linux-amd64.tar.gz'
am_link='https://github.com/prometheus/alertmanager/releases/download/v0.24.0/alertmanager-0.24.0.linux-amd64.tar.gz'

# wget instalado?
if [[ ! -x '/usr/bin/wget' ]] ; then
    echo "Instalando o wget..."
    sudo yum in -y wget &>/dev/null
fi

echo "Obtendo os arquivos para a instalação do Prometheus"
wget -q $prom_link 
echo "Obtendo os arquivos para a instalação do Alert Manager"
wget -q $am_link 

echo "Extraindo os arquivos necessários" 
tar -xzf prometheus-2.38.0.linux-amd64.tar.gz
tar -xzf alertmanager-0.24.0.linux-amd64.tar.gz 

echo "Copiando os diretórios para  /usr/local/lib"
sudo mv prometheus-2.38.0.linux-amd64 /usr/local/lib/prometheus
sudo mv alertmanager-0.24.0.linux-amd64 /usr/local/lib/alertmanager

echo "Ajustando os executáveis.."
cd /usr/local/bin
sudo ln -sT /usr/local/lib/prometheus/prometheus prometheus
sudo ln -sT /usr/local/lib/prometheus/promtool promtool
sudo ln -sT /usr/local/lib/alertmanager/alertmanager alertmanager
sudo ln -sT /usr/local/lib/alertmanager/amtool amtool

echo "Inicializando"
/usr/local/bin/prometheus --config.file="/usr/local/lib/prometheus/prometheus.yml" &
/usr/local/bin/alertmanager --config.file="/usr/local/lib/alertmanager/alertmanager.yml" &

echo "Finalizado"


