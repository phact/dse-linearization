#!/bin/bash
threads=4
host=localhost
accounts=1000
cycles=10000
retrydelay=1
maxtries=100
type=cql


./ebdse -vv run type=$type yaml=ledger tags=phase:schema cycles=1 host=$host
./ebdse -vv run type=$type yaml=ledger tags=phase:table cycles=1 host=$host
./ebdse -vv run type=$type yaml=ledger tags=phase:write-create-accounts cycles=$cycles threads=$threads host=$host accounts=$accounts
./ebdse -vv run type=$type yaml=ledger tags=phase:write-lwt errors=retry maxtries=$maxtries cycles=$cycles threads=$threads host=$host accounts=$accounts retrydelay=$retrydelay
