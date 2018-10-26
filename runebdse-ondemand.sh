#!/bin/bash

set -x

host=localhost
REPLICATION=" {'class': 'SimpleStrategy', 'replication_factor': '1'}"
if [ $# -gt 0 ]; then
    echo $1
    host=$1
fi
if [ $# -gt 1 ]; then
    echo $2
    REPLICATION=$2
fi


threads=128
accounts=10
cycles=100000
retrydelay=1
maxtries=100
type=cql
rate=30

keyspace=dsbank


./ebdse -vv run type=$type yaml=ledger ks=$keyspace tags=phase:table cycles=1 host=$host REPLICATION="${REPLICATION}" ssl=openssl port=32306 keyPassword=datastax keyFilePath=/tmp/dmc-sebtestsmall-69f7bd/pkcs8_key.pem certFilePath=/tmp/dmc-sebtestsmall-69f7bd/cert caCertFilePath=/tmp/dmc-sebtestsmall-69f7bd/ca.crt host=491acbdf-8d43-4e40-a1b6-0285fc21ee8a.dbaas.datastax.com single-endpoint=true username=datastax password=datastax
./ebdse -vv run type=$type yaml=ledger tags=phase:table cycles=1 host=$host REPLICATION="${REPLICATION}" ssl=openssl port=32306 keyPassword=datastax keyFilePath=/tmp/dmc-sebtestsmall-69f7bd/pkcs8_key.pem certFilePath=/tmp/dmc-sebtestsmall-69f7bd/cert caCertFilePath=/tmp/dmc-sebtestsmall-69f7bd/ca.crt host=491acbdf-8d43-4e40-a1b6-0285fc21ee8a.dbaas.datastax.com single-endpoint=true username=datastax password=datastax ks=$keyspace 
./ebdse -vv run type=$type yaml=ledger tags=phase:write-create-accounts cycles=$cycles threads=$threads host=$host accounts=$accounts REPLICATION="${REPLICATION}" ssl=openssl port=32306 keyPassword=datastax keyFilePath=/tmp/dmc-sebtestsmall-69f7bd/pkcs8_key.pem certFilePath=/tmp/dmc-sebtestsmall-69f7bd/cert caCertFilePath=/tmp/dmc-sebtestsmall-69f7bd/ca.crt host=491acbdf-8d43-4e40-a1b6-0285fc21ee8a.dbaas.datastax.com single-endpoint=true username=datastax password=datastax ks=$keyspace 
./ebdse -vv run type=$type yaml=ledger tags=phase:write-lwt errors=retry maxtries=$maxtries cycles=$cycles threads=$threads host=$host accounts=$accounts retrydelay=$retrydelay targetrate=$rate REPLICATION="${REPLICATION}" ssl=openssl port=32306 keyPassword=datastax keyFilePath=/tmp/dmc-sebtestsmall-69f7bd/pkcs8_key.pem certFilePath=/tmp/dmc-sebtestsmall-69f7bd/cert caCertFilePath=/tmp/dmc-sebtestsmall-69f7bd/ca.crt host=491acbdf-8d43-4e40-a1b6-0285fc21ee8a.dbaas.datastax.com single-endpoint=true username=datastax password=datastax ks=$keyspace 
