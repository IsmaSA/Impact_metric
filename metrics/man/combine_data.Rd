% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data_processing.R
\name{combine_data}
\alias{combine_data}
\title{Combine Data for Radar Chart}
\usage{
combine_data(species, country, user_inputs, invacost_data)
}
\arguments{
\item{species}{A string. The scientific name of the species (e.g., "Panthera leo").}

\item{country}{A string. The name of the country (e.g., "Kenya").}

\item{user_inputs}{A list. A list containing user inputs for metrics, with the following components:
\itemize{
\item social_perception: A numeric value for the social perception impact.
\item health_impact: A numeric value for the health impact.
\item ecosystem_impact: A numeric value for the ecosystem impact.
\item ecology_impact: A numeric value for the ecology impact.
\item reversibility_impact: A numeric value for the reversibility impact.
}}

\item{invacost_data}{A tibble. A dataset containing the Invacost data, including species costs and country-specific costs.}
}
\value{
A tibble containing the following columns:
\itemize{
\item total_cost: The total cost associated with the species from Invacost.
\item cost_by_country: The cost for the species in the specified country from Invacost.
\item observation_count: The total number of observations for the species from RGBIF.
\item obs_by_country: The number of observations for the species in the specified country from RGBIF.
\item social_perception: User-defined metric for social perception impact.
\item health_impact: User-defined metric for health impact.
\item ecosystem_impact: User-defined metric for ecosystem impact.
\item ecology_impact: User-defined metric for ecology impact.
\item reversibility_impact: User-defined metric for reversibility impact.
}
}
\description{
This function combines various data sources (cost, observations, and user inputs)
into a single data frame, ready for radar chart creation and analysis.
The function retrieves data from the Invacost and RGBIF APIs based on the species
and country provided. It also incorporates user-defined metrics to create a
comprehensive dataset for further analysis.
}
\examples{
user_inputs <- list(social_perception = 4, health_impact = 5, ecosystem_impact = 3, ecology_impact = 2, reversibility_impact = 4)
invacost_data <- tibble::tibble(species = "Panthera leo", cost = 5000, country = "Kenya")
combined_data <- combine_data("Panthera leo", "Kenya", user_inputs, invacost_data)
print(combined_data)
}
