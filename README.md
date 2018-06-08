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
