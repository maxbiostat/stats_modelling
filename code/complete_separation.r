## ============================================================
##  Complete Separation in Logistic Regression
##  Teaching script for Statistical Modelling (advanced UG)
##  ------------------------------------------------------------
##  Topics covered:
##    A. Multivariate setting (p=5): separation in one predictor
##       1.  Data generation
##       2.  Standard MLE — blowup on X1 only, other SEs huge too
##       3.  Detection heuristics
##       4.  Firth's penalised-likelihood correction (brglm2)
##       5.  Bayesian correction (arm::bayesglm, Cauchy prior)
##       6.  Profile log-likelihood of beta_1 + posterior density overlay
##       7.  Coefficient comparison plot (MLE / Firth / Bayes)
##    B. Hidden multivariate separation (p=2)
##       8.  Data: no single predictor separates, a linear combination does
##       9.  MLE blowup detected; each marginal looks fine
##      10.  Scatterplot revealing the hidden separating hyperplane
##      11.  Firth & Bayes corrections
## ============================================================

library(ggplot2)
library(brglm2)   # Firth penalised MLE
library(arm)      # bayesglm (Cauchy / t prior)

set.seed(42)


## ============================================================
## ── PART A ──────────────────────────────────────────────────
## Multivariate logistic regression, p = 5 predictors.
## X1 causes complete separation; X2-X5 are noise.
## The MLE for beta_1 diverges; the other coefficients are
## dragged along and their SEs also blow up.
## ============================================================

## ── A1. Generate data ─────────────────────────────────────────
n  <- 40

X1 <- c(runif(n/2, -3, -0.1),   # Y = 0: X1 strictly negative
         runif(n/2,  0.1,  3))   # Y = 1: X1 strictly positive
X2 <- rnorm(n, mean = 0, sd = 1)
X3 <- rnorm(n, mean = 0, sd = 1)
X4 <- rnorm(n, mean = 0, sd = 1)
X5 <- rnorm(n, mean = 0, sd = 1)
Y  <- c(rep(0, n/2), rep(1, n/2))

dat5 <- data.frame(Y = Y, X1 = X1, X2 = X2, X3 = X3, X4 = X4, X5 = X5)


## ── A2. Standard MLE ─────────────────────────────────────────
## Note: ALL SEs are huge even though only X1 separates.
## The Fisher information matrix is (near-)singular;
## variance inflates across all coordinates.
fit_mle5 <- suppressWarnings(
  glm(Y ~ X1 + X2 + X3 + X4 + X5, family = binomial, data = dat5)
)


## ── A3. Separation detection ──────────────────────────────────
coef_tab5 <- coef(summary(fit_mle5))
flag_sep5 <- any(abs(coef_tab5[, "Estimate"]) > 10 &
                 coef_tab5[, "Std. Error"] > 100)
## flag_sep5 is TRUE

## Geometric check on X1 alone
gap_X1 <- min(X1[Y == 1]) - max(X1[Y == 0])
## gap_X1 > 0 confirms complete separation in X1


## ── A4. Firth-corrected MLE ───────────────────────────────────
fit_firth5 <- glm(Y ~ X1 + X2 + X3 + X4 + X5,
                  family = binomial,
                  data   = dat5,
                  method = brglm2::brglmFit)


## ── A5. Bayesian logistic regression (Cauchy prior) ───────────
## arm::bayesglm uses a t-prior on the coefficients.
## prior.scale = 2.5, prior.df = 1 gives Cauchy(0, 2.5) --
## the weakly informative prior recommended by Gelman et al. (2008).
## This prior has heavy tails (accommodates genuine large effects)
## but finite mass at any finite value, so the posterior mode is
## always finite even under complete separation.
fit_bayes5 <- arm::bayesglm(
  Y ~ X1 + X2 + X3 + X4 + X5,
  family      = binomial,
  data        = dat5,
  prior.scale = 2.5,   # Cauchy scale (= prior SD for df = Inf)
  prior.df    = 1      # df = 1 => Cauchy; df = Inf => Normal
)


## ── A6. Profile log-likelihood vs posterior density for beta_1 ─
## Fix all other coefficients at their Firth estimates and sweep
## beta_1 to produce a 1-D profile.  Overlay the posterior under
## the Cauchy prior to show how the prior regularises the
## unbounded likelihood into a proper density.

beta_other <- coef(fit_firth5)[-2]   # intercept, X2..X5 at Firth values

profile_ll <- function(b1) {
  eta <- beta_other[1] +
         b1             * dat5$X1 +
         beta_other[2]  * dat5$X2 +
         beta_other[3]  * dat5$X3 +
         beta_other[4]  * dat5$X4 +
         beta_other[5]  * dat5$X5
  p <- plogis(eta)
  p <- pmax(pmin(p, 1 - 1e-15), 1e-15)
  sum(dat5$Y * log(p) + (1 - dat5$Y) * log(1 - p))
}

cauchy_log_prior <- function(b1, scale = 2.5)
  -log(pi * scale) - log(1 + (b1 / scale)^2)

b1_grid <- seq(0.5, 25, length.out = 500)
ll_vals <- sapply(b1_grid, profile_ll)
lp_vals <- ll_vals + sapply(b1_grid, cauchy_log_prior)

## Normalise log-posterior to an approximate density
lp_norm  <- lp_vals - max(lp_vals)
post_den <- exp(lp_norm) / (sum(exp(lp_norm)) * diff(b1_grid[1:2]))

## Scale likelihood to same vertical range for overlay
ll_den <- exp(ll_vals - max(ll_vals))
ll_den <- ll_den / (sum(ll_den) * diff(b1_grid[1:2]))

df_dens <- data.frame(b1 = b1_grid, lik_dens = ll_den, post_den = post_den)

p_dens <- ggplot(df_dens, aes(x = b1)) +
  geom_line(aes(y = lik_dens, colour = "Likelihood (scaled)"),
            linewidth = 1.1) +
  geom_line(aes(y = post_den, colour = "Posterior | Cauchy(0,2.5)"),
            linewidth = 1.1, linetype = "dashed") +
  scale_colour_manual(
    values = c("Likelihood (scaled)"       = "#d7191c",
               "Posterior | Cauchy(0,2.5)" = "#2166ac")) +
  labs(
    title    = "Profile likelihood vs posterior density for beta_1 (separating predictor)",
    subtitle = "Likelihood has no finite mode; Cauchy prior creates a proper posterior",
    x        = expression(beta[1]),
    y        = "Density (normalised)",
    colour   = NULL
  ) +
  theme_bw(base_size = 13) +
  theme(legend.position = "bottom")


## ── A7. Coefficient comparison plot ──────────────────────────
coef_names <- c("Intercept", "X1", "X2", "X3", "X4", "X5")

mle_est <- coef(fit_mle5)
mle_se  <- coef(summary(fit_mle5))[, "Std. Error"]
cap_val <- 25   # display cap for MLE estimates
cap_se  <- 10   # display cap for SEs in plot

df_coef <- rbind(
  data.frame(
    param    = coef_names,
    estimate = pmax(pmin(mle_est, cap_val), -cap_val),
    se       = pmin(mle_se, cap_se),
    method   = "MLE (capped at +/-25)",
    capped   = abs(mle_est) > cap_val | mle_se > cap_se
  ),
  data.frame(
    param    = coef_names,
    estimate = coef(fit_firth5),
    se       = coef(summary(fit_firth5))[, "Std. Error"],
    method   = "Firth",
    capped   = FALSE
  ),
  data.frame(
    param    = coef_names,
    estimate = coef(fit_bayes5),
    se       = coef(summary(fit_bayes5))[, "Std. Error"],
    method   = "Bayes (Cauchy)",
    capped   = FALSE
  )
)
df_coef$param  <- factor(df_coef$param,  levels = coef_names)
df_coef$method <- factor(df_coef$method,
                          levels = c("MLE (capped at +/-25)",
                                     "Firth", "Bayes (Cauchy)"))

p_coef <- ggplot(df_coef,
                 aes(x = param, y = estimate,
                     colour = method, shape = capped)) +
  geom_hline(yintercept = 0, linetype = "dotted", colour = "grey50") +
  geom_pointrange(
    aes(ymin = estimate - se, ymax = estimate + se),
    position = position_dodge(width = 0.55),
    size = 0.5, linewidth = 0.8
  ) +
  scale_colour_manual(
    values = c("MLE (capped at +/-25)" = "#d7191c",
               "Firth"                 = "#1a9641",
               "Bayes (Cauchy)"        = "#2166ac")
  ) +
  scale_shape_manual(values = c("FALSE" = 16, "TRUE" = 4),
                     labels = c("FALSE" = "Exact", "TRUE" = "Capped"),
                     name   = "MLE value") +
  labs(
    title    = "Coefficient estimates +/- 1 SE: MLE vs Firth vs Bayes",
    subtitle = "MLE values are capped at +/-25; Firth and Bayes are finite throughout",
    x        = "Predictor",
    y        = "Estimate",
    colour   = "Method"
  ) +
  theme_bw(base_size = 13) +
  theme(legend.position = "bottom",
        legend.box       = "vertical")


## ============================================================
## ── PART B ──────────────────────────────────────────────────
## Hidden (multivariate) complete separation.
## No single predictor separates the classes; only the linear
## combination X1 + X2 > 0 does.
## Marginal ranges look benign; glm() still blows up.
## ============================================================

set.seed(7)
n2  <- 60
X1b <- rnorm(n2)
X2b <- rnorm(n2)
## True separating boundary: X1 + X2 = 0
Yb  <- as.integer(X1b + X2b > 0)

datB <- data.frame(Y = Yb, X1 = X1b, X2 = X2b)

## Marginal gaps are both negative -- no single-variable separation
gap_X1b <- min(X1b[Yb == 1]) - max(X1b[Yb == 0])   # approx -1.67
gap_X2b <- min(X2b[Yb == 1]) - max(X2b[Yb == 0])   # approx -2.23


## ── B2. Standard MLE ─────────────────────────────────────────
fit_mleB <- suppressWarnings(
  glm(Y ~ X1 + X2, family = binomial, data = datB)
)
## Both slope estimates are enormous and nearly equal, correctly
## reflecting that the separating direction is w ~ (1, 1).
flagB <- any(abs(coef(fit_mleB)) > 20 &
             coef(summary(fit_mleB))[, "Std. Error"] > 100)
## flagB is TRUE


## ── B3. Scatterplot revealing the hidden boundary ─────────────
p_scatter <- ggplot(datB, aes(x = X1, y = X2,
                               colour = factor(Y), shape = factor(Y))) +
  geom_point(size = 2.5, alpha = 0.85) +
  geom_abline(intercept = 0, slope = -1,
              linetype = "dashed", colour = "black", linewidth = 1) +
  scale_colour_manual(values = c("0" = "#d7191c", "1" = "#2166ac"),
                      labels = c("0" = "Y = 0", "1" = "Y = 1")) +
  scale_shape_manual(values = c("0" = 1,  "1" = 16),
                     labels = c("0" = "Y = 0", "1" = "Y = 1")) +
  labs(
    title    = "Hidden complete separation: no single predictor separates",
    subtitle = "Dashed line is the separating hyperplane X1 + X2 = 0",
    x        = expression(X[1]),
    y        = expression(X[2]),
    colour   = NULL, shape = NULL
  ) +
  theme_bw(base_size = 13) +
  theme(legend.position = "bottom")


## ── B4. Firth & Bayes corrections ────────────────────────────
fit_firthB <- suppressWarnings(glm(
  Y ~ X1 + X2,
  family = binomial,
  data   = datB,
  method = brglm2::brglmFit
))

fit_bayesB <- arm::bayesglm(
  Y ~ X1 + X2,
  family      = binomial,
  data        = datB,
  prior.scale = 2.5,
  prior.df    = 1
)
## Both corrected estimators find nearly equal coefficients for X1 and X2,
## correctly recovering the separating direction (1, 1).
## Bayes shrinks more aggressively than Firth (~10 vs ~15).


## ── B5. Decision boundary comparison plot ─────────────────────
## For logit = b0 + b1*x1 + b2*x2 = 0, the boundary is
## x2 = -(b0 + b1*x1) / b2.
## The ratio is numerically stable even when individual coefficients are not.

boundary_df <- function(fit, label, x1range = range(datB$X1)) {
  b  <- coef(fit)
  x1 <- seq(x1range[1], x1range[2], length.out = 200)
  x2 <- -(b[1] + b[2] * x1) / b[3]
  data.frame(X1 = x1, X2 = x2, method = label)
}

b_mle  <- coef(fit_mleB)
x1seq  <- seq(range(datB$X1)[1], range(datB$X1)[2], length.out = 200)

lines_df <- rbind(
  data.frame(X1 = x1seq,
             X2 = -(b_mle[1] + b_mle[2] * x1seq) / b_mle[3],
             method = "MLE"),
  boundary_df(fit_firthB, "Firth"),
  boundary_df(fit_bayesB, "Bayes (Cauchy)")
)
lines_df$method <- factor(lines_df$method,
                           levels = c("MLE", "Firth", "Bayes (Cauchy)"))

p_boundary <- ggplot(datB, aes(x = X1, y = X2)) +
  geom_point(aes(colour = factor(Y), shape = factor(Y)),
             size = 2.5, alpha = 0.75) +
  geom_line(data = lines_df,
            aes(x = X1, y = X2, linetype = method, colour = method),
            linewidth = 0.9) +
  geom_abline(intercept = 0, slope = -1,
              colour = "black", linewidth = 0.7, linetype = "dotted") +
  scale_colour_manual(
    values = c("0"              = "grey60",
               "1"              = "grey30",
               "MLE"            = "#d7191c",
               "Firth"          = "#1a9641",
               "Bayes (Cauchy)" = "#2166ac")
  ) +
  scale_shape_manual(values = c("0" = 1, "1" = 16)) +
  scale_linetype_manual(values = c("MLE"            = "solid",
                                   "Firth"          = "dashed",
                                   "Bayes (Cauchy)" = "dotdash")) +
  labs(
    title    = "Fitted decision boundaries: hidden multivariate separation",
    subtitle = "Dotted line is the true separating hyperplane X1 + X2 = 0",
    x        = expression(X[1]),
    y        = expression(X[2]),
    colour   = NULL, shape = NULL, linetype = NULL
  ) +
  guides(shape = "none") +
  coord_cartesian(ylim = c(-4, 4)) +
  theme_bw(base_size = 13) +
  theme(legend.position = "bottom")

library(gridExtra)

print(p_dens); print(p_coef); print(p_scatter); print(p_boundary)


