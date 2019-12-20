library(copula)

dim <- 2
n <- 32
ncop <- 10000

myCop.norm <- ellipCopula(family = "normal", dim = dim, dispstr = "ex", param = 0.4)
cop1 <- rCopula(n, copula = myCop.norm)
plot(cop1)


coparray <- array(
  data = sapply(seq.int(ncop),
                function(icop){
                  cop <- rCopula(n, copula = myCop.norm)
                  cop[do.call(order, as.data.frame(cop)), ]
                }
  ),
  dim = c(n, dim, ncop)
)
coparray <- aperm(coparray, c(3, 1, 2))

library(reticulate)
np <- import("numpy")
np$save("coparray.npy", coparray)
