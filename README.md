# README

# Importação das UBS

Para a importação da base de dados é necessário existir um arquivo no diretorio `db/ubs.csv`.

Execute a rake(é importado em modo append):

```
$ rake import:ubs
```

No modo Append, apenas serão incluidas as novas unidades. Atualizações de valores de unidades já existentes não serão feitas.

No console(e mo log quando em `development`) serão exibidos todos os casos de sucesso e falha.

OBS: Um caso normal de erro frequente é a violação da chave unica do CNES.

# Docker

Requisitos:
 - docker
 - docker-compose

 A imagem do docker é `production ready` ou seja para o desenvolvimento vamos utilizar o docker-compose.

### Rodando a aplicação

* Precisamos criar a imagem do docker da nossa aplicação e baixar a imagem padrão do MYSQL 5.7.
  `docker-compose build`

* Vamos agora iniciar o container do docker em modo background
  `docker-compose up -d`

* Se for a primeira vez que o executa devemos criar o banco de dados
  `docker-compose run web rake db:create`

* Para executar migrations:
  ` docker-compose run web rails db:migrate`

* Para ver as 100 ultimas linhas de log em realtime:
  ` docker-compose logs -f --tail="100" web`

* Para parar os container utilize o comando
  `docker-compose stop`
  
Não utilize o `docker-compose down` pois ele removerá os conteiners criados sendo necessário recriar o container o que pode levar mais tempo do que simplesmente um `start`.
