#' Convert country name to ISO 3166-1 alpha-2 country code
#'
#' Converts the country name (e.g., "United States") to its ISO 3166-1 alpha-2 country code (e.g., "US").
#'
#' @param country_name Character string. The full name of the country (e.g., "United States").
#' @return A character string representing the ISO 3166-1 alpha-2 country code (e.g., "US").
#' @import countrycode
#' @export
convert_country_name_to_code <- function(country_name) {
  if (missing(country_name) || !is.character(country_name)) {
    stop("Please provide a valid country name as a character string.")
  }

  # Convert the country name to country code
  country_code <- countrycode::countrycode(country_name, "country.name", "iso2c")

  if (is.na(country_code)) {
    # Return NA for invalid country name instead of stopping the process
    return(NA)
  }

  return(country_code)
}





#' Get observation count by species name
#'
#' @param species_name Character string. The species name to query in GBIF.
#' @return The total observation count for the species.
#' @import rgbif
#' @export
get_observation_count_by_species <- function(species_name) {
  if (missing(species_name) || !is.character(species_name)) {
    stop("Please provide a valid species name as a character string.")
  }

  # Query GBIF for the species observations
  res <- tryCatch({
    rgbif::occ_search(scientificName = species_name, limit = 1)
  }, error = function(e) {
    stop("Error querying GBIF: ", e$message)
  })

  # Check if results exist
  if (is.null(res$meta) || res$meta$count == 0) {
    message("No data found for the species: ", species_name)
    return(0)
  }

  # Return the observation count
  return(res$meta$count)
}



#' Get observation count by species and country code
#'
#' @param species_name Character string. The species name to query in GBIF.
#' @param country_code Character string. The ISO 3166-1 alpha-2 country code.
#' @return The observation count for the species in the specified country.
#' @import rgbif
#' @export
get_obs_count_by_species_country <- function(species_name, country_code) {
  if (missing(species_name) || !is.character(species_name)) {
    stop("Please provide a valid species name as a character string.")
  }
  if (missing(country_code) || !is.character(country_code)) {
    stop("Please provide a valid country code as a character string.")
  }

  # Query GBIF for the species observations in the specified country
  res <- tryCatch({
    rgbif::occ_search(scientificName = species_name, country = country_code, limit = 1)
  }, error = function(e) {
    stop("Error querying GBIF: ", e$message)
  })

  # Check if results exist
  if (is.null(res$meta) || res$meta$count == 0) {
    message("No data found for the species in country: ", country_code)
    return(0)
  }

  # Return the observation count for the species in the specified country
  return(res$meta$count)
}


#' Classify species based on observation count
#'
#' @param observation_count Numeric. The number of observations for the species.
#' @param return_type Character. The type of result: "text" (default) for textual output,
#'                   or "numeric" for numeric output.
#' @return A character string (if return_type = "text") or a numeric value (if return_type = "numeric").
#' @export
get_abundance_type <- function(observation_count, return_type = "text") {

  # Ensure observation_count is a positive number
  if (!is.numeric(observation_count) || observation_count < 0) {
    stop("Please provide a valid numeric observation")
  }

  # Classify species based on observation count
  if (observation_count == 0) {
    abundance_text <- "Extinct"
    abundance_numeric <- 1
  } else if (observation_count <= 10) {
    abundance_text <- "Endangered"
    abundance_numeric <- 2
  } else if (observation_count <= 100) {
    abundance_text <- "Rare"
    abundance_numeric <- 3
  } else if (observation_count <= 1000) {
    abundance_text <- "Common"
    abundance_numeric <- 4
  } else {
    abundance_text <- "Overabundant"
    abundance_numeric <- 5
  }

  # Return the appropriate result based on return_type
  if (return_type == "numeric") {
    return(abundance_numeric)
  } else {
    return(abundance_text)
  }
}
