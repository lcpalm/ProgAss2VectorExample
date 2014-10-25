# Code from the makeVector example for programming assignment 2
# RProgramming fall 2014

# Here is the original code from the Readme:
makeVector <- function(x = numeric()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setmean <- function(mean) m <<- mean
    getmean <- function() m
    list(set = set, get = get,
         setmean = setmean,
         getmean = getmean)
}

cachemean <- function(x, ...) {
    m <- x$getmean()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- mean(data, ...)
    x$setmean(m)
    m
}

# Usage examples from 'Hints for Programming Assignment 2':
# https://class.coursera.org/rprog-008/forum/thread?thread_id=174
# Run each line below one at a time; comments show the expected R console response
a <- makeVector(c(1,2,3,4))
a$get()
# [1] 1 2 3 4 
a$getmean()
# NULL
cachemean(a)
# [1] 2.5
a$getmean()  # this is only to show you that the mean has been stored and does not affect anything
# [1] 2.5
cachemean(a)
# getting cached data
# [1] 2.5
a$set(c(10,20,30,40))
a$getmean()
#NULL
cachemean(a)
#[1] 25
cachemean(a)
#getting cached data
#[1] 25
a$get()
#[1] 10 20 30 40
# This next line you should NOT do!
a$setmean(0)  # do NOT call setmean() directly despite it being accessible for the reason you will see next
a$getmean()
#[1] 0      # obviously non-sense since...
a$get()
#[1] 10 20 30 40
cachemean(a)
#[1] 0    # as you can see the call to setmean() effectively corrupted the functioning of the code
a <- makeVector(c(5, 25, 125, 625))
a$get()
#[1] 5 25 125 625
cachemean(a)
#[1] 195
cachemean(a)
#getting cached data
#[1] 195

