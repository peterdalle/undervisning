# Simulering av P-värden vid olika sampelstorlekar och effektstorlekar.
# Peter M. Dahlgren
# 2016-10-21

set.seed(1234)  # För reproducerbart resultat.


# ************************************************************************************
# Stegvis ökande sampelstorlek (vid en given medelvärdesskillnad).
# ************************************************************************************

# Simulera stegvist ökande sampelstorlek vid en given medelvärdesskillnad.
p.sample <- function(n=100, meandifference, randomvariance=0) {
  plist <- list()
  nlist <- list()
  for(i in 1:n)
  {
    x <- rnorm(i + 2, 0, 1 + randomvariance)                   # Lägg (eventuellt) på slumpmässig varians.
    y <- rnorm(i + 2, 0 + meandifference, 1 + randomvariance)  # Lägg (eventuellt) på slumpmässig varians.
    
    t <- t.test(x, y, paried=TRUE)            # T-test.
    plist[i] <- t$p.value                     # P-värde.
    nlist[i] <- i + 2                         # Sampelstorlek.
  }
  df <- data.frame(n=unlist(nlist), p=unlist(plist))
  return(df)
}

# Plotta ökande sampelstorlek.
plot.sample <- function(df, meandifference) {
  sig <- round((prop.table(table(df$p < 0.05)) * 100)[2], 1)  # % under alpha 0.05.
  plot(df$n, df$p, ylab="P-värde", xlab="Sampelstorlek", main=paste("P-värde vid olika sampelstorlekar när\nmedelvärdesskilnaden är ", meandifference, " (SD=1, t-test, p<0.05: ", sig, "%)", sep=""))
  abline(a=0.05, b=0, col="red")
}

# Gör 2x2 plottar.
par(mfrow=c(2,2))

# Plotta p-värde för varje medelvärdesskillnad och sampelstorlek.
meandifference <- 1.0
df <- p.sample(n=30, meandifference)
plot.sample(df, meandifference)

meandifference <- 0.5
df <- p.sample(n=200, meandifference)
plot.sample(df, meandifference)

meandifference <- 0.1
df <- p.sample(n=7000, meandifference)
plot.sample(df, meandifference)

meandifference <- 0.05
df <- p.sample(n=50000, meandifference)
plot.sample(df, meandifference)


# ************************************************************************************
# Stegvis ökande effektstorlek (vid en given sampelstorlek).
# ************************************************************************************

# Simulera stegvist ökande effektstorlek vid en given sampelstorlek.
p.effectsize <- function(n=100, fromsize=-0.5, tosize=0.5, incrementby=0.01, randomvariance=0) {
  plist <- list()
  dlist <- list()
  i <- 0
  for(m in seq(fromsize, tosize, by=incrementby))
  {
    i <- i + 1
    x <- rnorm(n, 0, 1 + randomvariance)                        # Lägg (eventuellt) på slumpmässig varians.
    y <- rnorm(n, 0 + m, 1 + randomvariance)                    # Lägg (eventuellt) på slumpmässig varians.
    
    t <- t.test(x, y, paried=TRUE)                              # T-test.
    plist[i] <- t$p.value                                       # P-värde.
    cohensd <- (2 * t$statistic) / sqrt(round(t$parameter, 0))  # Cohens d.
    
    names(cohensd) <- NULL
    dlist[i] <- cohensd
  }
  df <- data.frame(d=unlist(dlist), p=unlist(plist))
  return(df)
}

# Plott ökande effektstorlek.
plot.effectsize <- function(df, n, fromsize, tosize, increment)
{
  sig <- round((prop.table(table(df$p < 0.05)) * 100)[2], 1)  # % under alpha 0.05.
  names(sig) <- NULL
  plot(df$d, df$p, ylab="P-värde", xlab="Cohens d", main=paste("P-värde vid olika effektstorlekar när n=", n,": från medelvärdesskillnad\n", fromsize, " till ", tosize, " ökande stegvis med ", increment, " (t-test, lika varians, p<0,05: ", sig, "%)", sep=""))
  abline(a=0.05, b=0, col="red")
}

# Inställningar för att generera effektstorlekar:
fromsize <- -0.5       # Från medelvärde.
tosize <- 0.5          # Till medelvärde.
increment <- 0.001     # Öka medelvärdet med 0.001 för varje test.

# Gör 2x2 plottar.
par(mfrow=c(2,2))

# Plotta Cohdens d och p-värde vid olika sampelstorlekar.
n <- 10
df <- p.effectsize(n, fromsize, tosize, increment)
plot.effectsize(df, n, fromsize, tosize, increment)

n <- 50
df <- p.effectsize(n, fromsize, tosize, increment)
plot.effectsize(df, n, fromsize, tosize, increment)

n <- 1000
df <- p.effectsize(n, fromsize, tosize, increment)
plot.effectsize(df, n, fromsize, tosize, increment)

n <- 10000
df <- p.effectsize(n, fromsize, tosize, increment)
plot.effectsize(df, n, fromsize, tosize, increment)
