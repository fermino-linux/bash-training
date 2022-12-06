#!/usr/bin/env bash
#
# Autor: 
#    Fermino
# Versão:
#   1.0
# Descrição:
#   Auxilia a execução do prometheus 
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
PROMETHEUS_EXEC_DIR=/usr/sbin

PROMETHEUS_CONFIG_FILE=${PROMETHEUS_CONFIG_DIR}/prometheus.yml

HELP="Promctl
Descrição: Auxilia a execução e gerenciamento do prometheus

Uso: promctl [OPÇÕES]

Opções:
  --help  -  Exibe esta ajuda
  -r  -  Reinicia o processo do PROM
  -s  -  Para o processo do PROM
"

pid_file=/var/run/prometheus.pid
#
#
#
# Funções
control_pid() {
    # prometheus.pid existe?
    if [[ -f $pid_file ]] ; then 
        # esse pid está vinculado ao um processo em execução?
        pgrep -F $pid_file

        if [[ $? -eq 1 ]] ; then
            # não está em execução
            rm $pid_file
        else
            # está em execução
            exit
        fi
    else
        # não existe
        echo $$ > $pid_file
    fi
}


start() {
    # Executa o prometheus em background
    /usr/sbin/prometheus \
        --config.file "$PROMETHEUS_CONFIG_FILE" \
        --web.listen-address=0.0.0.0:9090 \
        --web.console.templates $PROMETHEUS_CONSOLE_TEMPLATES \
        --web.console.libraries $PROMETHEUS_CONSOLE_LIBRARIES \
        2> "${PROMETHEUS_LOG_DIR}/errorlog-$(date +%Y-%m-%d)" \
        1> "${PROMETHEUS_LOG_DIR}/serverlog-$(date +%Y-%m-%d)" \
        &
}

restart() {
    # Restarta o prometheus
    kill -s SIGHUP $pid_file
}

stop() {
    # Para a execução do prometheus
    kill -s SIGSTOP $pid_file && rm $pid_file
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
        restart
        ;;
    
    -s)
        stop
        ;;
    
    *)
        control_pid
        start
        ;;

esac
