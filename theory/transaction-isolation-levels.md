
# MySQL

```mysql
SELECT @@transaction_isolation;
SELECT @@global.transaction_isolation;
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```

- read uncommitted (dirty read!)
- read committed (phantom read!)
- repeatable read 
  - in a transaction, the same query will always return the same result
  - after update, the result can be different, because it updates based on the correct values (data committed from other transactions)
- serializable
  - the most strict isolation level
  - selects lock updates in other transactions, until the transaction is committed

![isolation-levels-mysql.png](assets%2Fisolation-levels-mysql.png)

# PostgreSQL

```postgresql
show transaction isolation level;

--only inside of transaction
set transaction isolation level read uncommitted;
```
    
- read uncommitted is the same as read committed (so basically doesn't work)
- read committed (phantom read occurrs, like in MySQL)
- repeatable read
    - in a transaction, the same query will always return the same result
    - if two transactions update same data, the second transaction fails
    - SERIALIZATION ANOMALY
      - two inserts of the same data will be ok in two concurrent transactions
- serializable
  - SERIALIZATION ANOMALY
    - error => hint: the transaction might succeed if retried

![isolation-levels-postgres.png](assets%2Fisolation-levels-postgres.png)
![isolation-levels-comparison.png](assets%2Fisolation-levels-comparison.png)