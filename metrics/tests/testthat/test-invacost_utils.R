# test-invacost_utils.R
test_that("invacost data loading works", {
  # Test loading the invacost dataset
  invacost_data <- load_invacost_data()
  expect_true(is.data.frame(invacost_data))  # Check if the returned data is a data frame
  expect_true("Official_country" %in% colnames(invacost_data))  # Check if expected column exists
})


test_that("prepare_invacost_data works as expected", {
  # Prepare a mock data frame to simulate the Invacost dataset
  test_data <- data.frame(
    Species = c("Species1", "Species2", "Species3"),
    Kingdom = c("Kingdom1", "Kingdom2", "Kingdom3"),
    Phylum = c("Phylum1", "Phylum2", "Phylum3"),
    Class = c("Class1", "Class2", "Class3"),
    Order = c("Order1", "Order2", "Order3"),
    Family = c("Family1", "Family2", "Family3"),
    Genus = c("Genus1", "Genus2", "Genus3"),
    Raw_cost_estimate_2017_USD_exchange_rate = c(1000, 1500, 1200),
    Official_country = c("Country1", "Country2", "Country3"),
    Probable_starting_year_adjusted = c(1990, 2000, 2010),
    Probable_ending_year_adjusted = c(2000, 2010, 2020),
    Cost_ID = c(1, 2, 3),  # Add cost_ID to match invacost's expected columns
    Extra_column1 = c("extra1", "extra2", "extra3"),
    Extra_column2 = c("extra4", "extra5", "extra6")
  )

  # Run the function on the test data
  cleaned_data <- prepare_invacost_data(test_data)

  # Check if the cleaned data has the correct number of rows and columns
  expect_equal(nrow(cleaned_data), 33)  # Should not remove any rows
  expect_equal(ncol(cleaned_data), 9)  # Should keep only 9 columns

  # Check if the relevant columns are included
  expect_true(all(c("Species", "Kingdom", "Phylum", "Class", "Order",
                    "Family", "Genus", "Raw_cost_estimate_2017_USD_exchange_rate",
                    "Official_country") %in% colnames(cleaned_data)))

  # Check if the extra columns are removed
  expect_false("Extra_column1" %in% colnames(cleaned_data))
  expect_false("Extra_column2" %in% colnames(cleaned_data))
})




test_that("get_total_cost_by_species works as expected", {
  # Create example dataset
  example_data <- data.frame(
    Species = c("Species A", "Species B", "Species C"),
    Raw_cost_estimate_2017_USD_exchange_rate = c(50000000, 200000000, NA)
  )

  # Test 1: Species exists in dataset
  result_species_a <- get_total_cost_by_species("Species A", example_data)
  expect_equal(result_species_a, 0.05) # 50 million USD -> 0.05 billion USD

  # Test 2: Species does not exist in dataset
  result_species_d <- get_total_cost_by_species("Species D", example_data)
  expect_equal(result_species_d, 0) # No data found, should return 0

  # Test 3: Species has NA cost values
  result_species_c <- get_total_cost_by_species("Species C", example_data)
  expect_equal(result_species_c, 0) # NA cost, should return 0

  # Test 4: Multiple matches for a species
  example_data_multi <- rbind(
    example_data,
    data.frame(Species = "Species A", Raw_cost_estimate_2017_USD_exchange_rate = 30000000)
  )
  result_species_a_multi <- get_total_cost_by_species("Species A", example_data_multi)
  expect_equal(result_species_a_multi, 0.08) # 50M + 30M -> 80M -> 0.08 billion USD
})



test_that("normalize_costs works as expected", {
  # Example data frame
  example_data <- data.frame(
    Species = c("Species A", "Species B", "Species C"),
    Raw_cost_estimate_2017_USD_exchange_rate = c(50000000, 200000000, 300000000)
  )

  # Normalize costs
  normalized_data <- normalize_costs(example_data)

  # Check that the new column is added and normalized between 0 and 1
  expect_true("Normalized_Cost" %in% colnames(normalized_data))
  expect_true(all(normalized_data$Normalized_Cost >= 0 & normalized_data$Normalized_Cost <= 1))
})



test_that("get_cost_by_species_country works as expected", {
  # Create a small sample dataset for testing
  test_data <- data.frame(
    Species = c("Species A", "Species A", "Species B"),
    Official_country = c("Country X", "Country Y", "Country X"),
    Raw_cost_estimate_2017_USD_exchange_rate = c(1000000000, 2000000, 1500000)
  )

  # Test 1: Valid species and country
  result <- get_cost_by_species_country("Species A", "Country X", test_data)
  expect_equal(result, 1)  # Expected total cost is 1 billion USD

  # Test 2: Species exists but country doesn't
  result <- get_cost_by_species_country("Species A", "Country Z", test_data)
  expect_equal(result, 0)  # No data found, should return 0

  # Test 3: Country exists but species doesn't
  result <- get_cost_by_species_country("Species C", "Country X", test_data)
  expect_equal(result, 0)  # No data found, should return 0

  # Test 4: Species and country combination does not exist
  result <- get_cost_by_species_country("Species B", "Country Y", test_data)
  expect_equal(result, 0)  # No data found, should return 0
})



# test-invacost_utils.R
test_that("get_normalized_cost_by_species works correctly", {
  # Test data
  invacost_data <- data.frame(
    Species = c("species1", "species2", "species1", "species3"),
    Raw_cost_estimate_2017_USD_exchange_rate = c(100, 200, 150, 300)
  )

  # Test 1: Does it return correctly normalized values?
  normalized_costs <- get_normalized_cost_by_species("species1", invacost_data)
  expected_costs <- c(0, 1)  # Min-max normalization: (100-100)/(150-100), (150-100)/(150-100)
  expect_equal(normalized_costs, expected_costs)

  # Test 2: Does it return an empty vector for a non-existing species?
  normalized_costs_empty <- get_normalized_cost_by_species("unknown_species", invacost_data)
  expect_equal(normalized_costs_empty, numeric(0))

  # Test 3: Does it handle a single observation correctly?
  invacost_data_single <- data.frame(
    Species = c("species1"),
    Raw_cost_estimate_2017_USD_exchange_rate = c(100)
  )
  normalized_costs_single <- get_normalized_cost_by_species("species1", invacost_data_single)
  expect_equal(normalized_costs_single, NaN)  # When min and max are the same, result is 0

  # Test 4: Does it handle NA values correctly?
  invacost_data_na <- data.frame(
    Species = c("species1", "species1"),
    Raw_cost_estimate_2017_USD_exchange_rate = c(100, NA)
  )
  normalized_costs_na <- get_normalized_cost_by_species("species1", invacost_data_na)
  expected_costs_na <- c(NaN, NA)  # NA values remain as is
  expect_equal(normalized_costs_na, expected_costs_na)

  # Test 5: Does it display the correct message for a missing species?
  expect_message(
    get_normalized_cost_by_species("unknown_species", invacost_data),
    "No data found for the species: unknown_species"
  )
})

# Test for get_normalized_cost_by_species_country function
test_that("get_normalized_cost_by_species_country works correctly", {
  # Example dataset
  invacost_data <- data.frame(
    Species = c("species1", "species1", "species2", "species3"),
    Official_country = c("USA", "Canada", "USA", "Canada"),
    Raw_cost_estimate_2017_USD_exchange_rate = c(100, 200, 150, 300)
  )

  # Test 1: Normalized cost for species1 in USA
  normalized_cost <- get_normalized_cost_by_species_country("species1", "USA", invacost_data)
  expect_length(normalized_cost, 1)  # Should return one normalized value
  expect_gte(normalized_cost, 0)    # Normalized value should be >= 0
  expect_lte(normalized_cost, 1)    # Normalized value should be <= 1

  # Test 2: Normalized cost for species3 in Canada
  normalized_cost <- get_normalized_cost_by_species_country("species3", "Canada", invacost_data)
  expect_length(normalized_cost, 1)
  expect_equal(normalized_cost, 1)  # Species3 has the max cost in Canada

  # Test 3: No data for a species in a specific country
  normalized_cost <- get_normalized_cost_by_species_country("species2", "Canada", invacost_data)
  expect_length(normalized_cost, 0)  # Should return an empty numeric vector

  # Test 4: No data for a country
  normalized_cost <- get_normalized_cost_by_species_country("species1", "UK", invacost_data)
  expect_length(normalized_cost, 0)  # Should return an empty numeric vector

  # Test 5: No data for a species
  normalized_cost <- get_normalized_cost_by_species_country("species4", "USA", invacost_data)
  expect_length(normalized_cost, 0)  # Should return an empty numeric vector
})


