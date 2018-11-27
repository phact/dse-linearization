#!/bin/bash


host=localhost
if [ $# -gt 0 ]; then
    echo $1
    host=$1
fi

threads=12
accounts=1
cycles=100000
maxtries=100
type=cql
rate=3000
#consistency=QUORUM
#serial_consistency=SERIAL
consistency=LOCAL_QUORUM
serial_consistency=LOCAL_SERIAL
retryreplace=true
retrydelay=0
maxretrydelay=500



/tmp/ebdse/ebdse -vv run type=$type yaml=ledger tags=phase:schema cycles=1 host=$host
/tmp/ebdse/ebdse -vv run type=$type yaml=ledger tags=phase:table cycles=1 host=$host
/tmp/ebdse/ebdse -vv run type=$type yaml=ledger tags=phase:write-create-accounts cycles=$cycles threads=$threads host=$host accounts=$accounts
#./ebdse -vv run type=$type yaml=ledger tags=phase:write-lwt errors=retry maxtries=$maxtries cycles=$cycles threads=$threads host=$host accounts=$accounts retrydelay=$retrydelay targetrate=$rate
/tmp/ebdse/ebdse -vv run type=$type yaml=ledger tags=phase:write-lwt errors=retry maxtries=$maxtries cycles=$cycles threads=$threads host=$host accounts=$accounts retrydelay=$retrydelay consistency=$consistency serial_consistency=$serial_consistency retryreplace=$retryreplace maxretrydelay=$maxretrydelay
