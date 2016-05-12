# Räkna ut felmarginalen vid given proportion (p), urvalsstorlek (n), konfidensintervall (uttryckt i z-score) för en viss population (antar Sveriges population om inget annat anges).
marginoferror <- function (p, n, z=1.96, population=9600000) {
    if(p >= 1) {
      stop("p måste vara proportion under 1, exempelvis 0.60 för 60 %.")
    }
    return (z * sqrt((p * (1 - p)) / n) * 100) * (1 - (n / population)))) # Korrektionsfaktorn kan egentligen skippas eftersom den ger marginell effekt på felmarginalen.
}

# Plotta felmarginal vid olika proportioner.
plotta <- function (proportion, z=1.96) {
  # Bygg vektor med N och felmarginal.
  l <- c(n=0, felmarginal=marginoferror(proportion, 0))
  for (n in 1:2000) {
   l <- rbind(l, c(n=n, felmarginal=marginoferror(proportion, n, z=z)))
  }
  
  # Plotta.
  plot(l, type="n",cex.main=1.35, main=paste("Felmarginal vid olika urvalsstorlekar\nnär ett alternativ får ", proportion * 100, "% av rösterna", sep=""),
      xlab="Urvalsstorlek (N)", cex.lab=1.35, ylab="Felmarginal (%)")
  grid()
  points(l, col="red")
  axis(side=1, at=seq(0, 2000, by=500))
  axis(side=2, at=seq(0, 100, by=10))
}

# Plotta några exempel.
plotta(0.05)          #  5 % med 95 % CI.
plotta(0.25)          # 25 % med 95 % CI.
plotta(0.75)          # 75 % med 95 % CI.
plotta(0.50, z=2.576) # 50 % med 99 % CI.

# Lathund för z:
# 50 % CI = 0.674 z-score
# 80 % CI = 1.282 z-score
# 90 % CI = 1.645 z-score
# 95 % CI = 1.960 z-score
# 98 % CI = 2.326 z-score
# 99 % CI = 2.576 z-score
