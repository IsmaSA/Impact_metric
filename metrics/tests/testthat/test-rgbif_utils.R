test_that("convert_country_name_to_code works correctly", {
  # Test valid country name
  result <- convert_country_name_to_code("United States")
  expect_equal(result, "US")  # Expected result is "US"

  result <- convert_country_name_to_code("Germany")
  expect_equal(result, "DE")  # Expected result is "DE"

  # Test edge case: invalid country name (expect NA)
  result <- suppressWarnings(convert_country_name_to_code("Fake Country"))
  expect_equal(result, NA)  # Expected result is NA for invalid country

  # Test missing country name
  expect_error(convert_country_name_to_code(),
               "Please provide a valid country name as a character string.")  # Expected error for missing argument

  # Test country name as a non-character argument
  expect_error(convert_country_name_to_code(123),
               "Please provide a valid country name as a character string.")  # Expected error for non-character input
})



test_that("get_observation_count_by_species works correctly", {
  # Test with a known species
  species_name <- "Panthera leo"  # Example species (lion)
  count <- get_observation_count_by_species(species_name)

  # Check that the count is an integer and greater than 0
  expect_type(count, "integer")  # Using expect_type instead of expect_is
  expect_gt(count, 0)

  # Test with an unknown species
  species_name <- "Fake Species"
  count <- get_observation_count_by_species(species_name)

  # Check that the count is 0
  expect_equal(count, 0)

  # Test with missing species name
  expect_error(get_observation_count_by_species(),
               "Please provide a valid species name as a character string.")

  # Test with invalid species name format
  expect_error(get_observation_count_by_species(123),
               "Please provide a valid species name as a character string.")
})





#
# # Test for get_obs_count_by_species_country
# test_that("get_obs_count_by_species_country works correctly", {
#
#   # Mock input for the test
#   species_name <- "Panthera leo"  # Example species: Lion
#   country_code <- "KE"  # Example country code for Kenya
#
#   # Mock the response of the GBIF query
#   mock_response <- list(
#     meta = list(count = 100)  # Let's assume 100 observations for this example
#   )
#
#   # Mocking the rgbif::occ_search function using with_mock
#   with_mock(
#     `rgbif::occ_search` = function(scientificName, country, limit) {
#       return(mock_response)
#     },
#
#     # Call the function and check if it returns the correct count
#     result <- get_obs_count_by_species_country(species_name, country_code),
#
#     # Test that the result matches the expected count
#     expect_equal(result, 100),
#
#     # Test if the result is of correct type
#     expect_type(result, "double")
#   )
# })


library(testthat)
library(mockery)

test_that("get_obs_count_by_species_country works correctly", {

  # Mock input for the test
  species_name <- "Panthera leo"  # Example species: Lion
  country_code <- "KE"  # Example country code for Kenya

  # Mock the response of the GBIF query
  mock_response <- list(
    meta = list(count = 100)  # Let's assume 100 observations for this example
  )

  # Mock the rgbif::occ_search function using mockery
  mock_occ_search <- mock(mock_response)

  # Use the mock in place of the real rgbif::occ_search function
  stub(get_obs_count_by_species_country, "rgbif::occ_search", mock_occ_search)

  # Call the function and check if it returns the correct count
  result <- get_obs_count_by_species_country(species_name, country_code)

  # Test that the result matches the expected count
  expect_equal(result, 100)

  # Test if the result is of correct type
  expect_type(result, "double")
})




test_that("get_abundance_type classifies species correctly", {

  # Test for observation_count = 0
  expect_equal(get_abundance_type(0), "Extinct")

  # Test for observation_count between 1 and 10
  expect_equal(get_abundance_type(5), "Endangered")

  # Test for observation_count between 11 and 100
  expect_equal(get_abundance_type(50), "Rare")

  # Test for observation_count between 101 and 1000
  expect_equal(get_abundance_type(500), "Common")

  # Test for observation_count > 1000
  expect_equal(get_abundance_type(1500), "Overabundant")

  # Test for invalid input (negative value)
  expect_error({
    get_abundance_type(-1)
  }, "Please provide a valid numeric observation")

  # Test for non-numeric input
  expect_error({
    get_abundance_type("a")
  }, "Please provide a valid numeric observation")
})
