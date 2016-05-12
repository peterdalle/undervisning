# Simulation för att hitta tärningens väntevärde efter att ha kastat tärningen 500 gånger.
library(ggplot2)

sim <- 500              # Antal simulationer.
set.seed(1234)          # Seed för slumpgeneratorn för reproducerbart resultat.
dicelist <- list(sim)
meandice <- list(sim)

# Simulera tärningskast.
for (i in 1:sim)
{
  dicelist[i] <- sample(1:6, 1)
  meandice[i] <- mean(unlist(dicelist))
}

# Gör om lista till data.frame.
df <- data.frame(meandice=matrix(unlist(meandice), nrow=sim, byrow=T), trial=1:sim)

# Kolla hur många av varje tärningssida (1-6) det finns efter simulationen.
table(unlist(dicelist))

# Vad är tärningens medelvärde och standardavvikelse efter simulationen?
mean(df$meandice)
sd(df$meandice)

# Plotta det ackumulerade väntevärdet efter varje tärningskast.
ggplot(df, aes(trial, meandice)) +
  geom_line() +
  geom_hline(yintercept=3.5, color="red") +
  scale_x_continuous(breaks=seq(0, sim, 50)) + 
  scale_y_continuous(breaks=seq(0, 6, 1), limits=c(0, 6)) + 
  theme_bw()
