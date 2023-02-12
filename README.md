# Modelagem Estatística

Como diz a [ementa](https://emap.fgv.br/disciplina/modelagem-estatistica-0), o propósito desta disciplina é expor a estudante aos princípios básicos da modelagem estatística, em particular aos modelos de regressão.
Para auxiliar a busca pelo conhecimento, há uma bibliografia comentada [aqui](https://github.com/maxbiostat/stats_modelling/blob/master/biblio/bibliografia_anotada.pdf). 

**AVISO 0**: todos os documentos listados aqui serão atualizados à medida que o curso avança.

**AVISO 1**: caso haja dificuldade em obter quaisquer dos materiais listados (PDFs de artigos, por exemplo), entrar em contato com o professor para que eu possa compartilhar o material _para fins acadêmicos e de uso pessoal_.

**Monitor**: [**@isaquepim**](https://github.com/isaquepim)

Programa **aproximado** [aqui](https://docs.google.com/spreadsheets/d/1biX7q_WJzZ3vPQ9nj3W0kaKNELU5suCHgXUPV77z-Bs/edit?usp=sharing).

### Bibliografia

- [[ROS]](https://avehtari.github.io/ROS-Examples/) Gelman, A., Hill, J., & Vehtari, A. (2020). Regression and other stories. Cambridge University Press.
- [[SR]](https://xcelab.net/rm/statistical-rethinking/) McElreath, R. (2020). Statistical rethinking: A Bayesian course with examples in R and Stan. Chapman and Hall/CRC.
- [[GH]](http://www.stat.columbia.edu/~gelman/arm/) Gelman, A., & Hill, J. (2006). Data analysis using regression and multilevel/hierarchical models. Cambridge university press.

### News
- No dia 15/02 não haverá aula.

### Introdução e motivação

- SR Ch1;
- [Box (1976)](https://www-sop.inria.fr/members/Ian.Jermyn/philosophy/writings/Boxonmaths.pdf). Science and statistics. Journal of the American Statistical Association, 71(356), 791-799;
- [Nester (1996)](http://www.sortie-nd.org/lme/Statistical%20Papers/Nester_1996.pdf). An applied statistician's creed. Journal of the Royal Statistical Society: Series C (Applied Statistics), 45(4), 401-410.

### Modelos, hipóteses e a lógica da ciência
### Modelo linear
### Testes para modelos de regressão 
### Família exponencial
### Modelos lineares generalizados 
### Transformações
### Reparametrização
### Multicolinearidade
### Modelos multinivel

### Recursos úteis

- Neste [FAQ](http://bbolker.github.io/mixedmodels-misc/glmmFAQ.html#model-specification), Ben Bolker explica os principais tipos de modelos que podem ser ajustados com o pacote [lme4](https://cran.r-project.org/web/packages/lme4/index.html) do R, e, mais importante, discute as diferenças terminológicas que tão frequentemente causam confusão -- vide distinção entre "fixed" e "random" factors.

- O [livro](http://webcom.upmf-grenoble.fr/LIP/Perso/DMuller/M2R/R_et_Mixed/documents/Bates-book.pdf) de Douglas Bates sobre como usar o `lme4` para ajustar modelos "mistos".
