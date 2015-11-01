## The functions in this file are used to inverse a matrix and store the 
## inverse of the matrix in cache. This will avoid unnecessary 
## inversion of the matrix  

## Function makeCacheMatrix will set and get a matrix, 
## and is used to set and get the inversed matrix
## Input will be a square invertible matrix
## Output will be a list of get and set functions

makeCacheMatrix <- function(x = matrix()) {
  
  m <- NULL
  
  set <- function(y){
    x <<- y
    m <<- NULL
  }
  
  get <- function() x
  
  setinvmatrix <- function(invmatrix) m <<- invmatrix
  
  getinvmatrix <- function() m
  
  ##Returning the list of functions.
  list(set = set, get = get, setinvmatrix = setinvmatrix, 
       getinvmatrix = getinvmatrix)
  
}


## Function cacheSolve will check if inverse of the matrix is available.
## If yes, it will display the inverse from cache. 
## If not, function will inverse the matrix and set the inverse into cache.
## Input will be the functions list returned by function 'makeCacheMatrix'

cacheSolve <- function(x) {
  ## Return a matrix that is the inverse of 'x'
  
  m <- x$getinvmatrix()
  
  if(is.matrix(m)){
    message('Getting the cached inversed matrix')
    ##Returning the inversed matrix
    return (m)
  }
  
  data <- x$get()
  
  m <- solve(data)
  
  x$setinvmatrix(m)
  
  ##Returning the inversed matrix
  m
}
