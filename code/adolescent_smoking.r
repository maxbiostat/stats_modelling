TeenSmoking <- read.table("smoke_pub.dat", 
           header = TRUE)
perWave <- split(TeenSmoking, TeenSmoking$newid)

barplot(table(unlist(lapply(perWave, nrow))))

summary(TeenSmoking)

library(rstanarm)

options(mc.cores = parallel::detectCores())

mformula <- "smkreg ~ sex.1.F. + parsmk + wave + (1|newid)"
mod1 <- stan_glmer(mformula,
                 family = "binomial",
                 data = TeenSmoking)

as_draws(mod1)
