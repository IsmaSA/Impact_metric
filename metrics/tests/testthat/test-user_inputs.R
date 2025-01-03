# test-user_inputs.R
test_that("convert_social_perception works correctly", {
  # Doğru dönüşüm kontrolleri
  expect_equal(convert_social_perception("People Don't Like It"), 1)
  expect_equal(convert_social_perception("People Don't Care"), 2)
  expect_equal(convert_social_perception("People Like It"), 3)
  expect_equal(convert_social_perception("test_option_4"), 4)
  expect_equal(convert_social_perception("test_option_5"), 5)

  # Hatalı giriş durumunda hata mesajı
  expect_error(convert_social_perception("Invalid Option"), "Invalid social perception input.")
})


test_that("convert_health_impact works correctly", {
  # Test valid inputs
  expect_equal(convert_health_impact("Nuisance"), 1)
  expect_equal(convert_health_impact("Can't hurt/kill individuals"), 2)
  expect_equal(convert_health_impact("Can threaten populations"), 3)
  expect_equal(convert_health_impact("test_option_4"), 4)
  expect_equal(convert_health_impact("test_option_5"), 5)

  # Test invalid input
  expect_error(convert_health_impact("Invalid option"), "Invalid health impact input.")
})


test_that("convert_ecosystem_impact works correctly", {
  # Test valid inputs
  expect_equal(convert_ecosystem_impact("Replaces functions"), 1)
  expect_equal(convert_ecosystem_impact("Hinders functions"), 2)
  expect_equal(convert_ecosystem_impact("LOSS of functions"), 3)
  expect_equal(convert_ecosystem_impact("test_option_4"), 4)
  expect_equal(convert_ecosystem_impact("test_option_5"), 5)

  # Test invalid input
  expect_error(convert_ecosystem_impact("Invalid option"), "Invalid ecosystem impact input.")
})



test_that("convert_ecological_impact works correctly", {
  # Test valid inputs
  expect_equal(convert_ecological_impact("Some population fitness decline"), 1)
  expect_equal(convert_ecological_impact("Some population extermination"), 2)
  expect_equal(convert_ecological_impact("Community loss"), 3)
  expect_equal(convert_ecological_impact("test_option_4"), 4)
  expect_equal(convert_ecological_impact("test_option_5"), 5)

  # Test invalid input
  expect_error(convert_ecological_impact("Invalid option"), "Invalid ecological impact input.")
})


test_that("convert_reversibility_impact works correctly", {
  # Test valid inputs
  expect_equal(convert_reversibility_impact("Not noticeable"), 1)
  expect_equal(convert_reversibility_impact("Reversible (some species decline)"), 2)
  expect_equal(convert_reversibility_impact("Irreversible (some species die out)"), 3)
  expect_equal(convert_reversibility_impact("test_option_4"), 4)
  expect_equal(convert_reversibility_impact("test_option_5"), 5)

  # Test invalid input
  expect_error(convert_reversibility_impact("Invalid option"), "Invalid reversibility impact input.")
})
