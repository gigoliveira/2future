## Como Rodar o Projeto

Antes de executar o projeto, é necessário ter Java 21 e Node.js (v18.20.8) instalados e devidamente configurados na máquina para garantir que as dependências de build do backend e frontend sejam corretamente resolvidas.

A stack completa é executada com Docker Compose, incluindo containers para o banco de dados PostgreSQL, o servidor Keycloak, o serviço backend e o frontend.

Executar as seguintes ações:

Dentro da pasta 'keycloak-admin-service'
 1. Executar o comando mvn clean install 
 2. Executar o comando mvn clean spring-boot:run
Dentro da pasta 'custom-auth-spi'
 1. Executar o comando mvn clean install 
Dentro da pasta 'keycloak-spi-frontend'
 1. Executar o comando docker-compose build --no-cache
 2. Executar o comando docker compose up --build

Após todas as aplicações estarem rodando, aguardar até o keycloak iniciar. Checar tentando acessar a url http://localhost:8080

Certifique-se de executar o docker-compose up a partir da raiz do projeto custom-auth-spi.