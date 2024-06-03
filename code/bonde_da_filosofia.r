bonde <- read.csv("../data/bondinho.csv")
bonde$response <- as.factor(bonde$response)

logit <- function(x) log(x) - log1p(-x) 
invlogit <- function(x)  1/(1 + exp(-x))
  
## AED de levinho

states <- sort(unique(bonde$response))
frequencias <- table(bonde$response)/nrow(bonde)
freq.cum <- cumsum(frequencias)
cum.razao.chances <- freq.cum/(1 - freq.cum)
log.cum.rc <- log(cum.razao.chances)

par(mfrow = c(1, 3))
barplot(frequencias)
plot(freq.cum~states, type = "b", ylab = "Frequencia acumulada")
plot(log.cum.rc~states, type = "b", ylab = "Freq. acumulada (logit)")

## Modelagem 

library(MASS)

# Só o intercepto
mod1 <- polr(response ~ 1, data = bonde, Hess = TRUE)
summary(mod1)

# Incluindo preditores
mod2 <- polr(response ~ action + intention + contact,
             data = bonde, Hess = TRUE)

summary(mod2)

## Comparando
grid.tratamento <- expand.grid(
  action = c(0, 1),
  intention = c(0, 1),
  contact = c(0, 1)
)
cbind(
  grid.tratamento,
  predict(mod2, type = "probs", newdata = grid.tratamento)
)


