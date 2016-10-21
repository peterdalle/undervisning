# Simulering av power för olika sampelstorlekar, medelvärden och varians.
# Tar runt 20 minuter att köra beroende på datorhastighet.
# Byggd vidare från Rasmus Bååth:s svar på http://stats.stackexchange.com/questions/73045/simulating-p-values-as-a-function-of-sample-size
# Peter M. Dahlgren
# 2016-10-21

plot.power <- function(n, m1=1, sd1=0.1, m2=1.1, sd2=0.22, title="") {
  simulations <- 1000
  nrange <- 2:n
  power <- NULL
  
  for(n in nrange) {
    pvals <- replicate(simulations, { t.test(rnorm(n, m1, sd1), y = rnorm(n, m2, sd2))$p.value })
    power <- rbind(power, mean(pvals < 0.05) )
  }
  plot(nrange, power, type="l", ylim=c(0, 1), xlab="Sampelstorlek", ylab="Power", main=paste("Power vid olika sampelstorlekar: ", title," \n(t-test: M1=", m1, " SD1=", sd1, " och M2=", m2, " SD2=", sd2, ")", sep=""))
}

# Skapa 2x2 plottar.
par(mfrow=c(2,2))

# Plotta power för lite olika sampelstorlekar, medelvärden och varians.
system.time(plot.power( n=150, m1=1, sd1=0.2, m2=1.1, sd2=0.2, title="Samma varians, liten"))
system.time(plot.power(n=2000, m1=1, sd1=0.8, m2=1.1, sd2=0.8, title="Samma varians, stor"))
system.time(plot.power( n=100, m1=1, sd1=0.1, m2=1.1, sd2=0.2, title="Olika varians, liten"))
system.time(plot.power(n=1500, m1=1, sd1=0.1, m2=1.1, sd2=0.8, title="Olika varians, stor"))
