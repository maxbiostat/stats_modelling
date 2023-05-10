logistic_curve <- function(t, a,  K, L){
  L/2 + (K-L/2)/(1 + exp(-a*t))
}
########
set.seed(666)
n <- 100
fireQt <- runif(n, min = 0, max = 1)
Age <- runif(n = n, min = 324, max = 5600)
WingSpan <- rnorm(n = n,
                 mean = logistic_curve(t = Age,
                                  a = -.00075,
                                  L = 2E2,
                                  K = 1.5E3),
                 sd = 25)

Colour <- cut(fireQt, breaks = c(0, .5, .7, 1), 
              labels = c("Azul", "Dourado", "Verde"))

b1 <- .002
b2 <- -.0000005
alpha <- .2
bF <- 2

true.mu <- exp(alpha + bF * fireQt + b1*Age + b2*Age^2)

phi <- 2
y <- rnbinom(n = n,
             size = phi,
             mu = true.mu)



dragon.df <- tibble::tibble(
  age = Age,
  colour = Colour,
  wing_span = WingSpan,
  fire_quotient = fireQt,
  no_eggs = y
)

write.csv(dragon.df, "../data/mystery_dragon.csv", row.names = FALSE)

### Danny's lizards
nD <- 29
fireQtD <- runif(nD, min = 0, max = 1)
AgeD <- runif(n = nD, min = 324, max = 5600)
WingSpanD <- rnorm(n = nD,
                  mean = logistic_curve(t = AgeD,
                                        a = -.00075,
                                        L = 2E2,
                                        K = 1.5E3),
                  sd = 25)

ColourD <- cut(fireQtD, breaks = c(0, .5, .7, 1), 
              labels = c("Azul", "Dourado", "Verde"))

true.muD <- exp(alpha + bF * fireQtD + b1*AgeD + b2*AgeD^2)

yD <- rnbinom(n = nD,
             size = phi,
             mu = true.muD)

danny.df <- tibble::tibble(
  age = AgeD,
  colour = ColourD,
  wing_span = WingSpanD,
  fire_quotient = fireQtD,
  no_eggs = yD
)

write.csv(danny.df, "../data/Dannys_dragons.csv", row.names = FALSE)
