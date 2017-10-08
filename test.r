myfunction <- function(x) (
	x + rnorm(length(x))
)

myfunction2 <- function() (
	x <- rnorm(100)
	mean(x)
)