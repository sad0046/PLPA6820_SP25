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

mean(vec) # Mean of values in Vector
sd(vec) # Standard Deviation of all values in Vector
sum(vec) # Sum of values in Vector
median(vec) # Median of values in Vector
min(vec) # Smallest value in Vector
max(vec) # Largest value in Vector
summary(vec) # IQR - output depends on the data class
abs(vec) # Absolute Value of each Value
sqrt(vec) # Square Root of each Value
log(vec) # Natural Log (i.e. ln) of each Value
log10(vec) # Log base 10 of each Value
exp(vec) # Power of e of each Value

## Common Error: Failure to include enough parentheses.
## A plus symbol also may occur in the Console indicating a missing or unexpected symbol.
# Example: sqrt(sum(vec)

sqrt(sum(vec))

#### Exercise 5: Logical Operators ####

1 > 2 # Greater than
1 < 2 # Less than
1 <= 2 # Less than or equal to
# = Equals (used to assign values from left to right)
# != Not equals to
1 == 1 # Exactly equal to (used for showing equality between values)
1 == 2 | 1 == 1 # | means 'OR'
1 == 2 & 1 == 1 # & means 'AND' 

## Examples

t <- 1:10
t[(t > 8)] # t such that t is greater than 8
t[(t > 8) | (t < 5)] # t such that t is greater than 8 OR less than 5
t[(t > 8) & (t < 10)] # t such as that t is greater than 8 and less than 10 (i.e. 9)
t[(t != 2)] # t such that t does not equal 2

## If a number exists in a vector

2 %in% t # Is x value in y object?

#### Exercise 6: Data Types ####
## Dataframes are like an Excel Workbook
## Matrices are like dataframes but with only one class
#Scalar Objects
x
# Vectors
t

# Matrices i.e. two-dimensional

mat1 <- matrix(data = c(1, 2, 3), nrow = 3, ncol = 3)
mat1 # Output to see see in the console
mat2 <- matrix(data = c("Zach", "Jie", "Tom"), nrow = 3, ncol = 3)
mat2 # Output to see see in the console

## To find a value in a matrix
# Reads Down then Left to Right

mat1[4] # Output is 1
mat1[2,3] # Views the X Row and Y Column = 1 Value
mat1[1,] # Views the X Row
mat1[,1] # Views the Y Column

# Dataframes

df <- data.frame(mat1[,1], mat2[,1]) # created a data frame with the first columns of mat1 and mat2 and all rows
df # Output to see in the console

# Use colnames() function to rename columns

colnames(df) <- c("Value", "Name")
df
