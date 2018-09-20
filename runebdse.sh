#!/bin/bash
threads=2
host=localhost
./ebdse -vv run type=cql yaml=ledger tags=phase:schema cycles=1 host=$host
./ebdse -vv run type=cql yaml=ledger tags=phase:table cycles=1 host=$host
./ebdse -vv run type=cql yaml=ledger tags=phase:write-create-accounts cycles=100000 threads=$threads host=$host
./ebdse -vv run type=cql yaml=ledger tags=phase:write-lwt cycles=100000 threads=$threads host=$host
