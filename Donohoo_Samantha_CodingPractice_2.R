### Sam Donohoo
### Date: 2/13/2025
### Notes for Coding Challenge #2 Data Visualization - PLPA 6820

######## Question 2 #########

# Load in Libraries
library(ggplot2)

# Load in Data
myco <- read.csv("MycotoxinData.csv", header = TRUE, na.strings = "na")

# Empty ggplot
ggplot()

# Plot DON as the y variable.
# Treatment as the x variable.
# Color mapped to the wheat cultivar.
# Change the y label to “DON (ppm)”.
# Make the x label blank.

ggplot(myco, aes(x = Treatment, y = DON, color = Cultivar, fill = Cultivar)) +
  geom_boxplot() +
  ylab("DON (ppm)") +
  xlab("")

####### Question 3 #######

# Convert into a Bar Chart
# Add Standard Error Bars

ggplot(myco, aes(x = Treatment, y = DON, color = Cultivar, fill = Cultivar)) +
  stat_summary(fun=mean,geom="bar") +
  stat_summary(fun.data = mean_se, geom = "errorbar") +
  ylab("DON (ppm)") +
  xlab("")

###### Question 4 ######

# Add points to the foreground of the boxplot and bar chart.
# Set the shape = 21
# Outline color black (hint: use jitter_dodge). 

ggplot(myco, aes(x = Treatment, y = DON, color = Cultivar, fill = Cultivar)) +
  stat_summary(fun=mean,geom="bar", position = "dodge") +
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge") +
  ylab("DON (ppm)") +
  xlab("") +
  geom_point(aes(fill=Cultivar), pch=21, color = "black", 
             position=position_jitterdodge(dodge.width=0.9))

##### Question 5 #####

# Change the fill color of the points and boxplots.

cbbPalette <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#000000")

ggplot(myco, aes(x = Treatment, y = DON, color = Cultivar, fill = Cultivar)) +
  stat_summary(fun=mean,geom="bar", position = "dodge") +
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge") +
  ylab("DON (ppm)") +
  xlab("") +
  geom_point(aes(fill=Cultivar), pch=21, color = "black", 
             position=position_jitterdodge(dodge.width=0.9)) +
  scale_color_manual(values = cbbPalette) +
  scale_fill_manual(values = cbbPalette)

# Changed fill color using scale_color_manual and scale_fill_manual

##### Question 6 #####

# Add a facet to the plots based on cultivar.

ggplot(myco, aes(x = Treatment, y = DON, color = Cultivar, fill = Cultivar)) +
  stat_summary(fun=mean,geom="bar", position = "dodge") +
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge") +
  ylab("DON (ppm)") +
  xlab("") +
  geom_point(aes(fill=Cultivar), pch=21, color = "black", 
             position=position_jitterdodge(dodge.width=0.9)) +
  scale_color_manual(values = cbbPalette) +
  scale_fill_manual(values = cbbPalette) +
  facet_wrap(~Cultivar)

# Added a facet using facet_wrap()

##### Question 7 #####

# Add transparency to the points so you can still see the boxplot or bar in the background. 

ggplot(myco, aes(x = Treatment, y = DON, color = Cultivar, fill = Cultivar)) +
  stat_summary(fun=mean,geom="bar", position = "dodge") +
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge") +
  ylab("DON (ppm)") +
  xlab("") +
  geom_point(aes(fill=Cultivar), pch=21, color = "black", 
             position=position_jitterdodge(dodge.width=0.9), alpha = 0.4) +
  scale_color_manual(values = cbbPalette) +
  scale_fill_manual(values = cbbPalette) +
  facet_wrap(~Cultivar)

# Added transparency using alpha in the geom_point

##### Question 8 ######

# Explore one other way to represent the same data.

ggplot(myco, aes(x = Treatment, y = DON, color = Cultivar, fill = Cultivar)) +
  geom_violin(width=1.5, size=4) +
  coord_flip() + # This switch X and Y axis and allows to get the horizontal version
  ylab("DON (ppm)") +
  xlab("") +
  scale_color_manual(values = cbbPalette) +
  scale_fill_manual(values = cbbPalette) +
  facet_wrap(~Cultivar)

##### Question #####

# Kylie : Email: kzb0180@auburn.edu
