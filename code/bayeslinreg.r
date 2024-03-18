library(ggplot2)
library(bayesplot)
theme_set(theme_bw())
library(rstanarm)
data(kidiq)

fmod <- glm(kid_score ~ mom_hs * mom_iq, data = kidiq)

summary(fmod)

bmod <- stan_glm(kid_score ~ mom_hs * mom_iq,
                     data = kidiq)
summary(bmod)

pp_check(bmod, plotfun = "hist", nreps = 5)
pp_check(bmod, plotfun = "stat", stat = "mean")
pp_check(bmod, plotfun = "stat", stat = "sd")
pp_check(bmod, plotfun = "stat_2d", stat = c("mean", "sd"))
q95 <- function(x) quantile(x, .95)
pp_check(bmod, plotfun = "stat", stat = "q95")

IQ_SEQ <- seq(from = 75, to = 135, by = 5)
y_nohs <- posterior_predict(bmod, newdata = data.frame(mom_hs = 0, mom_iq = IQ_SEQ))
y_hs <- posterior_predict(bmod, newdata = data.frame(mom_hs = 1, mom_iq = IQ_SEQ))

par(mfrow = c(1:2), mar = c(5,4,2,1))
boxplot(y_hs, axes = FALSE, outline = FALSE, ylim = c(10,170),
        xlab = "Mom IQ", ylab = "Predicted Kid score", main = "Mom HS")
axis(1, at = 1:ncol(y_hs), labels = IQ_SEQ, las = 3)
axis(2, las = 1)
boxplot(y_nohs, outline = FALSE, col = "red", axes = FALSE, ylim = c(10,170),
        xlab = "Mom IQ", ylab = NULL, main = "Mom No HS")
axis(1, at = 1:ncol(y_hs), labels = IQ_SEQ, las = 3)