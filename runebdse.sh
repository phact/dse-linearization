#!/bin/bash
threads=128
host=54.164.104.170
accounts=100000
cycles=100000
retrydelay=1
maxtries=100
type=cql
rate=3000


./ebdse -vv run type=$type yaml=ledger tags=phase:schema cycles=1 host=$host
./ebdse -vv run type=$type yaml=ledger tags=phase:table cycles=1 host=$host
./ebdse -vv run type=$type yaml=ledger tags=phase:write-create-accounts cycles=$cycles threads=$threads host=$host accounts=$accounts
./ebdse -vv run type=$type yaml=ledger tags=phase:write-lwt errors=retry maxtries=$maxtries cycles=$cycles threads=$threads host=$host accounts=$accounts retrydelay=$retrydelay targetrate=$rate
