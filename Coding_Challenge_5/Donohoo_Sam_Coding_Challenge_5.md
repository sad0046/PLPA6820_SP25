# Github Link

Sam Donohoo - PLPA 6820 - <https://github.com/sad0046/PLPA6820_SP25>

### Question 1 - Adding Data

Download two .csv files from Canvas called DiversityData.csv and
Metadata.csv, and read them into R using relative file paths.

``` r
# Load in Libraries
library(tidyverse)

# Load in Metadata Data
metaData <- read.csv("Metadata.csv", header = TRUE, na.strings = "na")

# Load in Diversity Data
divData <- read.csv("DiversityData.csv", header = TRUE, na.strings = "na")
```

### Question 2 - Combining Data

Join the two dataframes together by the common column ‘Code’. Name the
resulting dataframe *alpha*.

``` r
# Join Dataframes Together
# Name Combined Dataframe alpha
alpha <- full_join(metaData, divData, by = "Code")

head(alpha) # Print First 6 Rows
```

    ##     Code Crop Time_Point Replicate Water_Imbibed  shannon invsimpson   simpson
    ## 1 S01_13 Soil          0         1            NA 6.624921   210.7279 0.9952545
    ## 2 S02_16 Soil          0         2            NA 6.612413   206.8666 0.9951660
    ## 3 S03_19 Soil          0         3            NA 6.660853   213.0184 0.9953056
    ## 4 S04_22 Soil          0         4            NA 6.660671   204.6908 0.9951146
    ## 5 S05_25 Soil          0         5            NA 6.610965   200.2552 0.9950064
    ## 6 S06_28 Soil          0         6            NA 6.650812   199.3211 0.9949830
    ##   richness
    ## 1     3319
    ## 2     3079
    ## 3     3935
    ## 4     3922
    ## 5     3196
    ## 6     3481

### Question 3 - Pielou’s Evenness Index

Calculate Pielou’s evenness index: Pielou’s evenness is an ecological
parameter calculated by the Shannon diversity index (column Shannon)
divided by the log of the richness column.

``` r
# Calculate Pielou's Evenness Index = Shannon / log(richness)
alpha_even <- alpha %>%
  mutate(logRich = log(richness)) %>% # creating a new column of the Log Richness
  mutate(even = shannon/logRich) # creating a new column of Pielou's Evenness

head(alpha_even) # Print First 6 Rows
```

    ##     Code Crop Time_Point Replicate Water_Imbibed  shannon invsimpson   simpson
    ## 1 S01_13 Soil          0         1            NA 6.624921   210.7279 0.9952545
    ## 2 S02_16 Soil          0         2            NA 6.612413   206.8666 0.9951660
    ## 3 S03_19 Soil          0         3            NA 6.660853   213.0184 0.9953056
    ## 4 S04_22 Soil          0         4            NA 6.660671   204.6908 0.9951146
    ## 5 S05_25 Soil          0         5            NA 6.610965   200.2552 0.9950064
    ## 6 S06_28 Soil          0         6            NA 6.650812   199.3211 0.9949830
    ##   richness  logRich      even
    ## 1     3319 8.107419 0.8171431
    ## 2     3079 8.032360 0.8232216
    ## 3     3935 8.277666 0.8046776
    ## 4     3922 8.274357 0.8049774
    ## 5     3196 8.069655 0.8192376
    ## 6     3481 8.155075 0.8155427

### Question 4 - Summarise

Using tidyverse language of functions and the pipe, use the summarise
function and tell me the mean and standard error evenness grouped by
crop over time.

``` r
# Using summarise() Calculate Mean and Standard Error Grouped by Crop Over Time
alpha_average <- alpha_even %>%
  group_by(Crop, Time_Point) %>% # Grouping by Crop and Time Point
  summarise(Mean.even = mean(even), # Calculating the Mean and Standard Error for Evenness
            n = n(),
            sd.dev = sd(even)) %>%
  mutate(std.err = sd.dev/sqrt(n))

alpha_average # Print Entire Table
```

    ## # A tibble: 12 × 6
    ## # Groups:   Crop [3]
    ##    Crop    Time_Point Mean.even     n  sd.dev std.err
    ##    <chr>        <int>     <dbl> <int>   <dbl>   <dbl>
    ##  1 Cotton           0     0.820     6 0.00556 0.00227
    ##  2 Cotton           6     0.805     6 0.00920 0.00376
    ##  3 Cotton          12     0.767     6 0.0157  0.00640
    ##  4 Cotton          18     0.755     5 0.0169  0.00755
    ##  5 Soil             0     0.814     6 0.00765 0.00312
    ##  6 Soil             6     0.810     6 0.00587 0.00240
    ##  7 Soil            12     0.798     6 0.00782 0.00319
    ##  8 Soil            18     0.800     5 0.0104  0.00465
    ##  9 Soybean          0     0.822     6 0.00270 0.00110
    ## 10 Soybean          6     0.764     6 0.0400  0.0163 
    ## 11 Soybean         12     0.687     6 0.0643  0.0263 
    ## 12 Soybean         18     0.716     6 0.0153  0.00626

### Question 5 - Differences

Calculate the difference between the soybean column, the soil column,
and the difference between the cotton column and the soil column.

``` r
# Calculate Difference Between Soybean+Soil and Cotton+Soil
alpha_average2 <- alpha_average %>%
  select(Time_Point, Crop, Mean.even) %>% # Selecting Columns
  pivot_wider(names_from = Crop, values_from = Mean.even) %>% # Pivot to Wide Format
  mutate(diff.cotton.even = Soil - Cotton) %>% # calculates the mean per Treatment and Fungicide
  mutate(diff.soybean.even = Soil - Soybean)

alpha_average2 # Print Entire Table
```

    ## # A tibble: 4 × 6
    ##   Time_Point Cotton  Soil Soybean diff.cotton.even diff.soybean.even
    ##        <int>  <dbl> <dbl>   <dbl>            <dbl>             <dbl>
    ## 1          0  0.820 0.814   0.822         -0.00602          -0.00740
    ## 2          6  0.805 0.810   0.764          0.00507           0.0459 
    ## 3         12  0.767 0.798   0.687          0.0313            0.112  
    ## 4         18  0.755 0.800   0.716          0.0449            0.0833

### Question 6 - Plotting

Connecting it to plots.

``` r
# Plot Differences using ggplot2
# Time_Point on the X, Value on the Y, Color Lines by Diff
alpha_average2_plot <- alpha_average2 %>%
  select(Time_Point, diff.cotton.even, diff.soybean.even) %>% # Selecting Columns
  pivot_longer(c(diff.cotton.even, diff.soybean.even), names_to = "diff") %>% # Pivot to Long Format
  ggplot(aes(x = Time_Point, y = value, color = diff)) + # Plot
  geom_line() +
  theme_classic() +
  xlab("Time (hrs)") +
  ylab("Difference from soil in Pielou's evenness")

alpha_average2_plot # Print Plot
```

![](Donohoo_Sam_Coding_Challenge_5_files/figure-gfm/Question%206-1.png)<!-- -->
