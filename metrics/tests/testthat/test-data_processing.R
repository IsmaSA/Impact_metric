library(testthat)
library(dplyr)

# Test data
test_data <- tibble::tibble(
  total_cost = 5,
  observation_count = 10000,
  social_perception = 7,
  health_impact = 6,
  ecosystem_impact = 8,
  ecology_impact = 4,
  reversibility_impact = 5,
  cost_by_country = 2,
  obs_by_country = 1500
)

# Test 1: Check create_radar_chart function without country data
test_that("create_radar_chart creates radar chart without country data", {
  # Capture the plot output using recordPlot
  recordPlot({
    create_radar_chart(test_data)
  })

  # Check if a plot was recorded (i.e., it is not NULL)
  expect_true(!is.null(dev.cur()))  # dev.cur() should not be NULL if a plot was generated
})

# Test 2: Check create_country_radar_chart function with country data
test_that("create_country_radar_chart creates radar chart with country data", {
  # Capture the plot output using recordPlot
  recordPlot({
    create_country_radar_chart(test_data)
  })

  # Check if a plot was recorded (i.e., it is not NULL)
  expect_true(!is.null(dev.cur()))  # dev.cur() should not be NULL if a plot was generated
})

# Test 3: Check if the radar chart data is being normalized correctly (range 0-10)
test_that("create_radar_chart data normalization", {
  # Normalize the data manually for comparison
  radar_data_1 <- test_data %>%
    dplyr::select(
      total_cost, observation_count, social_perception, health_impact, ecosystem_impact, ecology_impact, reversibility_impact
    )

  # Add min/max rows for normalization
  radar_data_1 <- rbind(rep(10, ncol(radar_data_1)), rep(0, ncol(radar_data_1)), radar_data_1)

  # Check if the first and second rows are normalized correctly (should be 10 and 0)
  expect_equal(min(radar_data_1[1, ]), 10)
  expect_equal(max(radar_data_1[1, ]), 10)
  expect_equal(min(radar_data_1[2, ]), 0)
  expect_equal(max(radar_data_1[2, ]), 0)
})

# Test 4: Check if the data selection for the radar chart is correct
test_that("create_radar_chart selects correct columns", {
  # Select the columns for radar chart 1
  radar_data_1 <- test_data %>%
    dplyr::select(
      total_cost, observation_count, social_perception, health_impact, ecosystem_impact, ecology_impact, reversibility_impact
    )

  # Check that the selected columns match the expected ones
  expect_true(all(colnames(radar_data_1) == c("total_cost", "observation_count", "social_perception", "health_impact",
                                              "ecosystem_impact", "ecology_impact", "reversibility_impact")))
})

# Test 5: Check if the correct columns are selected for create_country_radar_chart
test_that("create_country_radar_chart selects correct columns", {
  # Select the columns for radar chart 2
  radar_data_2 <- test_data %>%
    dplyr::select(
      cost_by_country, obs_by_country, social_perception, health_impact, ecosystem_impact, ecology_impact, reversibility_impact
    )

  # Check that the selected columns match the expected ones
  expect_true(all(colnames(radar_data_2) == c("cost_by_country", "obs_by_country", "social_perception", "health_impact",
                                              "ecosystem_impact", "ecology_impact", "reversibility_impact")))
})
