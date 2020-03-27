#' I'm trying to use `geom_curve()` and `scale_alpha()` together, but the resulting legend guide is not cool =D.

#' In short, I want to plot a legend for `scale_alpha()` similar to the legend of `scale_color_gradient()`.

#' Here is my reprex:

library(ggplot2)
library(dplyr)

theme_set(theme_void())

data_joined <- read.csv("https://gist.githubusercontent.com/kguidonimartins/6f49bf6ae13410799fb2eede56345fa5/raw/43486c44aee2aedf951e661ac576e46a5576a0da/country_data.csv", header = TRUE)

base_map <- borders(database = "world")

#' So, my first try was something like this. Not ideal due to the overlap. But the legend guide is ok!

data_joined %>%  
  ggplot() +
  base_map +
  geom_curve(
    data = data_joined,
    aes(
      x = origin_x,
      y = origin_y,
      xend = destination_x,
      yend = destination_y,
      color = flow
    ),
    arrow = arrow(length = unit(0.2, "cm")),
    size = 1.5
  )
  
#' So, I tried to simulate a `scale_alpha()` to maintain the legend guide.
  
data_joined %>%  
  ggplot() +
  base_map +
  geom_curve(
    data = data_joined,
    aes(
      x = origin_x,
      y = origin_y,
      xend = destination_x,
      yend = destination_y,
      color = flow
    ),
    arrow = arrow(length = unit(0.2, "cm")),
    size = 1.5,
    alpha = 0.5
  ) +
  scale_color_gradient(low = "grey95", high = "blue", n.breaks=10)

#' Not good yet, maybe using a fixed color and applying alpha (in `aes()`) as a gradient:

data_joined %>%  
  ggplot() +
  base_map +
  geom_curve(
    data = data_joined,
    aes(
      x = origin_x,
      y = origin_y,
      xend = destination_x,
      yend = destination_y,
      alpha = flow
    ),
    arrow = arrow(length = unit(0.2, "cm")),
    size = 1,
    color = "blue"
  ) +
  scale_alpha(n.breaks = 10) 

#' I liked that solution but I was unable to change the legend guide. I want to maintain the legend guide similar when using `scale_color_gradient()`. I'm trying this from scratch changing the legend key, but the `guides()` don't change the shape of the arrows in the legend.

data_joined %>%  
  ggplot() +
  base_map +
  geom_curve(
    data = data_joined,
    aes(
      x = origin_x,
      y = origin_y,
      xend = destination_x,
      yend = destination_y,
      alpha = flow
    ),
    arrow = arrow(length = unit(0.2, "cm")),
    size = 1,
    color = "blue"
  ) +
  scale_alpha(n.breaks = 10) +
  guides(alpha = guide_legend(reverse = TRUE, override.aes = list(shape = 22)))

#' Can someone help me with this?
