#!/usr/bin/env bash

sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm

sudo dnf -qy module disable postgresql

sudo dnf install -y postgresql15-server

sudo /usr/pgsql-15/bin/postgresql-15-setup initdb


sudo systemctl enable postgresql-15

sudo systemctl start postgresql-15