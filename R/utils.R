quiet <- function(x) {
  sink(tempfile())
  on.exit(sink())
  invisible(force(x))
}

quietly <- function(f) {
  force(f)
  function(...) {
    quiet(f(...))
  }
}
