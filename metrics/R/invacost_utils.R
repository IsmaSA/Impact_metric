# =========================================================
# invacost Utility Functions
# =========================================================
library(invacost)

#' Load InvaCost Dataset
#'
#' This function loads the InvaCost dataset from the invacost package
#' and returns it to be assigned by a variable.
#'
#' @return A data frame containing the InvaCost dataset.
#' @export
#'
#' @examples
#' invacost_data <- load_invacost_data()
load_invacost_data <- function() {
  # Load the dataset from invacost package
  if (!requireNamespace("invacost", quietly = TRUE)) {
    stop("The 'invacost' package is not installed. Please install it to use this function.")
  }

  data("invacost", package = "invacost", envir = environment())
  return(invacost)
}



#' Prepare InvaCost Data
#'
#' This function cleans and expands the InvaCost dataset by keeping relevant columns,
#' removing missing values, and expanding the dataset to yearly costs.
#'
#' @param df A data frame containing the InvaCost dataset.
#'
#' @return A cleaned and expanded data frame with yearly cost estimates.
#' @export
prepare_invacost_data <- function(df) {
  if (is.null(df)) {
    stop("The input data frame is NULL. Please provide a valid data frame.")
  }

  # Remove rows with missing starting/ending years or cost values
  df <- df[!is.na(df$Probable_starting_year_adjusted), ]
  df <- df[!is.na(df$Probable_ending_year_adjusted), ]
  df <- df[!is.na(df$Raw_cost_estimate_2017_USD_exchange_rate), ]

  # Fill missing start and end years with defaults (if necessary)
  df$Probable_starting_year_adjusted[is.na(df$Probable_starting_year_adjusted)] <- 2000
  df$Probable_ending_year_adjusted[is.na(df$Probable_ending_year_adjusted)] <- 2020

  # Expand the data to yearly costs
  df <- invacost::expandYearlyCosts(
    df,
    startcolumn = "Probable_starting_year_adjusted",
    endcolumn = "Probable_ending_year_adjusted"
  )

  # Keep only the relevant columns
  relevant_columns <- c("Species", "Kingdom", "Phylum", "Class", "Order",
                        "Family", "Genus", "Raw_cost_estimate_2017_USD_exchange_rate",
                        "Official_country")

  # Ensure only relevant columns remain in the dataset
  df <- df[, relevant_columns, drop = FALSE]

  # Return the cleaned data
  return(df)
}


#' Normalize Cost Values
#'
#' This function normalizes the cost values in the InvaCost dataset to a range of 0 to 1.
#'
#' @param df A data frame containing the InvaCost dataset.
#'
#' @return A data frame with the normalized cost values.
#' @export
normalize_costs <- function(df) {
  if (is.null(df) || !("Raw_cost_estimate_2017_USD_exchange_rate" %in% colnames(df))) {
    stop("The input data frame is invalid or missing the required cost column.")
  }

  # Extract cost values
  cost_values <- df$Raw_cost_estimate_2017_USD_exchange_rate

  # Min-Max Normalization
  min_cost <- min(cost_values, na.rm = TRUE)
  max_cost <- max(cost_values, na.rm = TRUE)

  # Normalize costs between 0 and 1
  df$Normalized_Cost <- (cost_values - min_cost) / (max_cost - min_cost)

  return(df)
}




#' Get Total Cost by Species
#'
#' This function calculates the total cost for a given species from a dataset containing raw cost estimates. The total cost is returned in billion USD.
#'
#' @param species_name A character string representing the species name to filter the data by.
#' @param invacost_data A data frame containing the cost data for multiple species, with at least two columns: `Species` and `Raw_cost_estimate_2017_USD_exchange_rate`.
#'
#' @return A numeric value representing the total cost for the specified species in billion USD. If no data is found for the species, returns 0.
#'
#' @details The function filters the input data for the specified species and calculates the total raw cost estimate (in 2017 USD). The result is converted to billion USD and returned as a rounded value.
#'
#' @examples
#' # Example usage:
#' invacost_data <- data.frame(Species = c("species1", "species2", "species1"),
#'                             Raw_cost_estimate_2017_USD_exchange_rate = c(100, 200, 150))
#' get_total_cost_by_species("species1", invacost_data)
#'
#' @export
get_total_cost_by_species <- function(species_name, invacost_data) {
  # Filter the dataset for the given species
  filtered_data <- invacost_data[invacost_data$Species == species_name, ]

  # Check if the species exists in the dataset
  if (nrow(filtered_data) == 0) {
    message("No data found for the species: ", species_name)
    return(0)
  }

  # Calculate the total cost
  total_cost <- sum(filtered_data$Raw_cost_estimate_2017_USD_exchange_rate, na.rm = TRUE)

  # Convert to billion USD
  total_cost_billion <- round(total_cost / 1e9, 2)

  return(total_cost_billion)
}





#' Get Total Cost for a Given Species and Country
#'
#' This function calculates the total cost for a specified species and country from Invacost data.
#' The result is returned in billion USD for better readability.
#'
#' @param species_name The name of the species (character).
#' @param country_name The name of the country (character).
#' @param invacost_data The dataset containing the InvaCost data (data frame).
#'
#' @return The total cost for the species and country in billion USD (numeric).
#' @export
#'
#' @examples
#' \dontrun{
#' total_cost <- get_cost_by_species_country("Species A", "Country B", invacost_data)
#' }
get_cost_by_species_country <- function(species_name, country_name, invacost_data) {
  # Filter the dataset for the given species and country
  filtered_data <- invacost_data[
    invacost_data$Species == species_name & invacost_data$Official_country == country_name,
  ]

  # Check if the species and country exist in the dataset
  if (nrow(filtered_data) == 0) {
    message("No data found for the species: ", species_name, " in country: ", country_name)
    return(0)
  }

  # Calculate the total cost
  total_cost <- sum(filtered_data$Raw_cost_estimate_2017_USD_exchange_rate, na.rm = TRUE)

  # Convert to billion USD
  total_cost_billion <- round(total_cost / 1e9, 2)

  return(total_cost_billion)
}



#' Get Normalized Cost by Species
#'
#' This function calculates the normalized cost for a given species from a dataset containing raw cost estimates.
#' The normalization scales the cost values for the specified species between 0 and 1.
#'
#' @param species_name A character string representing the species name to filter the data by.
#' @param invacost_data A data frame containing the cost data for multiple species, with at least two columns:
#'   `Species` and `Raw_cost_estimate_2017_USD_exchange_rate`.
#'
#' @return A numeric vector representing the normalized costs for the specified species.
#'   If no data is found for the species, returns an empty numeric vector.
#'
#' @details The function filters the input data for the specified species and applies a min-max normalization
#'   on the raw cost estimates for that species. The normalized costs are returned as values between 0 and 1.
#'
#' @examples
#' # Example usage:
#' invacost_data <- data.frame(Species = c("species1", "species2", "species1"),
#'                             Raw_cost_estimate_2017_USD_exchange_rate = c(100, 200, 150))
#' get_normalized_cost_by_species("species1", invacost_data)
#'
#' @export
get_normalized_cost_by_species <- function(species_name, invacost_data) {
  # Filter the dataset for the given species
  filtered_data <- invacost_data[invacost_data$Species == species_name, ]

  # Check if the species exists in the dataset
  if (nrow(filtered_data) == 0) {
    message("No data found for the species: ", species_name)
    return(numeric(0))  # Return an empty numeric vector
  }

  # Extract the raw cost values
  raw_costs <- filtered_data$Raw_cost_estimate_2017_USD_exchange_rate

  # Min-max normalization (0-1 scaling)
  normalized_costs <- (raw_costs - min(raw_costs, na.rm = TRUE)) /
    (max(raw_costs, na.rm = TRUE) - min(raw_costs, na.rm = TRUE))

  return(normalized_costs)
}



#' Get Normalized Cost for a Given Species and Country
#'
#' This function calculates the normalized cost for a specified species and country from the InvaCost data.
#' Normalization is done using min-max scaling across all costs for the specified country.
#'
#' @param species_name The name of the species (character).
#' @param country_name The name of the country (character).
#' @param invacost_data The dataset containing the InvaCost data (data frame).
#'
#' @return A numeric vector of normalized costs for the species and country. Returns an empty vector if no data is found.
#' @export
#'
#' @examples
#' \dontrun{
#' normalized_cost <- get_normalized_cost_by_species_country("Species A", "Country B", invacost_data)
#' }
get_normalized_cost_by_species_country <- function(species_name, country_name, invacost_data) {
  # Filter the dataset for the given country
  country_data <- invacost_data[invacost_data$Official_country == country_name, ]

  # Check if the country exists in the dataset
  if (nrow(country_data) == 0) {
    message("No data found for the country: ", country_name)
    return(numeric(0))
  }

  # Filter the dataset for the given species within the specified country
  filtered_data <- country_data[country_data$Species == species_name, ]

  # Check if the species exists in the dataset for the specified country
  if (nrow(filtered_data) == 0) {
    message("No data found for the species: ", species_name, " in country: ", country_name)
    return(numeric(0))
  }

  # Extract the cost column for normalization
  cost_column <- country_data$Raw_cost_estimate_2017_USD_exchange_rate

  # Normalize costs using min-max scaling
  normalized_cost <- (filtered_data$Raw_cost_estimate_2017_USD_exchange_rate - min(cost_column, na.rm = TRUE)) /
    (max(cost_column, na.rm = TRUE) - min(cost_column, na.rm = TRUE))

  return(normalized_cost)
}


