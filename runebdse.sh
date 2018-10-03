#!/bin/bash

host=localhost
if [ $# -gt 0 ]; then
    echo $1
    host=$1
fi

threads=128
accounts=10
cycles=100000
retrydelay=1
maxtries=100
type=cql
rate=30


/tmp/ebdse/ebdse -vv run type=$type yaml=ledger tags=phase:schema cycles=1 host=$host
/tmp/ebdse/ebdse -vv run type=$type yaml=ledger tags=phase:table cycles=1 host=$host
/tmp/ebdse/ebdse -vv run type=$type yaml=ledger tags=phase:write-create-accounts cycles=$cycles threads=$threads host=$host accounts=$accounts
/tmp/ebdse/ebdse -vv run type=$type yaml=ledger tags=phase:write-lwt errors=retry maxtries=$maxtries cycles=$cycles threads=$threads host=$host accounts=$accounts retrydelay=$retrydelay targetrate=$rate
