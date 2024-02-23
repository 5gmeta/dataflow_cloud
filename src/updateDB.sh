#!/bin/sh

# Scripts for updating the dataflow_DB_CLOUD based on dbml file

docker-compose run --rm dbml_cli sh -c "
cd /home/sql_scripts/;
dbml2sql dataflow_DB_CLOUD.dbml --mysql -o mysql/dataflow_DB_CLOUD_mysql.sql;
dbml2sql dataflow_DB_CLOUD.dbml --postgresql -o postgresql/dataflow_DB_CLOUD_postgresql.sql;
"
