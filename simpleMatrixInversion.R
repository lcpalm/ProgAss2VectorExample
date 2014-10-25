# Simple Matrix Inversion

# Computing the inverse of a square matrix can be done with the `solve`
# function in R. For example, if `X` is a square invertible matrix, then
# `solve(X)` returns its inverse.

m <- matrix(rep(4, 9), 3, 3)
m
solve(m)
# doesn't work:
# Error in solve.default(m) : 
#     Lapack routine dgesv: system is exactly singular: U[2,2] = 0

m <- matrix(rnorm(12), 3, 3)
m
solve(m)
# this seems to work fine.
