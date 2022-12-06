#!/usr/bin/env bash
#
# Autor: 
#    Fermino
# Versão:
#   1.0
# Descrição:
#   Auxilia a execução do prometheus como serviço
#   foi desenhado para trabalhar em conjunto com o 
#   install.sh
#
# Exemplo
#   Inicia o prometheus
#       $ ./promctl
#   Reinicia o prometheus 
#       $ ./promctl -r PID
#   Para a execução do prometheus
#       $ ./promctl -s PID
#   Obtem ajuda
#       $ ./promctl --help
#
# Variáveis
PROMETHEUS_CONFIG_DIR=/etc/prometheus
PROMETHEUS_CONSOLE_TEMPLATES=${PROMETHEUS_CONFIG_DIR}/console
PROMETHEUS_CONSOLE_LIBRARIES=${PROMETHEUS_CONFIG_DIR}/console_libraries
PROMETHEUS_DATA_DIR=/var/lib/prometheus
PROMETHEUS_LOG_DIR=${PROMETHEUS_DATA_DIR}/logs

PROMETHEUS_CONFIG_FILE=${PROMETHEUS_CONFIG_DIR}/prometheus.yml

HELP="Promctl
Descrição: Auxilia a execução do prometheus como serviço
  foi desenhado para trabalhar em conjunto com o 
  install.sh 

Uso: promctl [OPÇÕES][PID]

Opções:
  --help  -  Exibe esta ajuda
  -r PID  -  Reinicia o processo do PROM a partir do PID informado
  -s PID  -  Para o processo do PROM a partir do PID informado
"
#
#
#
# Funções
start() {
    # Executa o prometheus em background
    /usr/sbin/prometheus \
        --config.file "$PROMETHEUS_CONFIG_FILE" \
        --web.listen-address=0.0.0.0:9090 \
        --web.console.templates $PROMETHEUS_CONSOLE_TEMPLATES \
        --web.console.libraries $PROMETHEUS_CONSOLE_LIBRARIES &
}

restart() {
    # Restarta o prometheus
    # $1 - PID do processo do prom
    stop $1
    start
}

stop() {
    # Para a execução do prometheus
    # $1 - PID do processo do prom
    kill -s SIGSTOP $1
}
#
#
#
# Execução
case $1 in

    --help)
        echo $HELP
        ;;
    
    -r)
        shift;
        restart $1
        ;;
    
    -s)
        shift;
        stop $1
        ;;
    
    *)
        start $1
        ;;

esac
