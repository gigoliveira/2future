## Como Rodar o Projeto
   Antes de executar o projeto, é necessário ter Java 21 e Node.js (v18.20.8) instalados e devidamente configurados na máquina para garantir que as dependências de build do backend e frontend sejam corretamente resolvidas.

   A stack completa é executada com Docker Compose, incluindo containers para o banco de dados PostgreSQL, o servidor Keycloak, o serviço backend e o frontend.

   Certifique-se de executar o docker-compose up a partir da raiz do projeto. A comunicação entre serviços utiliza nomes dos containers via bridge network padrão do Docker.