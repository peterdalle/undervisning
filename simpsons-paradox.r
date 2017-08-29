# Kod modifierad från Rafael Irizarry
# https://simplystatistics.org/2017/08/08/code-for-my-educational-gifs/
library(dplyr)
library(magick)
library(ggplot2)
theme_set(theme_minimal())

# Simulera data.
N <- 100
Sigma <- matrix(c(1, 0.75, 0.75, 1), 2, 2) * 1.5
means <- list(c(11, 3), c(9, 5), c(7, 7), c(5, 9), c(3, 11))
dat <- lapply(means, function(mu)  MASS::mvrnorm(N, mu, Sigma))
dat <- tbl_df(Reduce(rbind, dat)) %>% 
  mutate(Z = as.character(rep(seq_along(means), each = N)))
names(dat) <- c("X", "Y", "Z")

# Korrelationer.
means <- tbl_df(Reduce(rbind, means)) %>%
  setNames(c("x","y")) %>%
  mutate(z = as.character(seq_along(means)))

corrs <- dat %>%
  group_by(Z) %>%
  summarize(cor = cor(X, Y)) %>%
  .$cor

# ----- Plot 1: Pooled OLS -----

# Öppna image device.
img1 <- image_graph(700, 500, res=96)

# Plot 1.
dat %>%
  ggplot(aes(X,Y)) + geom_point(alpha = 1) +
  ggtitle(paste("Korrelation: ", round(cor(dat$X, dat$Y), 2))) +
  geom_smooth(method="lm", color="red", se = FALSE, alpha=.3)

# Stäng image device.
dev.off()

# Spara plot 1.
img1 <- image_background(image_trim(img1), 'white')

# ----- Plot 2: OLS per grupp -----

# Öppna image device.
img2 <- image_graph(700, 500, res=96)

# Plot 2.
dat %>%
  ggplot(aes(X, Y, color = Z)) + 
  geom_point(show.legend = FALSE, alpha = 1) +
  ggtitle(paste("Korrelation:",  paste(signif(corrs, 2), collapse=", "))) +
  #annotate("text", x = means$x, y = means$y, label = paste(means$z), cex = 5)  +
  geom_smooth(aes(group=Z), method="lm", color="red", se = FALSE)

# Stäng image device.
dev.off()

# Spara plot 2.
img2 <- image_background(image_trim(img2), 'white')

# ----- Plot 3. Tom, endast datapunkterna -----

# Öppna image device.
img_empty <- image_graph(700, 500, res=96)

# Plot 3.
dat %>%
  ggplot(aes(X, Y)) + 
  geom_point(show.legend = FALSE, alpha = 0.5) +
  ggtitle(paste("Korrelation: "))

# Stäng image device.
dev.off()

# Spara plot 3.
img_empty <- image_background(image_trim(img_empty), 'white')

# ----- Animera -----

# Sätt ihop plottar.
frames <- image_morph(c(img_empty, img1, img1, img_empty, img2, img2, img_empty), frames = 7)
animation <- image_animate(frames, fps = 10)
print(animation)

# Spara.
image_write(animation, path="simpsons-paradox.gif", format="gif")
