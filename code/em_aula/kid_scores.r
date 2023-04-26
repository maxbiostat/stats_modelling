library(tidyverse)
kidIQ <- read_csv("kidiq.csv")
head(kidIQ)
kidIQ <- kidIQ %>%
  mutate(mom_hs = as.factor(mom_hs))
kidIQ <- kidIQ %>%
  mutate(mom_work = as.factor(mom_work))

boxplot(kid_score ~ mom_hs,
        data = kidIQ)

t.test(kid_score~mom_hs, data = kidIQ,
       alternative = "less")

ggplot(data = kidIQ, 
       aes(x = mom_iq, y = kid_score,
           colour = mom_hs)) +
  geom_point() +
  geom_smooth(method = "lm") + 
  theme_bw(base_size = 16)

####
mod1 <- lm(kid_score~as.numeric(mom_hs), kidIQ)
summary(mod1)

#### 
mod2 <- lm(kid_score~mom_iq, kidIQ)
summary(mod2)

HS0 <- subset(kidIQ, mom_hs == "0")
HS1 <- subset(kidIQ, mom_hs == "1")

mod2.a <- lm(kid_score~mom_iq, HS0)
summary(mod2.a)
mod2.b <- lm(kid_score~mom_iq, HS1)
summary(mod2.b)

####
mod3 <- lm(kid_score ~ mom_hs + mom_iq, kidIQ)
summary(mod3)

hist(kidIQ$kid_score)

mod4 <- lm(kid_score ~ mom_hs + mom_iq + mom_hs:mom_iq,
           kidIQ)
summary(mod4)

newIQs <- seq(70, 140, by = 10)
new.data <- tibble(mom_iq = c(newIQs, newIQs),
                   mom_hs = rep(c("0", "1"),
                                each = length(newIQs)))
pred3 <- predict(mod3, newdata = new.data)
pred4 <- predict(mod4, newdata = new.data)

allpreds <- tibble(new.data,
                   pred_m3 = pred3,
                   pred_m4 = pred4)

ggplot(data = allpreds, 
       aes(x = mom_iq, y = pred_m3,
           colour = mom_hs)) +
  geom_point() +
  geom_smooth(method = "lm") + 
  theme_bw(base_size = 16)

ggplot(data = allpreds, 
       aes(x = mom_iq, y = pred_m4,
           colour = mom_hs)) +
  geom_point() +
  geom_smooth(method = "lm") + 
  theme_bw(base_size = 16)


#### DUF
duf <- function(i){
  train <-  kidIQ[-i, ]
  test <- kidIQ[i, ]
  mod3.t <- lm(kid_score ~ mom_hs + mom_iq,
               data = train)
  mod4.t <- lm(kid_score ~ mom_hs + mom_iq + mom_hs:mom_iq,
               data = train)
  
  s3 <- summary(mod3.t)
  s4 <- summary(mod4.t)
  pred3 <- predict(mod3.t, newdata = test)
  pred4 <- predict(mod4.t, newdata = test)
  
  out <- tibble(
    who  = i,
    c3 = coef(mod3.t)[3],
    c4 = coef(mod4.t)[3],
    p3 = pred3,
    p4 = pred4,
    rsq3 = s3$r.squared,
    rsq4 = s4$r.squared,
    y = test$kid_score  
  )
}

resultados <- do.call(rbind,
                      lapply(1:nrow(kidIQ), duf) )

plot(c3~who, resultados)
Q3 <- quantile(resultados$c3, prob = c(.025, .975))
abline(h = Q3, lwd = 3, lty = 2)

plot(c4~who, resultados)
Q4 <- quantile(resultados$c4, prob = c(.025, .975))
abline(h = Q4, lwd = 3, lty = 2)

plot(res3~who, resultados)
R3 <- quantile(resultados$res3, prob = c(.025, .975))
abline(h = R3, lwd = 3, lty = 2)

plot(mod3)

