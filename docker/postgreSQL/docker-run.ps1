<#
docker run `
-d `
--name postgres-campuscloud `
--network campus-network `
-p 54320:5432 `
-e POSTGRES_PASSWORD=Puticerda13? `
-v campuscloud-postgres-data:/var/lib/postgresql/data `
--restart always `
postgres:16-bookworm
#>

docker run `
--env-file "$PSScriptRoot\.env" `
-d `
--name postgres-campuscloud `
--network campus-network `
-p 54320:5432 `
-v campuscloud-postgres-data:/var/lib/postgresql/data `
--restart always `
postgres:16-bookworm