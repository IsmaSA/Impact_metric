

#' Convert social perception input to a numeric value
#'
#' This function takes a user input for social perception and converts it to a corresponding numeric value.
#' The function expects a specific set of string inputs and returns an associated numeric value.
#' If the input is invalid, it throws an error.
#'
#' @param input A character string representing the social perception.
#' @return A numeric value corresponding to the selected option:
#'   1 for "People Don't Like It",
#'   2 for "People Don't Care",
#'   3 for "People Like It",
#'   4 for "test_option_4",
#'   5 for "test_option_5".
#' @export
convert_social_perception <- function(input) {
  # Define a mapping of options to numeric values
  mapping <- c("People Don't Like It" = 1,
               "People Don't Care" = 2,
               "People Like It" = 3,
               "test_option_4" = 4,
               "test_option_5" = 5)

  # Check if the input matches one of the predefined options
  if (input %in% names(mapping)) {
    # Return only the numeric value, not the named vector
    return(as.numeric(mapping[input]))
  } else {
    stop("Invalid social perception input.")
  }
}





#' Convert user input for health impact to a numeric value
#'
#' This function converts the input selected by the user regarding the impact of a species on human health
#' to a numeric value. The input is expected to be one of the predefined options.
#'
#' @param input A character string representing the selected health impact option.
#' @return A numeric value corresponding to the selected health impact option:
#'   1 for "Nuisance",
#'   2 for "Can't hurt/kill individuals",
#'   3 for "Can threaten populations",
#'   4 for "test_option_4",
#'   5 for "test_option_5".
#' @export
convert_health_impact <- function(input) {
  # Mapping of health impact options to numeric values
  mapping <- c("Nuisance" = 1,
               "Can't hurt/kill individuals" = 2,
               "Can threaten populations" = 3,
               "test_option_4" = 4,
               "test_option_5" = 5)

  # Check if the input is valid and return the corresponding numeric value
  if (input %in% names(mapping)) {
    return(as.numeric(mapping[input]))  # Ensure the value is numeric
  } else {
    stop("Invalid health impact input.")
  }
}


#' Convert user input for ecosystem impact to a numeric value
#'
#' This function converts the input selected by the user regarding the impact of a species on ecosystem
#' functioning to a numeric value. The input is expected to be one of the predefined options.
#'
#' @param input A character string representing the selected ecosystem impact option.
#' @return A numeric value corresponding to the selected ecosystem impact option:
#'   1 for "Replaces functions",
#'   2 for "Hinders functions",
#'   3 for "LOSS of functions",
#'   4 for "test_option_4",
#'   5 for "test_option_5".
#' @export
convert_ecosystem_impact <- function(input) {
  # Mapping of ecosystem impact options to numeric values
  mapping <- c("Replaces functions" = 1,
               "Hinders functions" = 2,
               "LOSS of functions" = 3,
               "test_option_4" = 4,
               "test_option_5" = 5)

  # Check if the input is valid and return the corresponding numeric value
  if (input %in% names(mapping)) {
    return(as.numeric(mapping[input]))  # Ensure the value is numeric
  } else {
    stop("Invalid ecosystem impact input.")
  }
}



#' Convert user input for ecological impact to a numeric value
#'
#' This function converts the input selected by the user regarding the impact of a species on ecology
#' to a numeric value. The input is expected to be one of the predefined options.
#'
#' @param input A character string representing the selected ecological impact option.
#' @return A numeric value corresponding to the selected ecological impact option:
#'   1 for "Some population fitness decline",
#'   2 for "Some population extermination",
#'   3 for "Community loss",
#'   4 for "test_option_4",
#'   5 for "test_option_5".
#' @export
convert_ecological_impact <- function(input) {
  # Mapping of ecological impact options to numeric values
  mapping <- c("Some population fitness decline" = 1,
               "Some population extermination" = 2,
               "Community loss" = 3,
               "test_option_4" = 4,
               "test_option_5" = 5)

  # Check if the input is valid and return the corresponding numeric value
  if (input %in% names(mapping)) {
    return(as.numeric(mapping[input]))  # Ensure the value is numeric
  } else {
    stop("Invalid ecological impact input.")
  }
}


#' Convert user input for reversibility impact to a numeric value
#'
#' This function converts the input selected by the user regarding the reversibility impact of a species
#' to a numeric value. The input is expected to be one of the predefined options.
#'
#' @param input A character string representing the selected reversibility impact option.
#' @return A numeric value corresponding to the selected reversibility impact option:
#'   1 for "Not noticeable",
#'   2 for "Reversible (some species decline)",
#'   3 for "Irreversible (some species die out)",
#'   4 for "test_option_4",
#'   5 for "test_option_5".
#' @export
convert_reversibility_impact <- function(input) {
  # Mapping of reversibility impact options to numeric values
  mapping <- c("Not noticeable" = 1,
               "Reversible (some species decline)" = 2,
               "Irreversible (some species die out)" = 3,
               "test_option_4" = 4,
               "test_option_5" = 5)

  # Check if the input is valid and return the corresponding numeric value
  if (input %in% names(mapping)) {
    return(as.numeric(mapping[input]))  # Ensure the value is numeric
  } else {
    stop("Invalid reversibility impact input.")
  }
}

