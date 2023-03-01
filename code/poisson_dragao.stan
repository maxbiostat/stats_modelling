data{
  int<lower=1> N; // numero de ninhadas
  int<lower=0> X[N]; // tamanhos das ninhadas
}
parameters{
  real<lower=0> lambda;
}
model{
  lambda ~ gamma(1, 1);
  X ~ poisson(lambda);
}
generated quantities{
  int X_pred = poisson_rng(lambda); // p(x_tilde|X)
}
