load("tests\\testthat\\testdata\\points1.RData")
testthat::test_that("get_points work correctly", {
  testthat::expect_length(ZIM_status("rf_pot",points1),1)
  testthat::expect_equal(as.numeric(ZIM_status("rf1",points1)),1)
})
