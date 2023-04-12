data{
  int<lower=1> N; // numero de ninhadas
  int<lower=0> X[N]; // tamanhos das ninhadas
}
parameters{
  real<lower=0> mu;
  real<lower=0> phi;
}
model{
  mu ~ gamma(1, 1);
  phi ~ gamma(1, 1);
  X ~ neg_binomial_2(mu, phi);
}
generated quantities{
  int X_pred = neg_binomial_2_rng(mu, phi); // p(x_tilde|X)
}
