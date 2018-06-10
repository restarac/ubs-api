# README

# Importação das UBS

Para a importação da base de dados é necessário existir um arquivo no diretorio `db/ubs.csv`.
A importanção poder ser executada, e reexcutada quantas vezes foram necessários pois ela é executada em modo append, ou seja, apenas serão incluidas as novas unidades. A atualizações de dados de unidades já existentes não está implementado

```bash
$ rake import:ubs
```

No console(e no log quando `RAILS_ENV=development`) serão exibidos todos os casos de sucesso e falha.

OBS: Um caso normal de erro frequente é a violação da chave unica do CNES, quando ocorre a inserção de uma unidade de saúde que já existe na base dados.

### Importando no docker

```bash
$ docker-compose run web rake import:ubs
```

# API: Busca por uma UBS

Verifique se a aplicação está rodando. (o index inicial `sua-app/` foi mantido para ser um tipo de healthcheck `¯\_(ツ)_/¯` )

Use a ferramenta que preferir para fazer a request (curl,postman,insonia...)

```
http://localhost:3000/ubs
```
Essa rota por padrão exibe todos as 10 primeiras UBS, sendo 10 por pagina e iniciando na primeira pagina.


Os parametros:
- query: Lat/Log para pesquisa (opcional)
- page: Página atual (default: 1)
- per_page: Itens por página (default: 10)

### Exemplo:
```
GET: http://localhost:3000/ubs?query=-10.911,-10.911&page=1&per_page=1
```

resultado:
```json
{  
   "current_page":1,
   "per_page":1,
   "total_entries":115,
   "entries":[  
      {  
         "id":24110,
         "name":"US EDEZIO VIEIRA DE MELO SIQUEIRA CAMPOS",
         "address":"RUA PARAIBA",
         "city":"SIQUEIRA CAMPOS",
         "phone":"7931792214",
         "geocode":{  
            "lat":-10.911,
            "long":-10.911
         },
         "scores":{  
            "size":3,
            "adaptation_for_seniors":3,
            "medical_equipment":1,
            "medicine":2
         }
      }
   ]
}
```

### Rotas
```
$ rake routes
OR
$ docker-compose run web rake routes
```

# Docker

### Requisitos:
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
