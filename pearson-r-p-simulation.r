# Simulation för att hitta signifikanta p-värden i helt slumpmässig data (runif på x och y) av stegvis ökande datastorlek.
# Peter M. Dahlgren
# 2016-05-19
library(ggplot2)
set.seed(1234)    # För reproducerbart resultat.
n <- 1500         # Storlek på sampel.

plist <- list()
rlist <- list()
ilist <- list()
siglist <- list()
for(i in 3:n) # Börja på 3 eftersom df är n-2 för korrelationens signifikanstest.
{
  x <- runif(i, 0, 100)         # Låt x innehålla slumpmässiga värden mellan 0-100.
  y <- runif(i, 0, 100)         # Dito.
  r <- cor(x, y)                # Korrelation mellan x och y. 
  p <- cor.test(x, y)$p.value   # P-värde för r.
  rlist[i] <- r
  plist[i] <- p
  siglist[i] <- (p < 0.05)
  ilist[i] <- i
}

# Skapa data.frame från simulationens resultat.
df <- data.frame(r=unlist(rlist), p=unlist(plist), i=unlist(ilist), sig=factor(unlist(siglist)))

#dev.off()

# Gör snygg ggplot.
ggplot(df, aes(i, r, color=sig)) +
          geom_point(size=3, alpha=.6) +
          scale_color_manual("", values=c("#1FAAD0", "#ff0000"), labels=c("Ej signifikant", "Signifikant på 0,05-nivån")) +
          theme(legend.position = "top") +
          #theme_bw() +
          ggtitle("Simulation av Pearsons r vid olika sampelstorlekar med helt slumpmässig x och y") +        
          ylab("Pearsons r") +
          xlab("Sampelstorlek")


# Gör ful baseplot.
# Plotta alla r.
plot(unlist(rlist), main="Simulation av Pearsons r vid olika sampelstorlekar", 
          ylab="Pearsons r", 
          xlab="Sampelstorlek")
abline(h=0, col="red")       # Dra röd linje rakt genom r=0.
#abline(h=0.05, col="blue")   # Blå linje vid +0.05...
#abline(h=-0.05, col="blue")  # ...samt -0.05

plot(unlist(plist))    # Plotta alla p.

# Hur stor andel signifikanta resultat fick vi på 0.05-nivån?
(sum((unlist(plist) < .05)) / NROW(plist)) * 100 # Bör vara runt 5%.

# 0.01-nivån?
(sum((unlist(plist) < .01)) / NROW(plist)) * 100 # Bör vara runt 1%.

# 0.001-nivån?
(sum((unlist(plist) < .001)) / NROW(plist)) * 100 # Bör vara runt 0,1%.
