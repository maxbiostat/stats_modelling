library(cmdstanr)
library(tidyverse)

conjugate <- cmdstan_model("linear_regression_conjugate.stan")

kidIQ <- read_csv("kidiq.csv")

newX <- cbind(rep(1, nrow(kidIQ)),
              kidIQ$mom_hs, kidIQ$mom_iq,
              kidIQ$mom_age)
P <- ncol(newX)

linreg.data <- list(
  N = nrow(kidIQ),
  P = P,
  X = newX,
  y = kidIQ$kid_score,
  a = 1,
  b = 1,
  mu_beta = rep(0, P),
  c = 1,
  M = nrow(kidIQ),
  X_pred = newX
)

ajuste1 <- conjugate$sample(data = linreg.data,
                            chains = 4)

ajuste1

amostras <- ajuste1$draws()


ytilde1 <- as.array(amostras)[,, 'y_pred[1]']
hist(ytilde1, probability = TRUE)
abline(v = kidIQ$kid_score[1], lty = 2,  lwd = 3)

ytilde10 <- as.array(amostras)[,, 'y_pred[10]']
hist(ytilde10, probability = TRUE)
abline(v = kidIQ$kid_score[10], lty = 2,  lwd = 3)
