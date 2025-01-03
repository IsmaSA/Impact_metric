# choices.R

# Social Perception Choices
social_perception <- c(
  "People Don't Like It",
  "People Don't Care",
  "People Like It"
)

# Health Impact Choices
health_impact <- c(
  "Nuisance",
  "Can't hurt/kill individuals",
  "Can threaten populations"
)

# Ecosystem Impact Choices
ecosystem_impact <- c(
  "Replaces functions",
  "Hinders functions",
  "LOSS of functions"
)

# Ecological Impact Choices
ecological_impact <- c(
  "Some population fitness decline",
  "Some population extermination",
  "Community loss"
)

# Reversibility Impact Choices
reversibility_impact <- c(
  "Not noticeable",
  "Reversible (some species decline)",
  "Irreversible (some species die out)"
)


# choices.R

# CSV dosyalarını data klasöründen oku
countries_data <- read.csv(system.file("data", "countries.csv", package = "metrics"), stringsAsFactors = FALSE)
species_data <- read.csv(system.file("data", "species.csv", package = "metrics"), stringsAsFactors = FALSE)

# Verileri seçime uygun formatta düzenle
countries <- countries_data$country_name
species <- species_data$species
