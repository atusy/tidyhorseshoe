test_that("horseshoe wraps horseshoe::horseshoe", {
  X <- as.matrix(mtcars[1:5, -1])
  y <- mtcars[1:5, 1]
  expect_named(
    horseshoe(X, y, verbose = FALSE),
    names(quietly(horseshoe::horseshoe)(y, X))
  )
})
