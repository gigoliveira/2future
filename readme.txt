postgres

docker
docker run -d --name postgres-db -e POSTGRES_USER=user -e POSTGRES_PASSWORD=mudar1234 -e POSTGRES_DB=keycloakDB -p 5432:5432 -v pgdata:/var/lib/postgresql/data postgres:latest

docker run -d --name postgres-db -e POSTGRES_USER=user -e POSTGRES_PASSWORD=mudar1234 -e POSTGRES_DB=mydatabase -p 5432:5432 -v pgdata:/var/lib/postgresql/data postgres:latest

docker run -d --name keycloak -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin -e KC_DB=postgres -e KC_DB_URL=jdbc:postgresql://host.docker.internal:5432/keycloakDB -e KC_DB_USERNAME=user -e KC_DB_PASSWORD=mudar1234 -e KC_HOSTNAME=localhost quay.io/keycloak/keycloak:26.1.4 start-dev




docker run -d --name keycloak -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin -e KC_DB=postgres -e KC_DB_URL=jdbc:postgresql://host.docker.internal:5432/keycloakDB -e KC_DB_USERNAME=user -e KC_DB_PASSWORD=mudar1234 -e KC_HOSTNAME=localhost -e KC_PROXY=edge -e KC_HTTP_CORS=true -e KC_HTTP_CORS_ORIGIN="*" -e KC_HTTP_CORS_ALLOWED_ORIGINS="http://localhost:5173" -e KC_HTTP_CORS_ALLOWED_METHODS="GET,POST,OPTIONS,PUT,DELETE" -e KC_HTTP_CORS_ALLOWED_HEADERS="Authorization,Content-Type,Accept,X-Konneqt-Token" quay.io/keycloak/keycloak:26.1.4 start-dev




26.1.4

comando para criar aplicação java com spring boot no vscode
spring initializr

clean java Project
mvnw clean package

comando java para buildar projeto
mvn clean install  

rodar api
mvn clean spring-boot:stop

mvn spring-boot:run

mvn clean spring-boot:run

clean after config Docker 
mvn clean package -DskipTests


java
mvn archetype:generate -DgroupId=com.keycloak -DartifactId=custom-auth-spi -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false

comando para ver id das imagens Docker
docker ps

comando para ver pastas de uma imagem Docker
docker exec 32d3952e5cab ls -l /opt/keycloak

comando para copiar arquivo para dentro de uma imagem Docker com ID da imagem
docker cp target\custom-auth-spi-1.0-SNAPSHOT.jar 19caeb649b8b:/opt/keycloak/providers/

docker stop keycloak

após copiar reestartar o keycloak
docker restart 19caeb649b8b



OPOS INSTALAR O NODE DÁ UMA ZICA PARA CRIAR UMA APLICAÇÃO REACT
EXECUTE ESSES COMANDOS PARA DEIXAR TININO

mkdir "%USERPROFILE%\AppData\Roaming\npm"
npm config set prefix "%USERPROFILE%\AppData\Roaming\npm"
npm config set cache "%USERPROFILE%\AppData\Local\npm-cache"

comando para instalar a aplicação react
npx create-react-app keycloak-spi-frontend --template typescript

instalar rotas
npm install react-router-dom

aqui
comando para buildar aplicação React
npm install

comandos para rodar composer

docker compose config

remover composer Docker
docker-compose down -v

docker compose build

subir composer Docker
docker compose up -d

docker-compose build --no-cache  

comando para forçar re import realm
docker compose down -v
docker compose up --build

docker-compose up --force-recreate

docker exec -it keycloak /opt/keycloak/bin/kcadm.sh update realms/test -s 'cors=true' -s 'corsAllowedOrigins=["http://localhost:5173"]' -s 'corsAllowedMethods=["POST","GET","OPTIONS"]' -s 'corsAllowedHeaders=["X-Konneqt-Token","Content-Type"]'-s 'corsAllowCredentials=true'



docker exec -t 5c651dcc7347 pg_dump -U user -d keycloakDB > database_dump.sql








DOCUMENTAÇÃO
INSTALAR
- DOCKER
- NODE 19
- 
