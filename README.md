# tidyhorseshoe

<!-- badges: start -->
[![CRAN status](https://www.r-pkg.org/badges/version/R)](https://CRAN.R-project.org/package=R)
<!-- badges: end -->

Support horseshoe regression on tidymodels framework.

## Installation

```r
remotes::install_github("atusy/tidyhorseshoe")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(tidyhorseshoe)

x <- runif(4, 0, 5)
y <- 3 * x + rnorm(length(x), 0, 0.1) + 3
d <- data.frame(y, x = x, x2 = x * x, x3 = x * x * x)

parsnip::linear_reg() %>% 
  parsnip::set_engine("tidyhorseshoe") %>% 
  parsnip::fit(y ~ ., data = d)
```

