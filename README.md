# Modelagem Estatística

Como diz a [ementa](https://emap.fgv.br/disciplina/graduacao/modelagem-estatistica), o propósito desta disciplina é expor a estudante aos princípios básicos da modelagem estatística de dados, em particular aos modelos de regressão.
Para auxiliar a busca pelo conhecimento, há uma bibliografia comentada [aqui](https://github.com/maxbiostat/stats_modelling/blob/master/biblio/bibliografia_anotada.pdf). 

**AVISO**: todos os documentos listados aqui serão atualizados à medida que o curso avança.
 
- Na aula de quarta-feira (10/02/2020), vamos trabalhar um problema bem simples de modelagem estatística: com base num conjunto de observações de números (que parecem) naturais, prever a distribuição de observações futuras.
Durante a aula, entre outras coisas, vamos estudar e criticar os modelos de Poisson,  Poisson-Binomial hierárquico (Casella & Berger, pg. 164, example 4.4.1) e Poisson-Gamma para dados de contagem.
Discutiremos vários aspectos da modelagem estatística de dados a partir desse exemplo simples.
O plano é apresentar um panorama da disciplina, tocando nos tópicos de identificabilidade, adequação do modelo, predições a priori e a posteriori, construção do modelo.
O script para reproduzir as análises mostradas em sala está [aqui](https://github.com/maxbiostat/stats_modelling/blob/master/code/problema_1.r).
Mais informações sobre a binomial negativa e a representação Poisson-Gamma, ver [estas](https://www.johndcook.com/negative_binomial.pdf) notas, em especial a seção 4.


### Tópicos de discussão

#### 1) Teste de hipóteses, ou p-valores: yay or nay?

 - O que significa testar uma hipótese? Ver capítulos iniciais do McElreath;
 
 - As bases do frequentismo;
 
 - [Statement](https://www.tandfonline.com/doi/full/10.1080/00031305.2016.1154108) da JASA (2016);
 
 - Críticas  (contemporâneas) ao statement da JASA (ver recursos úteis abaixo) e também [este](https://hdsr.mitpress.mit.edu/pub/bd5k4gzf) artigo;
 

### Recursos úteis (comentados)

- Neste [FAQ](http://bbolker.github.io/mixedmodels-misc/glmmFAQ.html#model-specification), Ben Bolker explica os principais tipos de modelos que podem ser ajustados com o pacote [lme4](https://cran.r-project.org/web/packages/lme4/index.html) do R, e, mais importante, discute as diferenças terminológicas que tão frequentemente causam confusão -- vide distinção entre "fixed" e "random" factors.

- O [livro](http://webcom.upmf-grenoble.fr/LIP/Perso/DMuller/M2R/R_et_Mixed/documents/Bates-book.pdf) de Douglas Bates sobre como usar o `lme4` para ajustar modelos "mistos".

- Quem se interessa sobre uma visão profunda e favorável do frequentismo pode consultar o blog da filósofa Deborah Mayo, [Error Statistics Philosophy](https://errorstatistics.com/).

- Neste [artigo](https://www.phil.vt.edu/dmayo/personal_website/Error_Statistics_2011.pdf), Aris Spanos e Deborah Mayo dão uma visão moderna do frequentismo.

- Nesta [edição especial](https://www.tandfonline.com/toc/utas20/73/sup1) da _American_  _Statistician_,  temos uma vasta coleção de artigos sobre p-valores e seu uso. 
Recomendamos em particular o artigo de Sander Greenland, "Valid P-Values Behave Exactly as They Should: Some Misleading Criticisms of P-Values and Their Resolution With S-Values" .




