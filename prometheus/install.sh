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
#
#
#
# Variáveis
SCRIPT_WORKING_DIR=/tmp

PROMETHEUS_CONFIG_DIR=/etc/prometheus
PROMETHEUS_CONSOLE_TEMPLATES=${PROMETHEUS_CONFIG_DIR}/console
PROMETHEUS_CONSOLE_LIBRARIES=${PROMETHEUS_CONFIG_DIR}/console_libraries
PROMETHEUS_DATA_DIR=/var/lib/prometheus
PROMETHEUS_LOG_DIR=${PROMETHEUS_DATA_DIR}/logs

PROMETHEUS_CONFIG_FILE=${PROMETHEUS_CONFIG_DIR}/prometheus.yml
PROMETHEUS_SERVERLOG_FILE=${PROMETHEUS_LOG_DIR}/serverlog
PROMETHEUS_ERRORLOG_FILE=${PROMETHEUS_LOG_DIR}/errorlog
#
#
#
#
# Funções
user_def() {
  # Prepara usuário do prom
  groupadd -r prometheus
  useradd -dm $PROMETHEUS_DATA_DIR -r --shell=/usr/sbin/nologin -g prometheus prometheus
}

create_dir() {
  # Cria a infraestrutura de diretórios do prom
  mkdir -p $PROMETHEUS_CONFIG_DIR $PROMETHEUS_LOG_DIR
  
  chown prometheus:prometheus $PROMETHEUS_CONFIG_DIR
  chown prometheus:prometheus $PROMETHEUS_LOG_DIR

  chmod 775 $PROMETHEUS_CONFIG_DIR
  chmod 775 $PROMETHEUS_LOG_DIR
}

get_prom() {
  # Faz o download do tarball do prometheus
  # e extrai seus arquivos para os diretórios
  # correspondentes.
  local url='https://github.com/prometheus/prometheus/releases/download/v2.40.3/prometheus-2.40.3.linux-amd64.tar.gz'
  local filename='prometheus.tar.gz'

  curl -fsSLo /tmp/$filename $url
  mkdir /tmp/output && tar -C /tmp/output --strip-components=1 -xf $filename

  chown -R prometheus:prometheus /tmp/output/*

  mv /tmp/output/{consoles,console_libraries,prometheus.yml} $PROMETHEUS_CONFIG_DIR
  mv /tmp/output/{prometheus,promtool} /usr/sbin/
}

# generate_promctl() {
#   # Cria o script promctl e o deixa pronto pra uso
# }
# create_service() {
#   # Cria o serviço do prometheus
# } 
#
#
# Execução

set -eo pipefail

user_def 
create_dir 
get_prom







