library(tidyverse)
set.seed(20240424)

A <- 0
B <- 5
n <- 5000
temp <- round(abs(rnorm(
  n = n, mean = 60, sd = 4
)), 1)
ph <- round(runif(n = n, min = 7, max = 8), 2)
milho <- rbinom(n, size = 1, prob = pi / 10)
year <- sample(1987:2024, n, replace = TRUE)

eta <- 2 - .3 * temp + 1.5 * ph + 1 * ph * milho
ps <-  1 / (1 + exp(-eta))
y <- rbinom(n = n,
            size = 1, prob = ps)

glic <- exp(rnorm(
  n = n,
  mean = y * -2,
  sd = .1 + y / 10
))
glic <- glic/max(glic) * 97

pamonha <- tibble(
  ano = sort(year),
  temperatura = temp,
  pH = ph,
  milho = ifelse(milho == 1, "Comum", "BRS3046"),
  sacarose = round(glic, 2),
  boa = y
)

head(pamonha)

write_csv(pamonha, "../data/qualidade_pamonha.csv")


