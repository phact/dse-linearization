#!/bin/bash
threads=12
host=54.164.104.170
accounts=1
cycles=12
retrydelay=0
maxtries=100
type=cql
rate=3000
#consistency=QUORUM
#serial_consistency=SERIAL
consistency=LOCAL_QUORUM
serial_consistency=LOCAL_SERIAL



./ebdse -vv run type=$type yaml=ledger tags=phase:schema cycles=1 host=$host
./ebdse -vv run type=$type yaml=ledger tags=phase:table cycles=1 host=$host
./ebdse -vv run type=$type yaml=ledger tags=phase:write-create-accounts cycles=$cycles threads=$threads host=$host accounts=$accounts
#./ebdse -vv run type=$type yaml=ledger tags=phase:write-lwt errors=retry maxtries=$maxtries cycles=$cycles threads=$threads host=$host accounts=$accounts retrydelay=$retrydelay targetrate=$rate
./ebdse -vv run type=$type yaml=ledger tags=phase:write-lwt errors=retry maxtries=$maxtries cycles=$cycles threads=$threads host=$host accounts=$accounts retrydelay=$retrydelay consistency=$consistency serial_consistency=$serial_consistency
