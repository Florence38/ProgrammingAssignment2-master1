
R version 3.5.2 (2018-12-20) -- "Eggshell Igloo"
Copyright (C) 2018 The R Foundation for Statistical Computing
Platform: i386-w64-mingw32/i386 (32-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[Previously saved workspace restored]

> ## Caching the Inverse of a Matrix:
> ## Matrix inversion is usually a costly computation and there may be some 
> ## benefit to caching the inverse of a matrix rather than compute it repeatedly.
> ## Below are a pair of functions that are used to create a special object that 
> ## stores a matrix and caches its inverse.
> 
> ## This function creates a special "matrix" object that can cache its inverse.
> 
> makeCacheMatrix <- function(x = matrix()) {
+         inv <- NULL
+         set <- function(y) {
+                 x <<- y
+                 inv <<- NULL
+         }
+         get <- function() x
+         setInverse <- function(inverse) inv <<- inverse
+         getInverse <- function() inv
+         list(set = set,
+              get = get,
+              setInverse = setInverse,
+              getInverse = getInverse)
+ }
> 
> 
> ## This function computes the inverse of the special "matrix" created by 
> ## makeCacheMatrix above. If the inverse has already been calculated (and the 
> ## matrix has not changed), then it should retrieve the inverse from the cache.
> 
> cacheSolve <- function(x, ...) {
+         ## Return a matrix that is the inverse of 'x'
+         inv <- x$getInverse()
+         if (!is.null(inv)) {
+                 message("getting cached data")
+                 return(inv)
+         }
+         mat <- x$get()
+         inv <- solve(mat, ...)
+         x$setInverse(inv)
+         inv
+ }
> > x = rbind(c(1, -1/4), c(-1/4, 1)
Error: unexpected '>' in ">"
>  x = rbind(c(1, -1/4), c(-1/4, 1)
+ m = makeCacheMatrix(x)
Error: unexpected symbol in:
" x = rbind(c(1, -1/4), c(-1/4, 1)
m"
> m = makeCacheMatrix(x)
>  m$get()
Error in m$get() : object 'x' not found
> m$get()
Error in m$get() : object 'x' not found
In addition: Warning message:
In m$get() : restarting interrupted promise evaluation
> cacheSolve(m)
Error in x$get() : object 'x' not found
In addition: Warning message:
In x$get() : restarting interrupted promise evaluation
> my_matrix$get()
     [,1] [,2]
[1,]    2    1
[2,]    2    4
> my_matrix$getInverse()
           [,1]       [,2]
[1,]  0.6666667 -0.1666667
[2,] -0.3333333  0.3333333
> cacheSolve(my_matrix)
getting cached data
           [,1]       [,2]
[1,]  0.6666667 -0.1666667
[2,] -0.3333333  0.3333333
> cacheSolve(my_matrix)
getting cached data
           [,1]       [,2]
[1,]  0.6666667 -0.1666667
[2,] -0.3333333  0.3333333
> my_matrix$getInverse()
           [,1]       [,2]
[1,]  0.6666667 -0.1666667
[2,] -0.3333333  0.3333333
> my_matrix$set(matrix(c(2, 2, 1, 4), 2, 2))
> my_matrix$get()
     [,1] [,2]
[1,]    2    1
[2,]    2    4
> my_matrix$getInverse()
NULL
> cacheSolve(my_matrix)
           [,1]       [,2]
[1,]  0.6666667 -0.1666667
[2,] -0.3333333  0.3333333
>  cacheSolve(my_matrix)
getting cached data
           [,1]       [,2]
[1,]  0.6666667 -0.1666667
[2,] -0.3333333  0.3333333
> my_matrix$getInverse()
           [,1]       [,2]
[1,]  0.6666667 -0.1666667
[2,] -0.3333333  0.3333333
> 
