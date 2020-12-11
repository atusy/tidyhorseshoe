#' A wrapper of horseshoe::horseshoe
#'
#' @param x Matrix of covariates, dimension n*p.
#' @inheritParams horseshoe::horseshoe
#' @param verbose `TRUE` (default) or `FALSE`.
#' @inheritDotParams horseshoe::horseshoe -y -X
#'
#' @export
horseshoe <- function(x, y, ..., verbose = TRUE) {
  f <- if (verbose) {
    identical
  } else {
    quiet
  }

  structure(
    horseshoe::horseshoe(y = y, X = x, ...),
    class = c("horseshoe", "list")
  )
}

#' Prediction method for horseshoe
#'
#' @inheritParams stats::predict
#' @param newdata Matrix of covariates, dimension n*p.
#' @param posterior `"mean"` or `"median"` (default).
#' @export
predict.horseshoe <- function(object,
                              newdata,
                              posterior = c("median", "mean"),
                              ...) {
  beta <- c(mean = "BetaHat", median = "BetaMedian")[match.arg(posterior)]

  newdata %*% object[[beta]]
}

utils::globalVariables(c("object", "new_data"))

#' Add horseshoe as a parsnip model
#'
#' @export
add_horseshoe <- function() {
  eng <- "horseshoe"

  if (eng %in% parsnip::show_engines("linear_reg")$engine) {
    warning("Horseshoe engine is already set. Skipping...")
    return(invisible(NULL))
  }

  parsnip::set_model_engine("linear_reg", "regression", eng = eng)
  parsnip::set_dependency("linear_reg", eng = eng, pkg = eng)
  parsnip::set_fit(
    model = "linear_reg",
    eng = eng,
    mode = "regression",
    value = list(
      interface = "matrix",
      protect = c("y", "X"),
      func = c(pkg = "tidyhorseshoe", fun = "horseshoe"),
      defaults = list()
    )
  )

  parsnip::set_pred(
    model = "linear_reg",
    eng = eng,
    mode = "regression",
    type = "numeric",
    value = list(
      pre = NULL,
      post = NULL,
      func = c(fun = "predict"),
      args =
        list(
          object = rlang::expr(object$fit),
          newdata = rlang::expr(new_data),
          type = "response"
        )
    )
  )

  parsnip::set_encoding(
    model = "linear_reg",
    eng = eng,
    mode = "regression",
    options = list(
      predictor_indicators = "traditional",
      compute_intercept = FALSE,
      remove_intercept = FALSE,
      allow_sparse_x = TRUE
    )
  )
}
