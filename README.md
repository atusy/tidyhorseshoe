
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tidyhorseshoe

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/R)](https://CRAN.R-project.org/package=R)
<!-- badges: end -->

Support horseshoe regression on tidymodels framework.

## Installation

``` r
remotes::install_github("atusy/tidyhorseshoe")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(tidyhorseshoe)
library(magrittr)
set.seed(0)

x <- runif(4, 0, 5)
y <- 3 * x + rnorm(length(x), 0, 0.1) + 3
d <- data.frame(y, x = x, x2 = x * x, x3 = x * x * x)

fitted <- parsnip::linear_reg() %>% 
  parsnip::set_engine("horseshoe") %>% 
  parsnip::fit(y ~ ., data = d)
#> [1] 1000
#> [1] 2000
#> [1] 3000
#> [1] 4000
#> [1] 5000
#> [1] 6000

fitted$fit$BetaMedian
#> [1]  2.384374255  2.966487234  0.051657307 -0.008521586

cbind(y, predict(fitted, d))
#>           y  .pred_V1
#> 1 16.583438 16.584077
#> 2  7.109873  6.768883
#> 3  8.623323  8.403944
#> 4 11.438805 11.547175
```
