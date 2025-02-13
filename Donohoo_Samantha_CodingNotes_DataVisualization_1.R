### Sam Donohoo
### Date: 2/13/2025
### Notes for Coding Notes Data Visualization #1 - PLPA 6820

#### Data Visualization - Basic R ####

# Load in pre-defined data from R
data("mtcars")

# See the structure of the dataframe using str()
str(mtcars)

# Basic Scatter Plot
plot(x = mtcars$wt, y = mtcars$mpg)

# Modify Basic Scatter Plot
plot(x = mtcars$wt, y = mtcars$mpg,
     xlab = "Car Weight", # Add X-axis Label
     ylab = "Miles per gallon", # Add Y-axis Label
     font.lab = 6, # Change the Font
     pch = 20) # Change the shape of the Points

#### Data Visualization with GGPLOT2 ####

#install.packages("ggplot2")
library(ggplot2)

# Start a Plot using ggplot()
ggplot() # Makes an empty plot

# Define data using aesthetic mapping
ggplot(mtcars, aes(x = wt, y = mpg))

# ggplot2 has layers (INSERT SHRECK MEME HERE)
## Layers are called geoms. Wide variety.
### Two continous numerical variables
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() # Don't always need info in geom_point() parentheses

### Add a trendline using geom_smooth()
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() + 
  geom_smooth() # Plots points

### Modify trendline options to find best fitting linear relationship
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() + 
  geom_smooth(method = lm, se = FALSE) # lm = linear relationhip : se = Draw 95% CI

### Add Axis Labels
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_smooth(method = lm, se = FALSE) +
  geom_point() +
  xlab("Weight") + # X-axis Label
  ylab("Miles per gallon") # Y-axis Label

### Apply Scales to Point Size
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_smooth(method = lm, se = FALSE) +
  geom_point(aes(size = wt)) + # Points are sized based on Weight
  xlab("Weight") + 
  ylab("Miles per gallon")

### Apply Color Scale to Points
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_smooth(method = lm, se = FALSE) +
  geom_point(aes(color = wt)) +
  xlab("Weight") + 
  ylab("Miles per gallon") +
  scale_colour_gradient(low = "forestgreen", high = "black")

# Visualizing Categorical + Numeric
## Useful for ANOVA or Showing + Comparing Distrubtions

### Read in Data
bull.richness <- read.csv("Bull_richness.csv")

### Subset Soybean Data
bull.richness.soy.no.till <- bull.richness[bull.richness$Crop == "Soy" & 
                                             bull.richness$Treatment == "No-till",]

### Boxplots using geom_boxplot()
ggplot(bull.richness.soy.no.till, aes(x = GrowthStage, y = richness, color = Fungicide)) + 
  geom_boxplot()

### Add Axis Labels
ggplot(bull.richness.soy.no.till, aes(x = GrowthStage, y = richness, color = Fungicide)) + 
  geom_boxplot() + 
  xlab("") + 
  ylab("Bulleribasidiaceae richness") 

### Add Points to show Distrubtion of Data
ggplot(bull.richness.soy.no.till, aes(x = GrowthStage, y = richness, color = Fungicide)) + 
  geom_boxplot() + 
  xlab("") + 
  ylab("Bulleribasidiaceae richness") +
  geom_point() # Places the points in a linear line

### Use dodge to move points off of linear line
### use jitter to prevent point overlap
ggplot(bull.richness.soy.no.till, aes(x = GrowthStage, y = richness, color = Fungicide)) + 
  geom_boxplot() + 
  xlab("") + 
  ylab("Bulleribasidiaceae richness") +
  geom_point(position=position_jitterdodge(dodge.width=0.9))
# Position moves the data points over the box plots

### Barcharts + Standard Error

### Summary Stats can be Calculated using stat_summary()
ggplot(bull.richness.soy.no.till, aes(x = GrowthStage, y = richness, color = Fungicide)) + 
  stat_summary(fun=mean,geom="bar") + # Adds in boxes indicating stat i.e. Mean
  stat_summary(fun.data = mean_se, geom = "errorbar") + # Adds in SE bars
  xlab("") + 
  ylab("Bulleribasidiaceae richness") +
  geom_point(position=position_jitterdodge(dodge.width=0.9)) 
# Kind of ugly

### Remove Points and Dodge the Bars
ggplot(bull.richness.soy.no.till, aes(x = GrowthStage, y = richness, color = Fungicide)) + 
  stat_summary(fun=mean,geom="bar", position = "dodge") +
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge") + 
  xlab("") + 
  ylab("Bulleribasidiaceae richness")

### Color the Boxes using fill arguement
ggplot(bull.richness.soy.no.till, aes(x = GrowthStage, y = richness, color = Fungicide, fill = Fungicide)) + 
  stat_summary(fun=mean,geom="bar", position = "dodge") +
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge") + 
  xlab("") + 
  ylab("Bulleribasidiaceae richness")

### Lines Connecting Means

### Connect Time Series with a Line
ggplot(bull.richness.soy.no.till, aes(x = GrowthStage, y = richness, group = Fungicide, color = Fungicide)) + 
  stat_summary(fun=mean,geom="line") + # Shape is changed from Box to Line
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.5) +
  ylab("Bulleribasidiaceae \n richness") + # \n seperates into multiple lines
  xlab("") 

### Faceting - Allows for Seperate Plots
### Use facet_wrap() to account for other variables. Uses ~ sign.
ggplot(bull.richness, aes(x = GrowthStage, y = richness, group = Fungicide, color = Fungicide)) + 
  stat_summary(fun=mean,geom="line") +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.5) +
  ylab("Bulleribasidiaceae \n richness") + 
  xlab("") +
  facet_wrap(~Treatment)
# Successfully Splits by Treatment, but Combines Crop Type

### Seperate by more than one Variable i.e. Treatment AND Crop
ggplot(bull.richness, aes(x = GrowthStage, y = richness, group = Fungicide, color = Fungicide)) + 
  stat_summary(fun=mean,geom="line") +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.5) +
  ylab("Bulleribasidiaceae \n richness") + 
  xlab("") +
  facet_wrap(~Treatment*Crop)
# Successfully Splits by Treatment AND Crop, but lists all Growth Stages

### Correct using scales
ggplot(bull.richness, aes(x = GrowthStage, y = richness, group = Fungicide, color = Fungicide)) + 
  stat_summary(fun=mean,geom="line") +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.5) +
  ylab("Bulleribasidiaceae \n richness") + 
  xlab("") +
  facet_wrap(~Treatment*Crop, scales = "free")

### Reorder Facets
ggplot(bull.richness, aes(x = GrowthStage, y = richness, group = Fungicide, color = Fungicide)) + 
  stat_summary(fun=mean,geom="line") +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.5) +
  ylab("Bulleribasidiaceae \n richness") + 
  xlab("") +
  facet_wrap(~Crop*Treatment, scales = "free")
