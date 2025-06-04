library(rstanarm)
library(posterior)

TeenSmoking <- read.csv("../data/edgy_teens.csv")
perWave <- split(TeenSmoking, TeenSmoking$newid)

barplot(table(unlist(lapply(perWave, nrow))))

summary(TeenSmoking)

barplot(table(TeenSmoking$sex.1.F.))

barplot(table(TeenSmoking$parsmk))

round(prop.table(table(TeenSmoking$sex.1.F., TeenSmoking$smkreg)), 2)
round(prop.table(table(TeenSmoking$parsmk, TeenSmoking$smkreg)), 2)


################
### Modelos "simples"
f1 <- "smkreg ~ sex.1.F. + parsmk + wave"
m1 <- glm(f1,
          family = "binomial",
          data = TeenSmoking)
summary(m1)

f2 <- "smkreg ~ parsmk + sex.1.F. * wave"
m2 <- glm(f2,
          family = "binomial",
          data = TeenSmoking)
summary(m2)


################
### Modelos multinível

options(mc.cores = parallel::detectCores())

mlf1 <- "smkreg ~ sex.1.F. + parsmk + wave + (1|newid)"
mod1 <- stan_glmer(mlf1,
                 family = "binomial",
                 data = TeenSmoking)

mod1

re1 <- ranef(mod1)
lattice::dotplot(re1, scales = list(x =list(relation = 'free')))


mlf2 <- "smkreg ~  parsmk + (1|newid) + (1 + wave|sex.1.F.)"
mod2 <- stan_glmer(mlf2,
                   family = "binomial",
                   data = TeenSmoking)

mod2

re2 <- ranef(mod2)
lattice::dotplot(re2, scales = list(x =list(relation = 'free')))
