#!/bin/bash
password=<password>
wait_time=15s

sleep $wait_time
/opt/mssql-tools/bin/sqlcmd -S 0.0.0.0,1433 -U sa -P $password -i ./init.sql
/opt/mssql-tools/bin/sqlcmd -S 0.0.0.0,1433 -d financeData -U sa -P $password -i ./sp.sql

