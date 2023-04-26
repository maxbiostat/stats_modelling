load("dragon.RData")
dragonEgg.data


hist(dragonEgg.data$x,
     probability = TRUE,
     main = "Ovos de dragão (por macho)")

mean(dragonEgg.data$x)
range(dragonEgg.data$x)
var(dragonEgg.data$x)

library(cmdstanr)

modelo <- cmdstan_model("poisson_dragao.stan")

dragonEgg.data$X <- dragonEgg.data$x
dragonEgg.data$x <- NULL

amostras.da.posteriori <- modelo$sample(data = dragonEgg.data)

lambda.samples <- as.vector(amostras.da.posteriori$draws("lambda"))

hist(lambda.samples,
     main = "p(lambda|X)",
     xlab = expression(lambda))

mean(lambda.samples)

X.tilde.samples <- as.vector(amostras.da.posteriori$draws("X_pred"))

hist(X.tilde.samples,
     main = "p1(x_tilde|X)",
     xlab = expression(tilde(X)))

mean(X.tilde.samples)
var(X.tilde.samples)

modelo2 <- cmdstan_model("binomial_negativa_dragao.stan")

amostras.da.posteriori.nb <-
  modelo2$sample(data = dragonEgg.data)

mu.samples <- as.vector(amostras.da.posteriori.nb$draws("mu"))
phi.samples <- as.vector(amostras.da.posteriori.nb$draws("phi"))

hist(mu.samples, xlab= expression(mu))

hist(phi.samples, xlab= expression(phi))

var.samples <- mu.samples + mu.samples^2/phi.samples
hist(var.samples)
