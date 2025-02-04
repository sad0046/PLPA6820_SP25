### Sam Donohoo
### Date: 2/2/2025
### Notes for Coding Homework #1 - PLPA 6820

# This is a comment.

#### This is a section break ####
## Useful for long scripts or for multiple analyses in one script.

# To run code: use Run (Top Right) or CTRL+Enter (PCs)

## R is case sensitive. X does not = x.

### Practice is necessary to learn the language.

#### Exercise #1: R is a Big Calculator ####

2+2 # Addition
2-2 # Substraction
2/2 # Divide
2*2 # Multiple
2^3 # Exponents

#### Exercise #2: Objects ####
# <- is used to identify / store objects
# = is not used as much
# Objects stored in Environment
# These are Numeric Variable Examples.

x <- 2
y = 3

# Calls object values for math.

x+y
x-y
x/y
x*y

# Type out variable name (i.e. x) to print them to consule.
x

## Non-numeric (i.e. Character Variable) data can also be stored in objects.

name <- "Sam"
seven <- "7"

# R can't do math with non-numeric objects.
# Results in an error.

seven + x

# Function: Something that does something to an object.
## Can check the class (i.e. data type) of a variable using the class() function.

class(x) # x is a numeric variable

#### Exercise 3: Vectors ####

# Vectors are multiple data values in a single object
## Concatenate data to make a vector using c()

vec <- c(1, 2, 3, 4, 5, 6, 7)  # numeric vector 
vec <- c(1:7)  # same numeric vector as above, the ':' (colon) generates a sequence
vec <- 1:7  # also works without the concatenate function

vec2 <- c("Zach", "Jie", "Mitch")  # character vector 

vec3 <- c(TRUE, FALSE, TRUE)  # logical vector

## Can locate values in a vector using square brackets

vec5 <- c(2,5,8,10,23,45,60)
vec5[5] # The fifth value is 23

## Can still do math with vectors

vec + x # Will add the scalar x, elementwise to the vec object 

#### Exercise 4: Basic Summary Stats ####

mean(vec) # Mean
sd(vec) # Standard Deviation
sum(vec) # Sum
median(vec) # Median
min(vec) # Smallest value in Vector
max(vec) # Largest value in Vector
summary(vec) # IQR - output depends on the data class
abs(vec) # Absolute Value
sqrt(vec) # Square Root
log(vec) # Natural Log
log10(vec) # Log base 10
exp(vec) # Power of e
