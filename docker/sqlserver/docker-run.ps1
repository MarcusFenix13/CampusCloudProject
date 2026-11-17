docker run `
--env-file "$PSScriptRoot\.env" `
-d `
--name sqlserver-campuscloud `
--network campus-network `
-p 14330:1433 `
-v campuscloud-sql-data:/var/opt/mssql `
--restart always `
mcr.microsoft.com/mssql/server:2025-CU8-ubuntu-24.04