# README

Ambiente criado usando php 5.6, mysql 5.7 e nginx

## Para que serve esse repositório?

- Imagem para executar os projetos com ambente totalmente dedicado para php legado - AS sistemas.

## Configurações:

### nginx

- Especificação da pasta do projeto dentro do arquivo de configuração do nginx.

`nginx/default.conf`

```conf
  listen 80;
  server_name localhost;

  root /var/www/html/*caminho_do_repositorio*;

```

- Inclua o caminho ao qual seu arquivo foi copiado dentro do container, esse é o caminho que o nginx usará para acessar o projeto.

### php

- O container já inclui a instalação do Composer e não necessita de nenhuma modificação, exceto se for necessária a inclusão de alguma biblioteca específica ao qual devem ser incluidas no arquivo `Dockerfile`.

### mysql

- Configuração para exportação da base de dados do projeto: seguindo os passos abaixo, o banco de dados será carregado junto com o container após ele ser iniciado.

- Carregue o arquivo do banco de dados dentro da pasta 'sql_dump' (caso necessário), para que ele seja carregado automaticamente junto com o container.

`docker-compose.yml`

```docker-compose
  volumes:
    # persite e carrega o banco ao qual vai ser importado
    - db_data:/var/lib/mysql
    # permite copia a base de dados carregada dentro da pasta sql_dump presente na raiz do projeto
    - ./sql_dump:/docker-entrypoint-initdb.d
```
