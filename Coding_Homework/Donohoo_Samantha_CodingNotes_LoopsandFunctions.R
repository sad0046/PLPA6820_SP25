### Sam Donohoo
### Date: 3/26/2025
### Notes for Coding Homework Iterations and Functions - PLPA 6820

# Load Packages
library(ggplot2)
library(drc) 
library(tidyverse)
library(dplyr)

#### Functions ####

# Functions are useful to simplify your code, and make your data management as reproducible as possible.

## Example: Convert Fahrenheit into Celsius
## (5*(degree_f - 32)/9)
(5*(32 - 32)/9)

## Create a Function
F_to_C <- function(fahrenheit_temp){
  celsius <- (5*(fahrenheit_temp - 32)/9)
  return(celsius)
}

## Use Function
F_to_C(80)

## Anatomy of a Function
sample.function <- function(... variable goes here ...){
  .... code goes here.... 
  return(... output ...)
}

## Various functions

### rep() - Allows you to repeat elements easily.
rep("A", 3) # Prints A x 3
rep (c("A", "B"), 5) # Prints A and B x 5
rep(c(1,2,5,2), times = 4, each = 4) # Repeats 1 four times, 2 four times, 5 four times, and 2 four times. 

### seq() - Allows you to write sequences of #s easily.
seq(from = 1, to = 7) # Sequence of numbers 1 to 7.
seq(from = 0, to = 10, by = 2) # Sequence of numbers from 0 to 10 by 2s.

# combined seq() and rep()
rep(seq(from = 0, to = 10, by = 2), times = 3, each = 2)

### seq_along() - Generate a sequences of #'s based on non-intergar values.
seq_along(LETTERS[1:5]) # will return 1,2,3,4,5 not the actual letters. 

#### For Loops ####

## Example
for (i in 1:10) {
  print(i*2)  
}
# For each # in i (1:10) print the results of i *2

## More complicated Example using F to C function.
for (i in -30:100){ # Read in #'s from -30 to 100
  result <- F_to_C(i) # Run F to C function for i
  print(result) # Print the results
}

## Adding results of For Loop to Dataframe
celcius.df <- NULL # Make an empty dataframe
for (i in -30:100){   # run F to C function
  result_i <- data.frame(F_to_C(i), i)   # Add results to temp Dataframe
  celcius.df <- rbind.data.frame(celcius.df, result_i) # Combine empty and temp dataframes
}

### More Complicated but real Example

# Read in the data
EC50.data <- read.csv("Raw_Data_for_Class_Exercises/EC50_all.csv")

# Example of Calculating Ec50 for a single isolate
isolate1 <- drm(100 * EC50.data$relgrowth[EC50.data$is == "ILSO_5-41c"] ~ 
                  EC50.data$conc[EC50.data$is == "ILSO_5-41c"], 
                fct = LL.4(fixed = c(NA, NA, NA, NA), 
                           names = c("Slope", "Lower", "Upper", "EC50")), 
                na.action = na.omit)
# outputs the summary of the paramters including the estimate, standard
# error, t-value, and p-value outputs it into a data frame called
# summary.mef.fit for 'summary of fit'
summary.fit <- data.frame(summary(isolate1)[[3]])
# outputs the summary of just the EC50 data including the estimate, standard
# error, upper and lower bounds of the 95% confidence intervals around the
# EC50
EC50 <- ED(isolate1, respLev = c(50), type = "relative", 
           interval = "delta")[[1]]

## Variation in Loops

# Create a vector of names for Loop
nm <- unique(EC50.data$is)

# Read in Vector Names as Integars using seq_along()
for (i in seq_along(nm)) {
  isolate1 <- drm(100 * EC50.data$relgrowth[EC50.data$is == nm[[i]]] ~ 
                    EC50.data$conc[EC50.data$is == nm[[i]]], 
                  fct = LL.4(fixed = c(NA, NA, NA, NA), 
                             names = c("Slope", "Lower", "Upper", "EC50")), 
                  na.action = na.omit)
  # outputs the summary of the paramters including the estimate, standard
  # error, t-value, and p-value outputs it into a data frame called
  # summary.mef.fit for 'summary of fit'
  summary.fit <- data.frame(summary(isolate1)[[3]])
  # outputs the summary of just the EC50 data including the estimate, standard
  # error, upper and lower bounds of the 95% confidence intervals around the
  # EC50
  EC50 <- ED(isolate1, respLev = c(50), type = "relative", 
             interval = "delta")[[1]]
  EC50
}

# Save to a dataframe
EC50.ll4 <- NULL # create a null object 
for (i in seq_along(nm)) {
  isolate1 <- drm(100 * EC50.data$relgrowth[EC50.data$is == nm[[i]]] ~ 
                    EC50.data$conc[EC50.data$is == nm[[i]]], 
                  fct = LL.4(fixed = c(NA, NA, NA, NA), 
                             names = c("Slope", "Lower", "Upper", "EC50")), 
                  na.action = na.omit)
  # outputs the summary of the paramters including the estimate, standard
  # error, t-value, and p-value outputs it into a data frame called
  # summary.mef.fit for 'summary of fit'
  summary.fit <- data.frame(summary(isolate1)[[3]])
  # outputs the summary of just the EC50 data including the estimate, standard
  # error, upper and lower bounds of the 95% confidence intervals around the
  # EC50
  EC50 <- ED(isolate1, respLev = c(50), type = "relative", 
             interval = "delta")[[1]]
  EC50
  isolate.ec_i <- data.frame(nm[[i]], EC50) # create a one row dataframe containing just the isolate name and the EC50
  colnames(isolate.ec_i) <- c("Isolate", "EC50") # change the column names
  
  # Then we need to append our one row dataframe to our null dataframe we created before
  # and save it as EC50.ll4. 
  EC50.ll4 <- rbind.data.frame(EC50.ll4, isolate.ec_i)
}

# Plot EC50 Values using ggplot2
ggplot(EC50.ll4, aes(x = EC50)) + geom_histogram() + theme_classic()

## Same Loop but using map in tidyverse
EC50.data %>%
  group_by(is) %>% # Set the grouping variable
  nest() %>% # Collapse data into a coloumn
  mutate(ll.4.mod = map(data, ~drm(.$relgrowth ~ .$conc, # Create a new column = to results of drm
                                   fct = LL.4(fixed = c(NA, NA, NA, NA), 
                                              names = c("Slope", "Lower", "Upper", "EC50"))))) %>%
  mutate(ec50 = map(ll.4.mod, ~ED(., # Estimate EC50
                                  respLev = c(50), 
                                  type = "relative",
                                  interval = "delta")[[1]])) %>%
  unnest(ec50) # Extract the value from the nesting.