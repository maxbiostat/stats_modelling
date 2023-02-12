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

### Modelos, hipóteses e a lógica da ciência

- SR Ch1;
- [Box (1976)](https://www-sop.inria.fr/members/Ian.Jermyn/philosophy/writings/Boxonmaths.pdf). Science and statistics. Journal of the American Statistical Association, 71(356), 791-799;
- [Nester (1996)](http://www.sortie-nd.org/lme/Statistical%20Papers/Nester_1996.pdf). An applied statistician's creed. Journal of the Royal Statistical Society: Series C (Applied Statistics), 45(4), 401-410.

### Modelo linear
- [Teorema de Gauss-Markov](https://en.wikipedia.org/wiki/Gauss%E2%80%93Markov_theorem);
- [Teorema de Frish-Waugh-Lovell](https://en.wikipedia.org/wiki/Frisch%E2%80%93Waugh%E2%80%93Lovell_theorem);
- [Linear models can’t keep up with sport gender gap](https://www.nature.com/articles/432147c.pdf).

### Família exponencial
- Duane Rich's videos: [part 1](https://youtu.be/xwM9XcnQ4Us) and [part 2](https://youtu.be/9EgkOn5mWcc) 

### Modelos lineares generalizados 
- Mccullagh & Nelder (1989) "Generalised linear models". [[PDF]](https://www.utstat.toronto.edu/~brunner/oldclass/2201s11/readings/glmbook.pdf).
 
### Transformações

- [Sakia, (1992)](https://www.jstor.org/stable/pdf/2348250.pdf?casa_token=ln4GDMAaMSoAAAAA:5OeirJhCZbzi40n28k3FEUf-pDKYINa0uGxe0P4yWUGV2GxqgWlUzFuzTnDuK10GTj94USu_e51AbA5mBPzFqI-r_lPjGbcsxd6GBLclNu7SuR4taQ). The Box‐Cox transformation technique: a review. Journal of the Royal Statistical Society: Series D (The Statistician), 41(2), 169-178.

### Reparametrização

- [Stan guide 24.2](https://mc-stan.org/docs/stan-users-guide/reparameterizations.html).
 
### Multicolinearidade

- [Alin (2010)](https://wires.onlinelibrary.wiley.com/doi/pdf/10.1002/wics.84?casa_token=7thEddWWSnMAAAAA:xkd0kOKnD_MJ2653zgulIlXytF-JRAY51DxLYThv2B0-4o3XjnUSoqIu0E5J5Lo_XzlYOtzbcp51kA). Multicollinearity. Wiley interdisciplinary reviews: computational statistics, 2(3), 370-374.

### Modelos multinivel

- [Why hierarchical models are awesome, tricky, and Bayesian](https://twiecki.io/blog/2017/02/08/bayesian-hierchical-non-centered/);
- Parametrização centrada _vs_ não-centrada: https://sjster.github.io/introduction_to_computational_statistics/docs/Production/Reparameterization.html.

### Tópicos especiais

- [Simpson's paradox](https://plato.stanford.edu/entries/paradox-simpson/), Seção 5; 
- [Does model averaging make sense?](https://atyre2.github.io/2017/06/16/rebutting_cade.html).

### Recursos úteis

- Neste [FAQ](http://bbolker.github.io/mixedmodels-misc/glmmFAQ.html#model-specification), Ben Bolker explica os principais tipos de modelos que podem ser ajustados com o pacote [lme4](https://cran.r-project.org/web/packages/lme4/index.html) do R, e, mais importante, discute as diferenças terminológicas que tão frequentemente causam confusão -- vide distinção entre "fixed" e "random" factors.

- O [livro](http://webcom.upmf-grenoble.fr/LIP/Perso/DMuller/M2R/R_et_Mixed/documents/Bates-book.pdf) de Douglas Bates sobre como usar o **lme4** para ajustar modelos "mistos".
