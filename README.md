# Modelagem Estatística

Como diz a [ementa](https://emap.fgv.br/disciplina/graduacao/modelagem-estatistica), o propósito desta disciplina é expor a estudante aos princípios básicos da modelagem estatística de dados, em particular aos modelos de regressão.
Para auxiliar a busca pelo conhecimento, há uma bibliografia comentada [aqui](https://github.com/maxbiostat/stats_modelling/blob/master/biblio/bibliografia_anotada.pdf). 

**AVISO 0**: todos os documentos listados aqui serão atualizados à medida que o curso avança.

**AVISO 1**: caso haja dificuldade em obter quaisquer dos materiais listados (PDFs de artigos, por exemplo), entrar em contato com os professores para que possamos compartilhar o material _para fins acadêmicos e de uso pessoal_.

### News
- Na aula de quarta-feira (12/02/2020), vamos trabalhar um problema bem simples de modelagem estatística: com base num conjunto de observações de números (que parecem) naturais, prever a distribuição de observações futuras.
Durante a aula, entre outras coisas, vamos estudar e criticar os modelos de Poisson,  Poisson-Binomial hierárquico (Casella & Berger, pg. 164, example 4.4.1) e Poisson-Gamma para dados de contagem.
Discutiremos vários aspectos da modelagem estatística de dados a partir desse exemplo simples.
O plano é apresentar um panorama da disciplina, tocando nos tópicos de identificabilidade, adequação do modelo, predições a priori e a posteriori, construção do modelo.
O script para reproduzir as análises mostradas em sala está [aqui](https://github.com/maxbiostat/stats_modelling/blob/master/code/problema_1.r).
Mais informações sobre a binomial negativa e a representação Poisson-Gamma, ver [estas](https://www.johndcook.com/negative_binomial.pdf) notas, em especial a seção 4.

- A aula de segunda-feira (17/02/2020) será sobre inferência bayesiana e cadeias de Markov Monte Carlo (MCMC). Vejam [este](https://chi-feng.github.io/mcmc-demo/app.html) applet para uma ilustração (visualização) de vários métodos modernos -- e alguns nem tanto -- de MCMC, aplicados a várias distribuições-alvo. 
Como material de apoio, um pouco mais técnico, recomendamos este [artigo](https://projecteuclid.org/euclid.ss/1177011137) de Charlie Geyer e também outros materiais disponibilizados por ele em sua [página pessoal](http://users.stat.umn.edu/~geyer/). 

- A aula de quarta-feira (04/03) cobriu uma introdução aos modelos lineares generalizados (GLMs) e uma discussão das conexões entre estes modelos e estruturas causais. 
OBS: sobre a discussão paralela da conexão entre redes neurais e GLMs, ver [esta pergunta](https://stats.stackexchange.com/questions/369987/is-a-single-neuron-in-a-neural-network-a-glm) no CrossValidated e [este](http://blog.shakirm.com/2015/01/a-statistical-view-of-deep-learning-i-recursive-glms/) blog post.  

- [Estatística Bayesiana: um crash course](https://cran.r-project.org/web/packages/LaplacesDemon/vignettes/BayesianInference.pdf).

- Regressão Bayesiana aplicada com o pacote **rstanarm**: (i) [introdução](https://cran.r-project.org/web/packages/rstanarm/vignettes/rstanarm.html) e (ii) [lista de exemplos](https://cran.r-project.org/web/packages/rstanarm/vignettes/).

- Em regressão linear, o estimador de máxima verossimilhança (EMV) e o estimador de mínimos quadrados (EMQ) coincidem. [Dedução](https://stats.stackexchange.com/a/254003/97431) e [mais detalhes](http://www.robots.ox.ac.uk/~fwood/teaching/W4315_Fall2011/Lectures/lecture_3/lecture_3.pdf). Notar em particular os slides 29 e 30 do segundo link; há sempre um compromisso entre viés e eficiência (variância).  

- O exercício sobre estimação da prevalência pode ser encontrado [aqui](https://github.com/maxbiostat/stats_modelling/blob/master/notes/problema_prevalencia.pdf).
Podem usar o source em `.tex`como base para preparrarem as respostas.
Dúvidas são bem-vindas (via email).

- Paper sobre integrated nested Laplace approximation (INLA): [Approximate Bayesian inference for latent Gaussian models by using integrated nested Laplace approximations](https://rss.onlinelibrary.wiley.com/doi/epdf/10.1111/j.1467-9868.2008.00700.x).

- [Paper](https://arxiv.org/pdf/1911.10500.pdf) sobre causalidade em aprendizado de máquina, por Bernhard Schölkopf.

- Sobre elicitação de prioris: [SHeffield ELicitation Framework (SHELF) package](http://www.tonyohagan.co.uk/shelf/).

- Sobre a questão da projeção de prioris não-informativas: [Hidden Dangers of Specifying Noninformative Priors](https://www.tandfonline.com/doi/abs/10.1080/00031305.2012.695938).

- [Estimating Prevalence Using an Imperfect Test](http://downloads.hindawi.com/archive/2011/608719.pdf). Paper do Peter Diggle sobre a estimação da prevalencia. Ele aborda a questão pelas óticas frequentista e bayesiana.

- Trabalho sobre regressão: escolher uma pergunta científica e respondê-la através do uso de um modelo de regressão (possivelmente um GLM). Tópicos a se discutir: predições _a priori_ e _a posteriori_; análise de pontos influentes (distância de Cook ou PSIS); intepretação dos coeficientes; manipulação dos preditores (covariáveis) para explorar o fenomeno estudado. Aqui está a análise que eu mencionei durante a aula: [An Analysis of the New York City Police Department’s “Stop-and-Frisk” Policy in the Context of Claims of Racial Bias](http://www.stat.columbia.edu/~gelman/research/published/frisk9.pdf).

- Sobre o tópico do trabalho anterior, este [artigo](http://www.stat.columbia.edu/~gelman/research/unpublished/specificity.pdf)  faz uma analise da prevalência de COVID-19 levando em conta um série de incertezas e ainda usando pós-estratificação.

- [Decomposição QR](https://mc-stan.org/users/documentation/case-studies/qr_regression.html) em modelos de regressão.

- [Artigo](https://www.sciencedirect.com/science/article/pii/S0047259X09000876) sobre a elicitação de uma priori para a matriz de correlação utilizando apenas um parametro (eta).

### Tópicos de discussão

#### 1) Teste de hipóteses, ou p-valores: yay or nay?

 - O que significa testar uma hipótese? Ver capítulos iniciais do McElreath;
 
 - As bases do frequentismo;
 
 - [Statement](https://www.tandfonline.com/doi/full/10.1080/00031305.2016.1154108) da JASA (2016);
 
 - Críticas  (contemporâneas) ao statement da JASA (ver recursos úteis abaixo) e também [este](https://hdsr.mitpress.mit.edu/pub/bd5k4gzf) artigo;
 
#### 2) Modelos estatísticos: construção, interpretação e avaliação crítica.
Neste ciclo de seminários teremos três tópicos, a serem cobertos em três apresentações:
- Tópico I:  Modelos (no sentido mais amplo)
   - Ler e discutir os seguintes artigos: [Levins, 1966](https://www.jstor.org/stable/pdf/27836590.pdf?casa_token=7tSi2uV0FvMAAAAA:pOA0tm3YnGbEgyv6GWFHQp0skImzirrSRkOznEPGnrhh8ATBAXMC9GTOuIkUWLw55pGTz4dX6SEdCJmW546H7aNyEvgSAo58uphzbEXPLUf029BaaQQzhA), [Orzack & Sober, 1993](https://www.jstor.org/stable/pdf/3037250.pdf) e [Levins, 1993](https://www.jstor.org/stable/pdf/3037251.pdf). Cobrir as noções de generalidade (generality), realismo (realism) e precisão (precision). Cobrir a "taxonomia de modelos" de Orzack e Sober, tanto da perspectiva atribuída a Levins quanto as recomendações feitas pelos autores. Discutir a possibilidade de maximização das três características (generalidade, realismo e precisão) simultaneamente.

- Tópico II: Construção e interpretação de modelos e seus parâmetros.
   - Cobrir pelo menos um dos seguintes tópicos:
     - (i) [Table II fallacy (Westreich & Greenland, 2013)](https://academic.oup.com/aje/article/177/4/292/147738).
     Cobrir o conceito de confounding e de seu ajuste em modelos de regressão;
     - (ii) [Paradoxo de Simpson (Armistead, 2014 e comentário por Judea Pearl)](https://www.tandfonline.com/doi/pdf/10.1080/00031305.2013.807750).
     Explicar o paradoxo de Simpson e sua relevância para a inferência estatística e científica;
     - (iii) [Interação e modificação de efeito (Wanderweele, 2009)](https://journals.lww.com/epidem/Fulltext/2009/11000/Four_Types_of_Effect_Modification__A.16.aspx).
     Definir e exemplificar interações em modelos e discutir a conexão com o conceito de identificabilidade. Conceituar modificação de efeito e seus tipos;
     - (iv) [All models are wrong, but some are useful (Box, 1976)](https://en.wikipedia.org/wiki/All_models_are_wrong);
   Cobrir os famosos aforismos de Box, o "Creed" de Nester e as principais discussões do assunto, inclusive críticas (e.g. Steele). **OBS: NÃO SE ATER SOMENTE AO CONTEÚDO DA PÁGINA DA WIKIPÉDIA**.
 
- Tópico III: Modelagem Estatística:
  - Cobrir pelo menos um dos seguintes tópicos:
    - (i) [Formalismo estatístico para quantificação da incerteza (Berger & Smith, 2018)](https://www.annualreviews.org/doi/full/10.1146/annurev-statistics-030718-105232).
    Descrever o formalismo e pelo menos dois dos exemplos;
     - (ii) [Estatística x Aprendizado de Máquina (Breiman, 2001 e comentários)](https://projecteuclid.org/download/pdf_1/euclid.ss/1009213726);
     Conceituar as "duas culturas" apresentadas por Breiman. Discutir: existem mesmo duas culturas? O que mudou (e não) desde a publicação do paper?;
      - (iii) [Reconciliando modelos determinísticos e estruturas probabilísticas (Poole & Raftery, 2000)](https://www.tandfonline.com/doi/pdf/10.1080/01621459.2000.10474324);
     Explicar o paradoxo de Borel. Como conciliar um modelo determinístico com um mundo (aparentemente) estocástico?
      - (iv) [DAGs e modelos causais (Aalen et al., 2016)](https://journals.sagepub.com/doi/pdf/10.1177/0962280213520436);
      Como DAGs auxiliam na formulação de explicações causais? O que pode dar errado? Quais as alternativas/soluções? Discutir pelo menos dois exemplos.       

#### 3) Métodos computacionais para o ajuste (Bayesiano) de modelos

Neste ciclo de seminários, vamos estudar as ferramentas computacionais disponíveis para ajustar modelos estatísticos a dados das mais diversas fontes. Por escolha, vamos nos concentrar nas técnicas Bayesianas de análise. O aparato metodológico envolvido aqui vai girar em torno do método de cadeias de Markov Monte Carlo (MCMC).

- Tópico I: MCMC: o básico
  - Cobrir os seguintes tópicos:
    - Método de Monte Carlo e o teorema central do limite;
    - Algoritmo de Metropolis;
    - Conceitos: burn-in/warmup, autocorrelação, convergência.    
 Referências: além daquelas listadas acima para a aula de 17/02/2020, ver também as seções 1 e 2 de [Betancourt (2017)](https://arxiv.org/pdf/1701.02434.pdf).
 
- Tópico II: Diagnósticos gráficos
  - Cobrir os seguintes tópicos, *sempre com exemplos*:
    - Trace plots;
    - Autocorrelograma;
    - Histograma (porquê?);
    - Divergências (plot), seção 4 de [Gabry et al. (2019)](https://rss.onlinelibrary.wiley.com/doi/full/10.1111/rssa.12378). 

- Tópico III: Diagnósticos quantitativos
  - Cobrir os seguintes tópicos, *sempre com exemplos*:
    - Gelman-Rubin (Rhat);
    - Geweke;
    - Effective sample size.

Fontes de consulta para II e III: [Cowles & Carlin, (1996)](https://www.tandfonline.com/doi/abs/10.1080/01621459.1996.10476956), [Roy (2020)](https://www.annualreviews.org/doi/pdf/10.1146/annurev-statistics-031219-041300), [Bayesplot](https://cran.r-project.org/web/packages/bayesplot/vignettes/visual-mcmc-diagnostics.html).




### Recursos úteis (comentados)

- Neste [FAQ](http://bbolker.github.io/mixedmodels-misc/glmmFAQ.html#model-specification), Ben Bolker explica os principais tipos de modelos que podem ser ajustados com o pacote [lme4](https://cran.r-project.org/web/packages/lme4/index.html) do R, e, mais importante, discute as diferenças terminológicas que tão frequentemente causam confusão -- vide distinção entre "fixed" e "random" factors.

- O [livro](http://webcom.upmf-grenoble.fr/LIP/Perso/DMuller/M2R/R_et_Mixed/documents/Bates-book.pdf) de Douglas Bates sobre como usar o `lme4` para ajustar modelos "mistos".

- Quem se interessa sobre uma visão profunda e favorável do frequentismo pode consultar o blog da filósofa Deborah Mayo, [Error Statistics Philosophy](https://errorstatistics.com/).

- Neste [artigo](https://www.phil.vt.edu/dmayo/personal_website/Error_Statistics_2011.pdf), Aris Spanos e Deborah Mayo dão uma visão moderna do frequentismo.

- Nesta [edição especial](https://www.tandfonline.com/toc/utas20/73/sup1) da _American_  _Statistician_,  temos uma vasta coleção de artigos sobre p-valores e seu uso. 
Recomendamos em particular o artigo de Sander Greenland, "Valid P-Values Behave Exactly as They Should: Some Misleading Criticisms of P-Values and Their Resolution With S-Values".
