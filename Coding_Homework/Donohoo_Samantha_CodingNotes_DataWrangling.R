### Sam Donohoo
### Date: 3/16/2025
### Notes for Coding Homework Data Wrangling - PLPA 6820

##### Tidyverse #####

library(tidyverse)

# Load data from ggplot projects

microbiome.fungi <- read.csv("../Raw_Data_for_Class_Exercises/Bull_richness.csv")
str(microbiome.fungi)

# Using select() to chose specific columns
## To select columns in order and next to one another use a :
microbiome.fungi2 <- select(microbiome.fungi, SampleID, Crop, Compartment:Fungicide, richness)
str(microbiome.fungi2)

# Filter can be used to subset
## head() is used to view first few rows of a dataframe
head(filter(microbiome.fungi2, Treatment == "Conv."))

## A more complex filter using &
head(filter(microbiome.fungi2, Treatment == "Conv." & Fungicide == "C"))

## Another more complex filter example using or |
head(filter(microbiome.fungi2, Sample == "A" | Sample == "B")) # samples A or B

# Mutate can be used to add columns

## Standard way in R
microbiome.fungi2$logRich <- log(microbiome.fungi2$richness)

## Create a new column called logRich
head(mutate(microbiome.fungi2, logRich = log(richness)))

## Creating a new column which combines Crop and Treatment
head(mutate(microbiome.fungi2, Crop_Treatment = paste(Crop, Treatment)))

# %>% or Pipe can combine multiple functions together
## Using everything previously taught
### Before Data Subsetting
select(microbiome.fungi, SampleID, Crop, Compartment:Fungicide, richness) # before

### After Data Subsetting + Setting to a Dataframe
microbiome.fungi3 <- microbiome.fungi %>%
  select(SampleID, Crop, Compartment:Fungicide, richness) %>% # selecting columns
  filter(Treatment == "Conv.") %>% # subsetting to only include the conventional treatment
  mutate(logRich = log(richness)) %>% # creating a new column of the log richness
  head() # displaying the first six rows

# summarise() to calculate means, SD, and SE
## Calculate the Mean Richness
microbiome.fungi %>%
  select(SampleID, Crop, Compartment:Fungicide, richness) %>% # selecting columns
  filter(Treatment == "Conv.") %>% # subsetting to only include the conventional treatment
  mutate(logRich = log(richness)) %>% # creating a new column of the log richness
  summarise(Mean.rich = mean(logRich)) # calculating overall mean log richness within the conventional
## Mean.rich = 2.304395

## Calculate Mean, SD, and SE of Richness
microbiome.fungi %>%
  select(SampleID, Crop, Compartment:Fungicide, richness) %>% # selecting columns
  filter(Treatment == "Conv.") %>% # subsetting to only include the conventional treatment
  mutate(logRich = log(richness)) %>% # creating a new column of the log richness
  summarise(Mean.rich = mean(logRich), # calculating the mean richness, stdeviation, and standard error
            n = n(),
            sd.dev = sd(logRich)) %>%
  mutate(std.err = sd.dev/sqrt(n))

## Summary Stats by Group
microbiome.fungi %>%
  select(SampleID, Crop, Compartment:Fungicide, richness) %>% # selecting columns
  group_by(Treatment, Fungicide) %>% # grouping by treatment and fungicide to later calculate summary stats
  mutate(logRich = log(richness)) %>% # creating a new column of the log richness
  summarise(Mean.rich = mean(logRich), # calculating the mean richness, stdeviation, and standard error
            n = n(),
            sd.dev = sd(logRich)) %>%
  mutate(std.err = sd.dev/sqrt(n))

# tidyverse + ggplot
plot1 <- microbiome.fungi %>%
  select(SampleID, Crop, Compartment:Fungicide, richness) %>% # selecting columns
  group_by(Treatment, Fungicide) %>% # grouping by treatment and fungicide to later calculate summary stats
  mutate(logRich = log(richness)) %>% # creating a new column of the log richness
  summarise(Mean.rich = mean(logRich), # calculating the mean richness, stdeviation, and standard error
            n = n(),
            sd.dev = sd(logRich)) %>%
  mutate(std.err = sd.dev/sqrt(n)) %>%
  ggplot(aes(x = Fungicide, y = Mean.rich)) + # adding in a ggplot
  geom_bar(stat="identity") +
  geom_errorbar( aes(x=Fungicide, ymin=Mean.rich-std.err, ymax=Mean.rich+std.err), width=0.4) +
  theme_minimal() +
  xlab("") +
  ylab("Log Richness") +
  facet_wrap(~Treatment)

## View Plot 1
plot1

# Joining - Used to combine data from different dataframes
## left_join() Keep X Rows Add Y Rows
## right_join() Keep Y Rows Add X Rows
## inner_join() Keep Common Rows in X AND Y
## full_join() Keep All Rows in X and Y

### selecting just the richness and sample ID
richness <- microbiome.fungi %>%
  select(SampleID, richness)
### selecting columns that don't include the richness
metadata <- microbiome.fungi %>%
  select(SampleID, Fungicide, Crop, Compartment, GrowthStage, Treatment, Rep, Sample)
head(metadata)
head(richness)

### Adding richness to the Metadata based on SampleID
head(left_join(metadata, richness, by = "SampleID"))

# Pivoting: Used to convert long to wide or wide to long data
## Long format
microbiome.fungi %>%
  select(SampleID, Crop, Compartment:Fungicide, richness) %>%
  group_by(Treatment, Fungicide) %>% # grouping by treatment and fungicide to later calculate summary stats
  summarise(Mean = mean(richness)) # calculates the mean per Treatment and Fungicide

## Convert to Wide Format
microbiome.fungi %>%
  select(SampleID, Crop, Compartment:Fungicide, richness) %>% # selecting columns
  group_by(Treatment, Fungicide) %>% # grouping by treatment and fungicide to later calculate summary stats
  summarise(Mean = mean(richness)) %>% # calculates the mean per Treatment and Fungicide
  pivot_wider(names_from = Fungicide, values_from = Mean) # pivot to wide format

# Calculate difference between means + graph using ggplot
plot2 <- microbiome.fungi %>%
  select(SampleID, Crop, Compartment:Fungicide, richness) %>% # selecting columns filter
  group_by(Treatment, Fungicide) %>% # grouping by treatment and fungicide to later calculate summary stats
  summarise(Mean = mean(richness)) %>% # calculates the mean per Treatment and Fungicide
  pivot_wider(names_from = Fungicide, values_from = Mean) %>% # pivot to wide format
  mutate(diff.fungicide = C - F) %>% # calculate the difference between the means.
  ggplot(aes(x = Treatment, y = diff.fungicide)) + # Plot it
  geom_col() +
  theme_minimal() +
  xlab("") +
  ylab("Difference in average species richness")

# View Plot2
plot2
