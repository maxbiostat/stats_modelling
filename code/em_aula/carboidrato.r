carb <- read.csv("carbohydrate.csv")

plot(carb)

head(carb , 2)

m1 <- lm(carbohydrate~age, carb)
m2 <- lm(carbohydrate~weight, carb)

fullmod <- glm(carbohydrate~., carb, family = "gaussian")

log_lik <- function(beta, sigma = 5.956){
  mu <- as.matrix(cbind(rep(1, nrow(carb)), carb[, -1])) %*% beta
  ll <- dnorm(x = carb$carbohydrate,
              mean = mu, sd = sigma,
              log = TRUE)
  return(-sum(ll))
}

Opt <- optim(c(0, 0, 0, 0),
      fn = log_lik, hessian = TRUE)

beta.hat <- Opt$par
coef(fullmod)
beta.hat

sqrt(diag(solve(Opt$hessian)))
ss$coefficients[, 2]
