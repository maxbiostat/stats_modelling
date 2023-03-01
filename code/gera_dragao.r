set.seed(666)
N <- 10
sfactor <- 5 ## Var(X) = sfactor * E[X]
mu <- 10
X <- rnbinom(N, size = mu/(sfactor - 1), mu = mu)

mean(X)
var(X)

dragonEgg.data <- list(N = N, x = X)

save(dragonEgg.data, file = "dragon.RData")