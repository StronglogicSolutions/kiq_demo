#!/bin/bash

set -o errexit



init_user_and_db() {
  psql -h 0.0.0.0 -v ON_ERROR_STOP=1 -U postgres <<-EOSQL
     CREATE USER kiq_admin WITH PASSWORD 'kiq_admin';
     CREATE DATABASE kiq;
     GRANT ALL PRIVILEGES ON DATABASE kiq TO kiq_admin;
EOSQL
}

init_user_and_db
