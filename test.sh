#!/bin/bash
export DB_ENV_POSTGRESQL_USER=pycsw
export DB_ENV_POSTGRESQL_PASS=pycsw
export DB_PORT_5432_TCP_ADDR=192.168.99.100
export DB_PORT_5432_TCP_PORT=5432
export DB_ENV_POSTGRESQL_DB=pycsw

eval "$(docker-machine env dev)"
docker build -t lukecampbell/docker-pycsw .
docker run --name pycsw-test -it \
    -e DB_ENV_POSTGRESQL_USER=$DB_ENV_POSTGRESQL_USER \
    -e DB_ENV_POSTGRESQL_PASS=$DB_ENV_POSTGRESQL_PASS \
    -e DB_PORT_5432_TCP_ADDR=$DB_PORT_5432_TCP_ADDR \
    -e DB_PORT_5432_TCP_PORT=$DB_PORT_5432_TCP_PORT \
    -e DB_ENV_POSTGRESQL_DB=$DB_ENV_POSTGRESQL_DB \
    lukecampbell/docker-pycsw
docker rm pycsw-test
