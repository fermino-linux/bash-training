#!/usr/bin/env bash
#
# Autor: 
#    Fermino
# Versão:
#   1.0
# Descrição:
#   Faz a instalação do maven
# Exemplos:
#   Instala o maven
#       $ install.sh 
#

## Prepara o java, utilizando o pacote do projeto eclipse-temurin
get_temurin() {
    local url="https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.5%2B8/OpenJDK17U-jdk_x64_linux_hotspot_17.0.5_8.tar.gz"
    local filename="temurin.tar.gz"

    curl -fsSLo $filename $url

    mkdir /opt/temurin && \
        chmod 755 /opt/temurin && \
        tar -C /opt/temurin --strip-components 1 -xf $filename
}

cd /tmp && get_temurin

url="https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz"
filename="maven.tar.gz"

curl -fsSLo $filename $url
mkdir /opt/maven && \
    chmod 775 /opt/maven && \
    tar -C /opt/maven --strip-components 1 -xf $filename


JAVA_HOME="/opt/temurin"
PATH="${JAVA_HOME}/bin:$PATH"
PATH="/opt/maven/bin:$PATH"

export JAVA_HOME
export PATH



