library(tidyverse)

navios <- read_csv("ships.csv")

head(navios)

hist(navios$accident)

normal <- lm(accident ~ op  + co.65.69 +
               co.70.74 + co.75.79 +service,
   navios)

summary(normal)


poisson <- glm(accident ~ op  + co.65.69 +
               co.70.74 + co.75.79 + service,
               family = "poisson",
             navios)

summary(poisson)

poissonTaxa <- glm(accident ~ op  + co.65.69 +
                 co.70.74 + co.75.79 + + offset(log(service)),
               family = "poisson",
               navios)

summary(poisson)
summary(poissonTaxa)

