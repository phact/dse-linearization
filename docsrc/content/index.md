---
title: DSE Linearization (LWTs)
type: index
weight: 10
---


The purpose of this asset is to help users quantify the performance impact of using LWTs for a banking ledger use case that requires linearizable transactions.

### Motivation

LightWeight Transactions are a feature in DSE that allow developers to enforce transaction linearization at the database. This functionality can be useful in use cases where this kind of isolation is needed, however the guarantee comes at a cost in terms of performance. Specifically, all LWT transactions will be slower than its non LWT counterpart (which rely on Last Write Wins semantics). Furthermore, partition contention (multiple parallel operations against the same partition) will create further performance slowdowns.

Depending on the SLAs for a particular use case, using LWTs may or may not be a good option. By informing users with real data, this asset helps show the tradeoffs of LWTs under different levels of partition contention to help determine if LWTs are the right option.

### What is included?

This field asset (demo) includes the following:

* EBDSE Activity for ledger transactions using LWTs
* Studio Notebook with queries and explanations
* Deck.gl powered UI for visualizing transactions

### Business Take Aways

Some use cases require linearization / isolation. Examples include inventory management (cannot sell more items than what we have in stock), user registration (cannot give the same user name to two individuals), accounting ledgers (non idempotent accounting operations must be executed in sequence and exactly once to avoid errors in the balance).
Often, DSE users encounter these types of use cases when migrating off mainframes.

### Technical Take Aways

Many techniques to deal with the need for linearization in distributed systems include writing complex application side logic and routing.
Using LWTs gives linearization guarantees at the database level with a performance cost.
EBDSE allows users to test realistic workloads with LWTs under different levels of partitoin contention and determine if LWTs are a viable aproach given specific requirements.

Requirements to keep in mind include:

* SLAs - read and write P99's
* Throughput in ops per second
* Partition contention at peak (worst case scenario concurrent requests against the same key)
* Do reads need to be linearizable as well or just writes?
* Consistency and availability requirements of the LWT (LOCAL or GLOBAL)

Note, there exist SERIAL and LOCAL_SERIAL Consistency Levels as well as a Serial Consistency Levels.

For local consistency (enforced serialization within the local DC) use CL LOCAL_SERIAL for LWT Reads and use CL LOCAL_QUORUM and Serial CL LOCAL_SERIAL for LWT Writes

For global consistency (enforced serialization accross DCs) use CL SERIAL for LWT Reads and use CL QUORUM and Serial CL SERIAL for LWT Writes

Global is significantly more expensive than local, this asset helps determine how much.
