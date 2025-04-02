postgres


docker run -d --name postgres-db -e POSTGRES_USER=user -e POSTGRES_PASSWORD=mudar1234 -e POSTGRES_DB=keycloakDB -p 5432:5432 -v pgdata:/var/lib/postgresql/data postgres:latest
