## Example usage:
## x <- matrix(rnorm(16), nrow=4)       -> Creating matrix for processing
## x.cache <- makeCacheMatrix(x)        -> Create cached matrix
## x.cache$get                          -> Return cached matrix
## cacheSolve(x.cache)                  -> Invert matrix
## 

##  makeCacheMatrix: return a list of functions to:
## 1. Set the value of the matrix
## 2. Get the value of the matrix
## 3. Set the value of the inverse
## 4. Get the value of the inverse

makeCacheMatrix <- function(x = numeric()) {
        # Create value for cached matrix input
        inv <- NULL
        # Set function the matrix
        set <- function(y) {
                x <<- y
                i <<- NULL
        }
        # Get function for the matrix
        get <- function() x
        # Set function for the inverse
        setinverse <- function(inverse) inv <<- inverse
        # Get function for the inverse
        getinverse <- function() i
        
        # Return matrix with defined functions
        list(set = set, get = get,
             setinv = setinv,
             getinv = getinv)
}


## cacheSolve computes the inverse of the matrix

cacheSolve <- function(x, ...) {
        i <- x$getinv()
        
        # If inverse is already cached, return it.
        if(!is.null(i)) {
                message("getting cached data")
                return(i)
        }
        
        # Calculating inverse
        data <- x$get()
        i <- solve(data, ...)
        
        # Cache inverse
        x$setinverse(i)
        
        # Call inverse
        i
}
