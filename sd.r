library(tidyverse)
library(magick)
set.seed(123456)

n <- 1000 # How big sample do we want.

df <- data.frame(i=1:n, x = rnorm(n, 100, 5))
df <- data.frame(i=df$i, x=df$x, y=df$x + rnorm(n, 0, 20))
df$error <- df$y - mean(df$y) # Center y to 0.

# Function to plot lines for standard deviations on scatter plot.
outlier_plot <- function(df, sd, title=NULL) {
  df$outlier <- ifelse(df$error < -sd(df$error)*sd | df$error > sd(df$error)*sd, 1, 0)
  gg <- df %>% 
    ggplot(aes(i, error, color=factor(outlier))) + 
    geom_point() + 
    scale_y_continuous(breaks=seq(-100, 100, 10)) +
    scale_color_manual(values=c("black", "gray")) +
    geom_hline(yintercept = 0, linetype=2, alpha=0.6) +
    geom_hline(yintercept = 0 + df.sd*sd, linetype=1, alpha=0.6) +
    geom_hline(yintercept = 0 - df.sd*sd, linetype=1, alpha=0.7) +
    geom_text(y = 0 + df.sd*sd + 4, x = 1000, label=paste0("+", sd, " SD"), col="black", size=5) +
    geom_text(y = 0 - df.sd*sd - 4, x = 1000, label=paste0("-", sd, " SD"), col="black", size=5) +
    theme_minimal() +
    theme(legend.position="none") +
    labs(title=title, x=NULL, y=NULL) 
  return(gg)
}

# Plot only the data.
gg1 <- df %>% 
  ggplot(aes(i, error)) + 
  geom_point() + 
  scale_y_continuous(breaks=seq(-100, 100, 10)) +
  geom_hline(yintercept = 0, linetype=2, alpha=0.6) +
  theme_minimal() +
  labs(title=NULL, x=NULL, y=NULL) 

# Plot the data with different standard deviations.
gg2 <- outlier_plot(df, sd=1)
gg3 <- outlier_plot(df, sd=2)
gg4 <- outlier_plot(df, sd=3)

# -----------------------------------------
# Save to gif animation
# -----------------------------------------

# Open image device, plot, close.
img1 <- image_graph(700, 500, res=96)
gg1
dev.off()
img1 <- image_background(image_trim(img1), 'white')

img2 <- image_graph(700, 500, res=96)
gg2
dev.off()
img2 <- image_background(image_trim(img2), 'white')

img3 <- image_graph(700, 500, res=96)
gg3
dev.off()
img3 <- image_background(image_trim(img3), 'white')

img4 <- image_graph(700, 500, res=96)
gg4
dev.off()
img4 <- image_background(image_trim(img4), 'white')

# Combine plots.
frames <- image_morph(c(img1, img2, img3, img4), frames = 0)
animation <- image_animate(frames, fps = 0.50)
print(animation)

# Save gif.
image_write(animation, path="sd.gif", format="gif")
