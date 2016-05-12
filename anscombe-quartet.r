# Visualisering av:
# Anscombe, Francis J. (1973) Graphs in statistical analysis. American Statistician, 27, 17–21.
# Från https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/anscombe.html

require(stats); require(graphics)
summary(anscombe)

##-- now some "magic" to do the 4 regressions in a loop:
ff <- y ~ x
mods <- setNames(as.list(1:4), paste0("lm", 1:4))
for(i in 1:4) {
  ff[2:3] <- lapply(paste0(c("y","x"), i), as.name)
  ## or   ff[[2]] <- as.name(paste0("y", i))
  ##      ff[[3]] <- as.name(paste0("x", i))
  mods[[i]] <- lmi <- lm(ff, data = anscombe)
  print(anova(lmi))
}

## See how close they are (numerically!)
sapply(mods, coef)
lapply(mods, function(fm) coef(summary(fm)))

## Now, do what you should have done in the first place: PLOTS
op <- par(mfrow = c(2, 2), mar = 0.1+c(4,4,1,1), oma =  c(0, 0, 2, 0))
for(i in 1:4) {
  ff[2:3] <- lapply(paste0(c("y","x"), i), as.name)
  plot(ff, data = anscombe, col = "red", pch = 21, bg = "red", cex = 1.5,
       xlim = c(3, 19), ylim = c(3, 13))
  abline(mods[[i]], col = "black")
}
mtext("Anscombes kvartett: Fyra typer av data - samma statistik", outer = TRUE, cex = 1.5)
par(op)
