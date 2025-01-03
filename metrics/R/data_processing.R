#' Combine Data for Radar Chart
#'
#' This function combines various data sources (cost, observations, and user inputs)
#' into a single data frame, ready for radar chart creation and analysis.
#' The function retrieves data from the Invacost and RGBIF APIs based on the species
#' and country provided. It also incorporates user-defined metrics to create a
#' comprehensive dataset for further analysis.
#'
#' @param species A string. The scientific name of the species (e.g., "Panthera leo").
#' @param country A string. The name of the country (e.g., "Kenya").
#' @param user_inputs A list. A list containing user inputs for metrics, with the following components:
#'   - social_perception: A numeric value for the social perception impact.
#'   - health_impact: A numeric value for the health impact.
#'   - ecosystem_impact: A numeric value for the ecosystem impact.
#'   - ecology_impact: A numeric value for the ecology impact.
#'   - reversibility_impact: A numeric value for the reversibility impact.
#' @param invacost_data A tibble. A dataset containing the Invacost data, including species costs and country-specific costs.
#'
#' @return A tibble containing the following columns:
#'   - total_cost: The total cost associated with the species from Invacost.
#'   - cost_by_country: The cost for the species in the specified country from Invacost.
#'   - observation_count: The total number of observations for the species from RGBIF.
#'   - obs_by_country: The number of observations for the species in the specified country from RGBIF.
#'   - social_perception: User-defined metric for social perception impact.
#'   - health_impact: User-defined metric for health impact.
#'   - ecosystem_impact: User-defined metric for ecosystem impact.
#'   - ecology_impact: User-defined metric for ecology impact.
#'   - reversibility_impact: User-defined metric for reversibility impact.
#'
#' @examples
#' user_inputs <- list(social_perception = 4, health_impact = 5, ecosystem_impact = 3, ecology_impact = 2, reversibility_impact = 4)
#' invacost_data <- tibble::tibble(species = "Panthera leo", cost = 5000, country = "Kenya")
#' combined_data <- combine_data("Panthera leo", "Kenya", user_inputs, invacost_data)
#' print(combined_data)
combine_data <- function(species, country, user_inputs, invacost_data) {
  # 1. Convert country name to country code
  country_code <- convert_country_name_to_code(country)

  # 2. Total cost from Invacost
  total_cost <- get_total_cost_by_species(species, invacost_data)

  # 3. Cost by country from Invacost
  cost_by_country <- get_cost_by_species_country(species, country, invacost_data)

  # 4. Observation count from RGBIF
  observation_count <- get_observation_count_by_species(species)

  # 5. Observation count by country from RGBIF (using country_code)
  obs_by_country <- get_obs_count_by_species_country(species, country_code)

  # User inputs
  user_summary <- tibble::tibble(
    social_perception = user_inputs$social_perception,
    health_impact = user_inputs$health_impact,
    ecosystem_impact = user_inputs$ecosystem_impact,
    ecology_impact = user_inputs$ecology_impact,
    reversibility_impact = user_inputs$reversibility_impact
  )

  # Combine all data
  combined_data <- tibble::tibble(
    total_cost = total_cost,
    cost_by_country = cost_by_country,
    observation_count = observation_count,
    obs_by_country = obs_by_country
  ) %>%
    dplyr::bind_cols(user_summary)

  return(combined_data)
}
