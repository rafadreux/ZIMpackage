load("tests\\testthat\\testdata\\example1.RData")
testthat::test_that("get_points work correctly", {
  testthat::expect_true(ncol(get_points(example1$Pp))==8)
  testthat::expect_equal(round(get_points(example1$Pp),5),
                         data.frame(slope_1 = -1.15699, slope_2 = 3.29691, max1 = 173, pmax1=41, rat1=0.28805, max2=110, pmax2=4, rat2=0.99495))
})
