library(tidyverse)
kidiq <- read_csv("../data/kidiq.csv")
head(kidiq)

kidiq <- kidiq %>% mutate(mom_iq_c = mom_iq - mean(mom_iq))

mod <- lm(kid_score ~ mom_iq*mom_hs, data = kidiq)
modc <- lm(kid_score ~ mom_iq_c*mom_hs, data = kidiq)

summary(mod)
summary(modc)
