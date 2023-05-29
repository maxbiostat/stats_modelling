Neste exercício, vamos estender o que é pedido no exercício 1 da seção 11.7 de `GH` (página 248).
Vamos analisar dados de infestação de roedores em Nova Iorque, e modelar a probabilidade de um apartamento estar infestado, levando em conta o distrito ("neighbourhood") e outras características específicas do imóvel em questão (como a etnia dos seus ocupantes).

Os dados estão [aqui](https://github.com/maxbiostat/stats_modelling/blob/master/data/mickey_mouse.csv) e foram obtidos assim
```r
rato <- read.table ("rodents.dat", header = TRUE)
apt <- read.table ("apt.dat", header = TRUE)

names(rato)
names(apt)

completo <- merge(apt, rato, by = "bldg")

write.csv(completo, file = "mickey_mouse.csv", row.names = FALSE)
```

Documentação [aqui](https://github.com/tjmahr/GelmanHill/blob/master/datasets/rodents/rodents.doc).
