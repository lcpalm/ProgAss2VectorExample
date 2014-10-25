# Code from the makeVector example for programming assignment 2
# RProgramming fall 2014

# Modified to change all variable and function names to unique where-ever possible.
# and only those using <<- keep the same name.
# Also don't use "mean" as a variable name (even though you can, technically)

# Here is the code from the Readme, modified by Linda:
makeFancyVector <- function(x = numeric()) {    # x must be a numeric vector, eg c(1,2,5,6)
    m <- NULL
    setvector <- function(y) {
        x <<- y
        m <<- NULL
    }
    getvector <- function() x
    setmean <- function(themean) m <<- themean
    getmean <- function() m
    list(setVec = setvector, 
         getVec = getvector,
         setMean = setmean,
         getMean = getmean)
}


cachemean <- function(fancyx, ...) {   # What is the use of these .... ????
# fancyx must be an object produced by a call to makeFancyVector    
# so my question here is, can I use fancyx for the name instead of x?
# and can I used a different name for m?
    mFromCache <- fancyx$getM()
    if(!is.null(mFromCache)) {
        message("getting cached data")
        return(mFromCache)
    }
    data <- fancyx$getV()
    mCalculated <- mean(data, ...)        # What is the use of these .... ???? How can I call the function mean this way?
    fancyx$setM(mCalculated)
    mCalculated
}
# So it seems pretty clear: the names m and x aren't used or needed by cachemean;
# they are used by setVector and setMean only. 

# So the idea is to use makeFancyVector to create a "fancy vector":
# this function, given a numeric vector of values, stores that vector ... somewhere...!! under the name x;
# and stores its mean... doesn't calculate it, but makes a storage space somewhere for it, as m;
# and returns a list of four functions which allow you respectively:
# 1. to get that vector, or 
# 2. to reset it to a different vector; 
# 3. to get the stored vector's mean, IF that mean has been calculated and stored already ---
#  --- a totally different function, cachemean, is used to calculate and store it,
#  --- cachemean takes as input argument, the fancy vector created by makeFancyVector ---
#  ----if the mean hasn't been calculated yet by cachemean, the stored value is NULL, and that is returned;
# 4. to set the stored vector's mean... which last should only be done by the 
# cachemean code, not ever called by the user explicitily. # Jeezus.
# What bugs me is that x and m exist somewhere even though only what is returned are the four functions. Weird.

# Usage examples from 'Hints for Programming Assignment 2':
# https://class.coursera.org/rprog-008/forum/thread?thread_id=174
# Run each line below one at a time; comments show the expected R console response
a <- makeFancyVector(c(1,2,3,4))
a$getVec()
# [1] 1 2 3 4 
a$getMean()
# NULL
cachemean(a)
# [1] 2.5
a$getMean()  # this is only to show you that the mean has been stored and does not affect anything
# [1] 2.5
cachemean(a)
# getting cached data
# [1] 2.5
a$setVec(c(10,20,30,40))
a$getMean()
#NULL
cachemean(a)
#[1] 25
cachemean(a)
#getting cached data
#[1] 25
a$getVec()
#[1] 10 20 30 40
# This next line you should NOT do!
a$setMean(0)  # do NOT call setmean() directly despite it being accessible for the reason you will see next
a$getMean()
#[1] 0      # obviously non-sense since...
a$getVec()
#[1] 10 20 30 40
cachemean(a)
#[1] 0    # as you can see the call to setmean() effectively corrupted the functioning of the code
a <- makeFancyVector(c(5, 25, 125, 625))
a$getVec()
#[1] 5 25 125 625
cachemean(a)
#[1] 195
cachemean(a)
#getting cached data
#[1] 195

# Testdots function:
dummy <- function(x, ...) {
    foo <- mean(x)
    goo <- mean(x, ...)
    goo
}
# ok it's ok.
dummy(c(3,4,5))
dummy(c(3,4,5), 45)
# both return the mean of the first argument. The 45 seems to be ignored.
boo <- mean(c(3,4,5), 34) # is ok, but
boo <- mean(c(3,4,5), ...) # returns an error
# The function definition of mean has ... as an argument; described in its help page as:
# "...     further arguments passed to or from other methods"
# So, yeah, inside the function dummy, the statement goo <- mean(x, ...) doesn't yet know
# if there's going to be some additional arguments passed. OK, I guess. Not sure how they
# are passed yet but I think that will become clearer later. Saw a little about it in some 
# of the lectures, when doing 'constructed functions' or something like that.
# OK, no need to worry about that now. I hope it's not needed for the matrix though. H'm.
# That could be hairy.

