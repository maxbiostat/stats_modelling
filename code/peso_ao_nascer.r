library(tidyverse)
library(rstanarm)
library(ggplot2)

######## Funcoes auxiliares

b_predict <- function(obj, newdata,
                      interval = c("confidence", "prediction"),
                      level = 0.95){
  if(interval == "confidence"){
    raw <- posterior_linpred(object = obj, newdata = newdata)
    out <- data.frame(fit = colMeans(raw),
                      lwr = apply(raw, 2, quantile, probs = (1 - level)/2 ),
                      upr = apply(raw, 2, quantile, probs = (1 + level)/2 ))
  }else{
    if(interval== "prediction"){
      raw <- posterior_predict(object = obj, newdata = newdata)
      out <- data.frame(fit = colMeans(raw),
                        lwr = apply(raw, 2, quantile, probs = (1 - level)/2 ),
                        upr = apply(raw, 2, quantile, probs = (1 + level)/2 ))
    }else{
      stop("'interval' must be one of 'confidence' or 'prediction'")
    }
  }
  return(out)
}

################################

ncores <- 4
options(mc.cores = ncores)

### Carregando os dados

peso <- read.csv("../data/birthweight.csv")

head(peso)

##### Modelagem

#### Ajuste frequentista

modelo.simples <-  lm(weight ~ age, data = peso)
modelo.completo <- lm(weight ~ age + sex, data = peso)
modelo.interacao <- lm(weight ~ age * sex, data = peso)

summary(modelo.simples)
summary(modelo.completo)
summary(modelo.interacao)

AIC(modelo.simples)
AIC(modelo.completo)
AIC(modelo.interacao)

#### Abordagem bayesiana

modelo.simples.b <-  stan_glm(weight ~ age, data = peso)
modelo.completo.b <- stan_glm(weight ~ age + sex, data = peso)
modelo.interacao.b <- stan_glm(weight ~ age * sex, data = peso)

summary(modelo.simples.b)
summary(modelo.completo.b)
summary(modelo.interacao.b)

######## Predições
nivel <- .95
extra <- data.frame(
  individual = c("MA", "AL"),
  sex = c("female", "female"),
  age = c(39, 34),
  observed = c(2915, 2226)
)

#### "Prevendo"  o preditor linear

p.simples.reta.f <- 
  cbind(extra, predict(modelo.simples, newdata = extra,
        interval = "confidence", level = nivel))
p.simples.reta.f$modelo <- "age"
p.simples.reta.f$alvo <- "reta"
p.simples.reta.f$metodo <- "freq"

p.completo.reta.f <- 
  cbind(extra, predict(modelo.completo, newdata = extra,
                       interval = "confidence", level = nivel))
p.completo.reta.f$modelo <- "age + sex"
p.completo.reta.f$alvo <- "reta"
p.completo.reta.f$metodo <- "freq"

p.inter.reta.f <- 
  cbind(extra, predict(modelo.interacao, newdata = extra,
                       interval = "confidence", level = nivel))
p.inter.reta.f$modelo <- "age * sex"
p.inter.reta.f$alvo <- "reta"
p.inter.reta.f$metodo <- "freq"

### Prevendo Y

p.simples.y.f <- 
  cbind(extra, predict(modelo.simples, newdata = extra,
                       interval = "prediction", level = nivel))
p.simples.y.f$modelo <- "age"
p.simples.y.f$alvo <- "Y"
p.simples.y.f$metodo <- "freq"

p.completo.y.f <- 
  cbind(extra, predict(modelo.completo, newdata = extra,
                       interval = "prediction", level = nivel))
p.completo.y.f$modelo <- "age + sex"
p.completo.y.f$alvo <- "Y"
p.completo.y.f$metodo <- "freq"

p.inter.y.f <- 
  cbind(extra, predict(modelo.interacao, newdata = extra,
                       interval = "prediction", level = nivel))
p.inter.y.f$modelo <- "age * sex"
p.inter.y.f$alvo <- "Y"
p.inter.y.f$metodo <- "freq"

#### "Prevendo"  o preditor linear

p.simples.reta.b <- 
  cbind(extra, b_predict(modelo.simples.b, newdata = extra,
                       interval = "confidence", level = nivel))
p.simples.reta.b$modelo <- "age"
p.simples.reta.b$alvo <- "reta"
p.simples.reta.b$metodo <- "bayes"

p.completo.reta.b <- 
  cbind(extra, b_predict(modelo.completo.b, newdata = extra,
                       interval = "confidence", level = nivel))
p.completo.reta.b$modelo <- "age + sex"
p.completo.reta.b$alvo <- "reta"
p.completo.reta.b$metodo <- "bayes"

p.inter.reta.b <- 
  cbind(extra, b_predict(modelo.interacao.b, newdata = extra,
                       interval = "confidence", level = nivel))
p.inter.reta.b$modelo <- "age * sex"
p.inter.reta.b$alvo <- "reta"
p.inter.reta.b$metodo <- "bayes"

### Prevendo Y

p.simples.y.b <- 
  cbind(extra, b_predict(modelo.simples.b, newdata = extra,
                       interval = "prediction", level = nivel))
p.simples.y.b$modelo <- "age"
p.simples.y.b$alvo <- "Y"
p.simples.y.b$metodo <- "bayes"

p.completo.y.b <- 
  cbind(extra, b_predict(modelo.completo.b, newdata = extra,
                       interval = "prediction", level = nivel))
p.completo.y.b$modelo <- "age + sex"
p.completo.y.b$alvo <- "Y"
p.completo.y.b$metodo <- "bayes"

p.inter.y.b <- 
  cbind(extra, b_predict(modelo.interacao.b, newdata = extra,
                       interval = "prediction", level = nivel))
p.inter.y.b$modelo <- "age * sex"
p.inter.y.b$alvo <- "Y"
p.inter.y.b$metodo <- "bayes"

### 
pred.list <- list(
  p.simples.reta.f,
  p.simples.reta.b,
  p.completo.reta.f,
  p.completo.reta.b,
  p.inter.reta.f,
  p.inter.reta.b,
  p.simples.y.f,
  p.simples.y.b,
  p.completo.y.f,
  p.completo.y.b,
  p.inter.y.f,
  p.inter.y.b
)
all.preds <- do.call(rbind, pred.list)

head(all.preds)

ggplot(data = all.preds,
       aes(x = modelo, y = fit,
           colour = metodo, fill = metodo,
           ymin = lwr, ymax = upr)) +
  geom_pointrange(alpha = 0.6, size = 1.2, linewidth = 1.5) +
  geom_hline(data = extra, aes(yintercept = observed),
             linetype = "dashed") +
  facet_grid(individual ~ alvo) +
  theme_bw(base_size = 16)