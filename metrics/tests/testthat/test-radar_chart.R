test_that("create_radar_chart creates radar chart without country data", {
  # Sample data
  combined_data <- tibble::tibble(
    total_cost = c(10, 5),
    observation_count = c(100, 50),
    social_perception = c(7, 4),
    health_impact = c(8, 6),
    ecosystem_impact = c(9, 5),
    ecology_impact = c(7, 4),
    reversibility_impact = c(6, 3)
  )

  # Test if the function runs without errors
  expect_error(create_radar_chart(combined_data), NA)  # Expect no error
})

test_that("create_country_radar_chart creates radar chart with country data", {
  # Sample data with country data
  combined_data <- tibble::tibble(
    cost_by_country = c(20, 10),
    obs_by_country = c(200, 150),
    social_perception = c(7, 4),
    health_impact = c(8, 6),
    ecosystem_impact = c(9, 5),
    ecology_impact = c(7, 4),
    reversibility_impact = c(6, 3)
  )

  # Test if the function runs without errors
  expect_error(create_country_radar_chart(combined_data), NA)  # Expect no error
})


library(testthat)

# Test for calculate_radar_area function
test_that("Radar chart area is calculated correctly", {

  # Test data for the radar chart (values should be normalized to 0-1 range)
  values_1 <- c(0.5, 0.8, 0.6, 0.4, 0.9)
  values_2 <- c(1, 0.9, 0.8, 0.7, 0.6, 0.5)

  # Calculate area using the function
  area_1 <- calculate_radar_area(values_1)
  area_2 <- calculate_radar_area(values_2)

  # Expected area should be a positive value for non-zero input
  expect_true(area_1 > 0)
  expect_true(area_2 > 0)

  # Check if the area is reasonable (non-zero and positive)
  expect_type(area_1, "double")
  expect_type(area_2, "double")

  # Test with a simple case (all values are the same, should form a regular polygon)
  values_3 <- rep(1, 6)  # Perfect regular polygon (hexagon)
  area_3 <- calculate_radar_area(values_3)

  expect_true(area_3 > 0)
  expect_type(area_3, "double")

  # Optional: Add further custom checks for specific expected results based on known formulas
})
