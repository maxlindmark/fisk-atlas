library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

sf::sf_use_s2(FALSE)

# Specify map ranges
#ymin = 52; ymax = 68; xmin = -10; xmax = 30

map_data_l <- rnaturalearth::ne_countries(
  scale = "large",
  returnclass = "sf")

plot_map_l <-
  ggplot(map_data_l) +
  labs(x = "Longitud", y = "Latitud") +
  geom_sf(size = 0.3, color = "gray70") +
  theme(axis.text.x = element_text(size = 6),
        axis.text.y = element_text(size = 6),
        axis.title.x = element_text(size = 8),
        axis.title.y = element_text(size = 8))

# Large scale map and/or faceted map (too high res makes it blurry)
map_data_medium <- rnaturalearth::ne_countries(
  scale = "medium",
  returnclass = "sf")

plot_map_m <- 
  ggplot(map_data_medium) + 
  labs(x = "Longitud", y = "Latitud") +
  geom_sf(size = 0.3, color = "gray70") + 
  theme(axis.text.x = element_text(angle = 90)) +
  theme(axis.text.x = element_text(size = 6),
        axis.text.y = element_text(size = 6),
        axis.title.x = element_text(size = 8),
        axis.title.y = element_text(size = 8),
        strip.text = element_text(size = 6))
