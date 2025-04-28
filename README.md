# Modelagem Estatística

Como diz a [ementa](https://emap.fgv.br/disciplina/modelagem-estatistica-0), o propósito desta disciplina é expor a estudante aos princípios básicos da modelagem estatística, em particular aos modelos de regressão.
Para auxiliar a busca pelo conhecimento, há uma bibliografia comentada [aqui](https://github.com/maxbiostat/stats_modelling/blob/master/biblio/bibliografia_anotada.pdf). 

**AVISO 0**: todos os documentos listados aqui serão atualizados à medida que o curso avança.

**AVISO 1**: caso haja dificuldade em obter quaisquer dos materiais listados (PDFs de artigos, por exemplo), entrar em contato com o professor para que eu possa compartilhar o material _para fins acadêmicos e de uso pessoal_.

**AVISO 2**: Os materiais listados neste repositório são **adicionais** à bibliografia recomendada (ver abaixo).

### Notas de aula

- Lição 1: [Inferência aproximada: o valor de uma premissa](https://github.com/maxbiostat/stats_modelling/blob/master/notas/licao_1.pdf).
- Lição 2: [Modelos, hipóteses e a lógica da ciência](https://github.com/maxbiostat/stats_modelling/blob/master/notas/licao_2.pdf).
- Lição 3: [Regressão linear: o melhor modelo ruim que você já viu](https://github.com/maxbiostat/stats_modelling/blob/master/notas/licao_3.pdf).
- Lição 4: [Regressão linear múltipla: _the madness continues_](https://github.com/maxbiostat/stats_modelling/blob/master/notas/licao_4.pdf).
- Lição 5: [Regressão linear múltipla bayesiana: 🎶_girl put your Bayesian hat on_🎶:](https://github.com/maxbiostat/stats_modelling/blob/master/notas/licao_5.pdf).

### News

- [Exercícios de revisão para a A1 2025](https://github.com/maxbiostat/stats_modelling/blob/master/notas/revisao_A1_2025.pdf)

### Provas anteriores
- [A1 2023](https://github.com/maxbiostat/stats_modelling/blob/master/provas/PDF/P1_ModEst_BSc_2023_solucoes.pdf).
- [A1 2024](https://github.com/maxbiostat/stats_modelling/blob/master/provas/PDF/P1_ModEst_BSc_2024_solucoes.pdf).
- [AS 2024](https://github.com/maxbiostat/stats_modelling/blob/master/provas/PDF/PS_ModEst_BSc_2024_solucoes.pdf).
- [A1 2025](https://github.com/maxbiostat/stats_modelling/blob/master/provas/PDF/P1_ModEst_BSc_2025_solucoes.pdf).

### Portifólio de trabalhos finais (A2):
- [2023](https://github.com/maxbiostat/A2_StatMod_2023).

### Bibliografia

 - [[DB]](https://books.google.com.br/books?hl=en&lr=&id=AS_3DwAAQBAJ&oi=fnd&pg=PP1&ots=JbfEyj69P9&sig=XFYw6n60M1woXu5BmO047WujoG8&redir_esc=y#v=onepage&q&f=false) Dobson, A. J., & Barnett, A. G. (2018). An introduction to generalized linear models. CRC press.
- [[ROS]](https://avehtari.github.io/ROS-Examples/) Gelman, A., Hill, J., & Vehtari, A. (2020). Regression and other stories. Cambridge University Press.
- [[SR]](https://xcelab.net/rm/statistical-rethinking/) McElreath, R. (2020). Statistical rethinking: A Bayesian course with examples in R and Stan. Chapman and Hall/CRC.
- [[GH]](http://www.stat.columbia.edu/~gelman/arm/) Gelman, A., & Hill, J. (2006). Data analysis using regression and multilevel/hierarchical models. Cambridge university press.

#### Bibliografia auxiliar

 - [[FH]](https://link.springer.com/book/10.1007/978-3-662-63882-8) Fahrmeir, L., Kneib, T., Lang, S., & Marx, B. (2013). Regression: Models, Methods and Applications. Springer Science & Business Media.
 - [[MN]](https://www.utstat.toronto.edu/~brunner/oldclass/2201s11/readings/glmbook.pdf) McCullagh, P., & Nelder, J. A. (1989). Generalized Linear Models (Vol. 37). CRC Press.
   
### News
- 2024-04-03: (**alguns**) Exercícios de revisão para a A1 [aqui](https://github.com/maxbiostat/stats_modelling/blob/master/notas/revisao_A1_2024.pdf).

### Modelos, hipóteses e a lógica da ciência

- SR Ch1;
- [Box (1976)](https://www-sop.inria.fr/members/Ian.Jermyn/philosophy/writings/Boxonmaths.pdf). Science and statistics. Journal of the American Statistical Association, 71(356), 791-799;
- [Nester (1996)](http://www.sortie-nd.org/lme/Statistical%20Papers/Nester_1996.pdf). An applied statistician's creed. Journal of the Royal Statistical Society: Series C (Applied Statistics), 45(4), 401-410.

### Modelo linear
- [Teorema de Gauss-Markov](https://en.wikipedia.org/wiki/Gauss%E2%80%93Markov_theorem);
- [Teorema de Frish-Waugh-Lovell](https://en.wikipedia.org/wiki/Frisch%E2%80%93Waugh%E2%80%93Lovell_theorem);
- [Linear models can’t keep up with sport gender gap](https://www.nature.com/articles/432147c.pdf).
- Uma explicação intuitiva da "hat matrix" ou matriz de projeção **H** está [nesta](https://stats.stackexchange.com/questions/208242/hat-matrix-and-leverages-in-classical-multiple-regression) resposta no CrossValidated.

#### Modelo linear: abordagem bayesiana

Os conjuntos de notas a seguir cobrem mais ou menos o mesmo material, com abordagens levemente diferentes.

- [Notas](https://ams206-winter19-01.courses.soe.ucsc.edu/system/files/attachments/banerjee-bayesian-linear-model-details.pdf) do grande [Sudipto Banerjee](http://sudipto.bol.ucla.edu/);
- [Notas](https://tminka.github.io/papers/minka-linear.pdf) de Thomas Minka.
- [Monografia](https://arxiv.org/pdf/2406.01819v1) de J. Andrés Christen.

### Família exponencial
- Esses dois videos (em inglês) do canal _Mutual Information_ de Duane Rich são bem interessantes: [parte 1](https://youtu.be/xwM9XcnQ4Us) and [parte 2](https://youtu.be/9EgkOn5mWcc) 

### Modelos lineares generalizados 
- Mccullagh & Nelder (1989) "Generalised linear models". [[PDF]](https://www.utstat.toronto.edu/~brunner/oldclass/2201s11/readings/glmbook.pdf).

### Critérios de bondade do ajuste (_goodness-of-fit_)
- [Notas](https://faculty.washington.edu/yenchic/19A_stat535/Lec7_model.pdf) sobre a derivação do AIC e BIC. Notem como para o modelo linear, os critérios de informação podem ser escritos em função da soma de quadrados. Acidente?

### Transformações

- [Sakia, (1992)](https://www.jstor.org/stable/pdf/2348250.pdf?casa_token=ln4GDMAaMSoAAAAA:5OeirJhCZbzi40n28k3FEUf-pDKYINa0uGxe0P4yWUGV2GxqgWlUzFuzTnDuK10GTj94USu_e51AbA5mBPzFqI-r_lPjGbcsxd6GBLclNu7SuR4taQ). The Box‐Cox transformation technique: a review. Journal of the Royal Statistical Society: Series D (The Statistician), 41(2), 169-178.

### Reparametrização

- [Stan guide 24.2](https://mc-stan.org/docs/stan-users-guide/reparameterizations.html).
 
### Multicolinearidade

- [Alin (2010)](https://wires.onlinelibrary.wiley.com/doi/pdf/10.1002/wics.84?casa_token=7thEddWWSnMAAAAA:xkd0kOKnD_MJ2653zgulIlXytF-JRAY51DxLYThv2B0-4o3XjnUSoqIu0E5J5Lo_XzlYOtzbcp51kA). Multicollinearity. Wiley interdisciplinary reviews: computational statistics, 2(3), 370-374.

### Modelos multinivel

- [Why hierarchical models are awesome, tricky, and Bayesian](https://twiecki.io/blog/2017/02/08/bayesian-hierchical-non-centered/);
- Parametrização centrada _vs_ não-centrada: [link](https://sjster.github.io/introduction_to_computational_statistics/docs/Production/Reparameterization.html).

### Tópicos especiais

- [Simpson's paradox](https://plato.stanford.edu/entries/paradox-simpson/), Seção 5; 
- [Does model averaging make sense?](https://atyre2.github.io/2017/06/16/rebutting_cade.html).
-  Modelos com inflação de zeros (e _hurdle models_): (i) [Seção relevante do Stan guide](https://mc-stan.org/docs/stan-users-guide/zero-inflated.html), (ii) [Post](https://stats.stackexchange.com/a/81854/387680) no StackExchange e (iii) [Discussão](https://stats.stackexchange.com/questions/320924/is-a-hurdle-model-really-one-model-or-just-two-separate-sequential-models) sobre _hurdle models_ no StackExchange.  

### Recursos úteis

- Neste [FAQ](http://bbolker.github.io/mixedmodels-misc/glmmFAQ.html#model-specification), Ben Bolker explica os principais tipos de modelos que podem ser ajustados com o pacote [lme4](https://cran.r-project.org/web/packages/lme4/index.html) do R, e, mais importante, discute as diferenças terminológicas que tão frequentemente causam confusão -- vide distinção entre "fixed" e "random" factors.

- O [livro](http://webcom.upmf-grenoble.fr/LIP/Perso/DMuller/M2R/R_et_Mixed/documents/Bates-book.pdf) de Douglas Bates sobre como usar o **lme4** para ajustar modelos "mistos".
- Dados de `GH` costumam ficar [aqui](http://www.stat.columbia.edu/~gelman/arm/). Como backup, usar [este](https://github.com/tjmahr/GelmanHill/tree/master/datasets) repo. 
- Os dados de `ROS` têm repositório próprio, [aqui](https://github.com/avehtari/ROS-Examples/tree/master). 
