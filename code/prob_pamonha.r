logit <- function (x) 
{
  log(x/(1 - x))
}
invlogit <- function (x) 
{
  1/(1 + exp(-x))
}
get_preds <- function(fit, alpha = 0.95){
  raw.preds <- predict(fit, se.fit = TRUE)
  Z <- qnorm(p = (1 + alpha)/2)
  link.lwr <- raw.preds$fit - Z*raw.preds$se.fit
  link.upr <- raw.preds$fit + Z*raw.preds$se.fit
  
  out <- data.frame(dose = fit$model$doses,
                    pred = invlogit(raw.preds$fit),
                    lwr = invlogit(link.lwr),
                    upr = invlogit(link.upr))
  return(out)
}
#######
beta0 <- arm::logit(.025)
beta1 <- 1.6E-2

set.seed(666)

n <- 100
doses <- runif(n, 0, 500) 
thetas <- arm::invlogit(beta0 + beta1 * doses)
Ys <- rbinom(n = n, size = 1, prob = thetas)

fit.logit <- glm(Ys~doses, family = binomial("logit"))
fit.probit <- glm(Ys~doses, family = binomial("probit"))

summary(fit.logit)
summary(fit.probit)

coef(fit.logit)[2]/coef(fit.probit)[2]

preds.logit <- get_preds(fit.logit)
preds.logit$modelo <- "logit"

preds.probit <- get_preds(fit.probit)
preds.probit$modelo <- "probit"

data4plot <- data.frame(
  dose = doses,
  dor = Ys
)
preds4plot <- rbind(preds.logit, preds.probit)

library(ggplot2)

the.plot <- ggplot(data = data4plot,
       aes(x = dose, y = dor)) +
  geom_point(size = 2) + 
  geom_line(data = preds4plot, 
            aes(x = dose, y = pred,
                colour = modelo, linetype = modelo),
            linewidth = 1.5) +
  geom_ribbon(data = preds4plot,
            aes(x = dose,
                ymin = lwr, ymax = upr,
                fill = modelo, linetype = modelo),
            alpha = .6,
            inherit.aes = FALSE) +
  scale_colour_manual(values = c("grey1", "#E69F00")) +
  scale_fill_manual(values = c("grey1", "#E69F00")) +
  scale_x_continuous("Dose de pamonha (gramas)", expand = c(0, 0)) +
  scale_y_continuous("Pr(Dor de barriga)") +
 theme_bw(base_size = 16)

the.plot

ggsave(
  plot = the.plot,
  filename = "palmirinha_dor.pdf",
  scale = 1,
  width = 297,
  height = 210,
  units = "mm",
  dpi = 300
)


### Now, a lil simulation 

simulate_and_fit <- function(n, i){
  
  beta0 <- rnorm(1, mean = 0, sd = .5)
  beta1 <- rnorm(1, mean = 1e-2, sd = 5e-3)
  doses <- runif(n, 0, 500) 
  thetas <- arm::invlogit(beta0 + beta1 * doses)
  Ys <- rbinom(n = n, size = 1, prob = thetas)
  
  fit.logit <- glm(Ys~doses, family = binomial("logit"))
  fit.probit <- glm(Ys~doses, family = binomial("probit"))
  
  return(data.frame(beta_0_l = coef(fit.logit)[1],
                    beta_0_p = coef(fit.probit)[1],
                    beta_1_l = coef(fit.logit)[2],
                    beta_1_p = coef(fit.probit)[2],
                    replicate = i))
}

Nrep <- 500
simus <- lapply(1:Nrep, function(i){
  simulate_and_fit(n = 100, i = i)
})
results <- do.call(rbind, simus)

results$LD50_l <- -results$beta_0_l/(results$beta_1_l + 1E-4)
results$LD50_p <- -results$beta_0_p/(results$beta_1_p + 1E-4)

plot(beta_1_l ~ beta_1_p, results)
abline(a = 0, b =  2 * sqrt(2/pi), lwd = 3)

plot(LD50_l ~ LD50_p, results)
