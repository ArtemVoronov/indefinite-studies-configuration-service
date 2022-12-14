#!/bin/bash

set -e
set -u

function create_database() {
	local database=$1
	echo "  Creating database '$database' \n"
	psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" "$POSTGRES_DB"<<-EOSQL
	    CREATE DATABASE $database;
	    GRANT ALL PRIVILEGES ON DATABASE $database TO $POSTGRES_USER;
EOSQL
	echo "  Created database '$database' \n"
	echo "  Granted all priveleges on '$database' to '$POSTGRES_USER' \n"
}

if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]; then
	echo "  Sleep 15 seconds \n"
    sleep 15
	echo "Multiple database creation requested: $POSTGRES_MULTIPLE_DATABASES"
	for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr ',' ' '); do
		create_database $db
	done
	echo "Multiple databases created"
fi
