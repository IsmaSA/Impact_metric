library(fmsb)
install.packages("ggplot2")
install.packages("ggiraphExtra")
library(ggplot2)
library(ggiraphExtra)

data <- data.frame(
  "Human Health Impact" = c(1, 6, 3, 7),
  "Environmental Impact" = c(1, 5, 7, 7),
  "Biodiversity Impact" = c(1, 4, 2, 7),
  "Economic Impact" = c(7, 2, 6, 7),
  "Societal Response" = c(1, 3, 5, 7),
  "Propagule Pressure" = c(1, 5, 1, 7),
  "Reversibility of Impact" = c(3, 4, 3, 7)
)

rownames(data) <- c("Species1", "Species2", "Species3", "Species4")
max_values <- rep(7, 7)
min_values <- rep(0, 7)

#plot all
all_species_chart <- rbind(max_values, min_values, data)
radarchart(
  all_species_chart, axistype = 1, title = "Radar Chart of All Species",
  pcol = c("blue", "red", "green", "purple"),
  pfcol = c(rgb(0.1, 0.1, 0.8, 0.3), rgb(0.8, 0.1, 0.1, 0.3), rgb(0.1, 0.8, 0.1, 0.3), rgb(0.5, 0.1, 0.5, 0.3)),  # Fill colors for each species
  plwd = 3, 
  cglcol = "grey", cglty = 1,  
  cglwd = 1.5,  
  axislabcol = "grey", 
  caxislabels = seq(0, 7, 1), 
  seg = 7, 
  vlcex = 0.8  
)

legend(
  "topright", legend = c("Species1", "Species2", "Species3", "Species4"),
  col = c("blue", "red", "green", "purple"), lty = 1, lwd = 3, bty = "n"
)

#plot1
species1 <- data["Species1", , drop = FALSE]

species1_chart <- rbind(max_values, min_values, species1)

radarchart(
  species1_chart, axistype = 1, title = "Species1 Radar Chart",
  pcol = "blue", pfcol = rgb(0.1, 0.1, 0.8, 0.3), 
  plwd = 3, 
  cglcol = "grey", cglty = 1,
  cglwd = 1.5, 
  axislabcol = "grey", 
  caxislabels = seq(0, 7, 1), 
  seg = 7, 
  vlcex = 0.8 
)

calculate_polygon_area <- function(values) {
  n <- length(values)
  angles <- seq(0, 2 * pi, length.out = n + 1)
  x <- values * cos(angles[-(n + 1)])
  y <- values * sin(angles[-(n + 1)])
  x <- c(x, x[1]) 
  y <- c(y, y[1])
  area <- 0.5 * sum(x[-1] * y[-length(y)] - x[-length(x)] * y[-1])
  abs(area)
}

species1_values <- as.numeric(species1[1, ])
species1_area <- calculate_polygon_area(species1_values)

max_area_values <- rep(7, 7)
max_septagon_area <- calculate_polygon_area(max_area_values)

percentage_occupied <- (species1_area / max_septagon_area) * 100

cat("Percentage of the radar chart occupied by Species1:", round(percentage_occupied, 2), "%\n")

#different dimension levels

data <- data.frame(
  "Community Impact" = c(1, 2, 0, 2), # three levels: 0 no impact known; 1 reduced fitness; 2 extinctions
  "Human Health Impact" = c(1, 2, 3, 3), # four levels: 0 no impact known, 1 nuisance, 2 sickness, 3 death
  "Societal Response" = c(1, 1, 2, 2), # three levels: 0 indifferent, 1 some, 2 A LOT
  "Economic Impact" = c(7, 0, 3, 7), # eight levels: 0 no impact known to 7 highest
  "Reversibility of Impact" = c(0, 2, 1, 2), # three levels: 0 unknown, 1 reversible, 2 irreversible
  "Habitat Impact" = c(1, 5, 7, 7) # three levels: 0 no impact known, 1 slight modifications, 2 substantial modifications
)

rownames(data) <- c("Species1", "Species2", "Species3", "Species4")

max_values <- c(2, 3, 2, 7, 2, 7)
normalized_data <- as.data.frame(t(apply(data, 1, function(x) x / max_values * 100)))
colnames(normalized_data) <- colnames(data)
normalized_data$Species <- rownames(data)

ggRadar(
  normalized_data, aes(group = Species), 
  rescale = FALSE, 
  interactive = FALSE, 
  size = 2, 
  legend.position = "right"
) + theme_minimal() +
  ggtitle("Radar Chart of All Species with Unique Axis Levels")

ggRadar(
  normalized_data, aes(group = Species), 
  rescale = FALSE, 
  interactive = FALSE, 
  size = 2, 
  legend.position = "right"
) + theme_minimal() +
  ggtitle("Radar Chart of All Species with Unique Axis Levels")+
  facet_wrap(~Species)

#Single species plot
single_species_data <- normalized_data[normalized_data$Species == "Species1", ]

ggRadar(
  single_species_data, aes(group = Species),
  rescale = FALSE,
  interactive = FALSE,
  size = 2,
  legend.position = "right"
) + theme_minimal() +
  ggtitle("Radar Chart of Species1 with Unique Axis Levels")

calculate_polygon_area <- function(values) {
  n <- length(values)
  angles <- seq(0, 2 * pi, length.out = n + 1)
  x <- values * cos(angles[-(n + 1)])
  y <- values * sin(angles[-(n + 1)])
  x <- c(x, x[1]) 
  y <- c(y, y[1])
  area <- 0.5 * sum(x[-1] * y[-length(y)] - x[-length(x)] * y[-1])
  abs(area)
}

max_area_values <- rep(100, ncol(data))
max_area <- calculate_polygon_area(max_area_values)

species_areas <- sapply(1:nrow(normalized_data), function(i) {
  values <- as.numeric(normalized_data[i, -ncol(normalized_data)])
  calculate_polygon_area(values)
})

percentages <- (species_areas / max_area) * 100

for (i in 1:nrow(normalized_data)) {
  cat("Percentage of the radar chart occupied by", normalized_data$Species[i], ":", round(percentages[i], 2), "%\n")
}




