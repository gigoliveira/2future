postgres

docker
docker run -d --name postgres-db -e POSTGRES_USER=user -e POSTGRES_PASSWORD=mudar1234 -e POSTGRES_DB=keycloakDB -p 5432:5432 -v pgdata:/var/lib/postgresql/data postgres:latest

docker run -d --name postgres-db -e POSTGRES_USER=user -e POSTGRES_PASSWORD=mudar1234 -e POSTGRES_DB=mydatabase -p 5432:5432 -v pgdata:/var/lib/postgresql/data postgres:latest

docker run -d --name keycloak -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin -e KC_DB=postgres -e KC_DB_URL=jdbc:postgresql://host.docker.internal:5432/keycloakDB -e KC_DB_USERNAME=user -e KC_DB_PASSWORD=mudar1234 -e KC_HOSTNAME=localhost quay.io/keycloak/keycloak:26.1.4 start-dev

26.1.4

java
mvn archetype:generate -DgroupId=com.keycloak -DartifactId=custom-auth-spi -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false

comando para ver id das imagens Docker
docker ps

comando para ver pastas de uma imagem Docker
docker exec ad51197640c9 ls -l /opt/keycloak

comando para copiar arquivo para dentro de uma imagem Docker com ID da imagem
docker cp target\custom-auth-spi-1.0-SNAPSHOT.jar ad51197640c9:/opt/keycloak/providers/

após copiar reestartar o keycloak
docker restart ad51197640c9



OPOS INSTALAR O NODE DÁ UMA ZICA PARA CRIAR UMA APLICAÇÃO REACT
EXECUTE ESSES COMANDOS PARA DEIXAR TININO

mkdir "%USERPROFILE%\AppData\Roaming\npm"
npm config set prefix "%USERPROFILE%\AppData\Roaming\npm"
npm config set cache "%USERPROFILE%\AppData\Local\npm-cache"

comando para instalar a aplicação react
npx create-react-app keycloak-spi-frontend --template typescript

instalar rotas
npm install react-router-dom


comando para buildar aplicação React
npm install


