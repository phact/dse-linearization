#!/bin/bash
threads=2
host=localhost
accounts=1
cycles=100
type=stdout

#./ebdse -vv run type=$type yaml=ledger tags=phase:schema cycles=1 host=$host
#./ebdse -vv run type=$type yaml=ledger tags=phase:table cycles=1 host=$host
#./ebdse -vv run type=$type yaml=ledger tags=phase:write-create-accounts cycles=$cycles threads=$threads host=$host accounts=$accounts
./ebdse -vvv run type=$type yaml=ledger tags=phase:write-lwt cycles=$cycles threads=$threads host=$host accounts=$accounts
