data{
  // Data
  int<lower=0> N;
  int<lower=0> P;
  matrix[N, P] X;
  vector[N] y;
  // Hyperparameters
  real<lower=0> a;
  real<lower=0> b;
  vector[P] mu_beta;
  real<lower=0> c;
  // Prediction stuff
  int<lower=0> M;
  matrix[M, P] X_pred;
}
transformed data{
  matrix[P, P] I_P = diag_matrix(rep_vector(1.0, P));
}
parameters{
  vector[P] beta;
  real<lower=0> sigma_sq;
}
model{
  // Priors
  sigma_sq ~ inv_gamma(a, b);
  beta ~ multi_normal(mu_beta, sigma_sq * c * I_P);
  // Likelihood
  y ~ normal(X * beta, sqrt(sigma_sq));
}
generated quantities{
  real y_pred[M];
  for(m in 1:M){
    y_pred[m] = normal_rng(X_pred[m, ] * beta, sqrt(sigma_sq));
  }
}

