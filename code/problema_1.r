## Nesse script vamos gerar dados segundo uma binomial negativa e
## vamos ajustar alguns modelos aos dados e criticá-los

#########
# preparação
library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = 4)

set.seed(666)

########
# Simulando os dados
N <- 100
sfactor <- 5 ## Var(X) = sfactor * E[X]
mu <- 10
X <- rnbinom(N, size = mu/(sfactor - 1), mu = mu)
hist(X, probability = TRUE, main = "Ovos de dragão (por macho)")

mean(X)
var(X)

dragonEgg.data <- list(N = N, x = X)
## 
poisson.code = "
data{
  int<lower=1> N;
  int<lower=0> x[N];
}
parameters{
  real<lower=0> lambda;
}
model{
  target += poisson_lpmf(x | lambda);
  target += gamma_lpdf(lambda | 1, 1);
}
generated quantities{
 int<lower=0> x_rep[N];
  for(i in 1:N) x_rep[i] = poisson_rng(lambda);
}
"

fit.poisson <- stan(model_code = poisson.code, data = dragonEgg.data)
poisson.replicas <- extract(fit.poisson, 'x_rep')$x_rep

par(mfrow = c(2, 1))

hist(X, probability = TRUE, col = "red", main = "Os dados")
abline(v = mean(X), lwd = 3, lty = 2)
hist(as.vector(poisson.replicas), probability = TRUE, 
     main = "Replicatas \n modelo Poisson", xlab = expression(x^{rep}))
abline(v = mean(X), lwd = 3, lty = 2)

par(mfrow = c(1, 1))

# Como nosso modelo "prevê" a média?
medias.poisson <- rowMeans(poisson.replicas)
hist(medias.poisson, probability = TRUE, xlab = expression(bar(x)),  main = "Médias \n modelo Poisson")
abline(v = mean(X), lwd = 3, lty = 2)

# E a variância?

variancias.poisson <- apply(poisson.replicas, 1, var)
hist(variancias.poisson, probability = TRUE,
     main = "Variâncias \n modelo Poisson", xlab = expression(hat(v)),
     xlim = c(min(variancias.poisson), 1.5*var(X)))
abline(v = var(X), lwd = 3, lty = 2)

## Veredito: o modelo não captura corretamente a variabilidade dos dados

## Vamos tentar um modelo hierárquico, mais complexo

poissonBinomial.code = "
data{
  int<lower=1> N;
  int<lower=0> x[N];
}
parameters{
  real<lower=0, upper=1> p;
  real<lower=0> lambda;
}
model{
  target += poisson_lpmf(x | lambda * p );
  target += beta_lpdf(p | 2, 2);
  target += gamma_lpdf(lambda | 1, 1);
}
generated quantities{
 int<lower=0> M_rep[N];
 int<lower=0> x_rep[N];
  for(i in 1:N){
    M_rep[i] = poisson_rng(lambda);
  }
  for(i in 1:N){
    x_rep[i] = binomial_rng(M_rep[i], p);
  } 
}
"

fit.poissonBinomial <- stan(model_code = poissonBinomial.code, data = dragonEgg.data)
print(fit.poissonBinomial, pars = c('p', 'lambda') )
poissonBinomial.replicas <- extract(fit.poissonBinomial, 'x_rep')$x_rep


par(mfrow = c(2, 1))

hist(X, probability = TRUE, col = "red", main = "Os dados")
abline(v = mean(X), lwd = 3, lty = 2)
hist(as.vector(poissonBinomial.replicas), xlab = expression(x^{rep}), 
     probability = TRUE, main = "Replicatas \n modelo Poisson-binomial")
abline(v = mean(X), lwd = 3, lty = 2)

# "Previsão" da média pelo modelo Poisson-binomial

par(mfrow = c(1, 1))

medias.poissonBinomial <- rowMeans(poissonBinomial.replicas)
hist(medias.poissonBinomial, probability = TRUE,
     xlab = expression(bar(x)),  main = "Médias \n modelo Poisson-binomial")
abline(v = mean(X), lwd = 3, lty = 2)


# Mais uma vez, vamos olhar a variância

variancias.poissonBinomial <- apply(poissonBinomial.replicas, 1, var)
hist(variancias.poissonBinomial, probability = TRUE,
     main = "Variâncias \n modelo Poisson-binomial", xlab = expression(hat(v)),
     xlim = c(min(variancias.poisson), 1.5*var(X)))
abline(v = var(X), lwd = 3, lty = 2)

## Resultado: o modelo ainda é ruim. 

# Vamos tentar agora um modelo com uma estrutura hierárquica diferente

poissonGamma.code = "
data{
  int<lower=1> N;
  int<lower=0> x[N];
}
parameters{
  real<lower=0> alpha;
  real<lower=0> beta;
  real<lower=0> lambda[N];
}
model{
  target += poisson_lpmf(x | lambda);
  target += gamma_lpdf(lambda | alpha, beta);
  target += exponential_lpdf(alpha | 1);
  target += exponential_lpdf(beta | 1);
}
generated quantities{
 int<lower=0> x_rep[N];
  for(i in 1:N){
    x_rep[i] = poisson_rng(lambda[i]);
  }
}
"

fit.poissonGamma <- stan(model_code = poissonGamma.code, data = dragonEgg.data)
print(fit.poissonGamma, pars = c('alpha', 'beta') )
poissonGamma.replicas <- extract(fit.poissonGamma, 'x_rep')$x_rep

par(mfrow = c(2, 1))

hist(X, probability = TRUE, col = "red", main = "Os dados")
abline(v = mean(X), lwd = 3, lty = 2)
hist(as.vector(poissonGamma.replicas), xlab = expression(x^{rep}),
     probability = TRUE, main = "Replicatas \n modelo Poisson-gama")
abline(v = mean(X), lwd = 3, lty = 2)

# "Previsão" da média pelo modelo Poisson-Gamma

par(mfrow = c(1, 1))

medias.poissonGamma <- rowMeans(poissonGamma.replicas)
hist(medias.poissonGamma, probability = TRUE,
     xlab = expression(bar(x)),  main = "Médias \n modelo Poisson-Gama")
abline(v = mean(X), lwd = 3, lty = 2)


# Mais uma vez, vamos olhar a variância

variancias.poissonGamma <- apply(poissonGamma.replicas, 1, var)
hist(variancias.poissonGamma, probability = TRUE, xlab = expression(hat(v)) ,
     main = "Variâncias \n modelo Poisson-Gama", xlim = c(min(variancias.poisson), 1.5*var(X)))
abline(v = var(X), lwd = 3, lty = 2)

# Intervalos
quantile(as.vector(poisson.replicas), probs = c(.025, .975))
quantile(as.vector(poissonBinomial.replicas), probs = c(.025, .975))
quantile(as.vector(poissonGamma.replicas), probs = c(.025, .975))
qnbinom(p =  c(.025, .975), size = mu/(sfactor - 1), mu = mu)