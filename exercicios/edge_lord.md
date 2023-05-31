## Entendendo e explicando o comportamento de fumo em adolescentes australianos

Neste exercício queremos estudar a probabilidade de um adolescente fumar a partir de dados _longitudinais_, isto é, amostrados ao longo do tempo.

Os dados foram medidos em três "ondas" de amostragem (waves) e variáveis como se os pais fumam e o sexo do adolescente foram medidas. Os dados (`(edgy_teens.csv)[https://github.com/maxbiostat/stats_modelling/blob/master/data/edgy_teens.csv]`) têm essa cara:
```r
> head(smoke.pub)
  newid sex.1.F. parsmk wave smkreg
1     1        1      0    1      0
2     1        1      0    2      0
3     1        1      0    4      0
4     1        1      0    5      0
5     1        1      0    6      0
6     2        0      0    1      0
```

A variável de interesse é se o adolescente fuma ou não em cada onda (`smkreg`). 
