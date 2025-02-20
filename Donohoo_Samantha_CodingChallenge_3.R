### Sam Donohoo
### Date: 2/20/2025
### Coding Challenge Data Visualization #2 - PLPA 6820

# Load in Libraries
library(tidyverse)
library(ggpubr)
library(ggrepel)

# Make a color-blind friendly palette
cbbPalette <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#000000")

# Load in Data
myco <- read.csv("MycotoxinData.csv", header = TRUE, na.strings = "na")

# View Dataframe and Variable Information
str(myco)

##### Question 1 #####

# a.) Jitter points over the boxplot
# a.) Fill the points and boxplots Cultivar with two colors from the cbbPallete. 

myco.don.Q1 <- ggplot(myco, aes(x = Treatment, y = DON, color = Cultivar, fill = Cultivar)) +
  geom_boxplot(outlier.shape = NA, color = "black") +
  geom_point(aes(fill=Cultivar), pch=21, color = "black", 
             position=position_jitterdodge(dodge.width=0.85)) + 
  scale_color_manual(values = cbbPalette) +
  scale_fill_manual(values = cbbPalette)

myco.don.Q1

# b.) Change the transparency of the jittered points to 0.6. 

myco.don.Q1 <- ggplot(myco, aes(x = Treatment, y = DON, color = Cultivar, fill = Cultivar)) +
  geom_boxplot(outlier.shape = NA, color = "black") +
  geom_point(aes(fill=Cultivar), pch=21, color = "black", 
             position=position_jitterdodge(dodge.width=0.85), alpha = 0.6) + 
  scale_color_manual(values = cbbPalette) +
  scale_fill_manual(values = cbbPalette)

myco.don.Q1

# c.) The y-axis should be labeled "DON (ppm)", and the x-axis should be left blank. 

myco.don.Q1 <- ggplot(myco, aes(x = Treatment, y = DON, color = Cultivar, fill = Cultivar)) +
  geom_boxplot(outlier.shape = NA, color = "black") +
  geom_point(aes(fill=Cultivar), pch=21, color = "black", 
             position=position_jitterdodge(dodge.width=0.85), alpha = 0.6) + 
  scale_color_manual(values = cbbPalette) +
  scale_fill_manual(values = cbbPalette) + 
  ylab("DON (ppm)") +
  xlab("")

myco.don.Q1

# d.) The plot should use a classic theme

myco.don.Q1 <- ggplot(myco, aes(x = Treatment, y = DON, color = Cultivar, fill = Cultivar)) +
  geom_boxplot(outlier.shape = NA, color = "black") +
  geom_point(aes(fill=Cultivar), pch=21, color = "black", 
             position=position_jitterdodge(dodge.width=0.85), alpha = 0.6) + 
  scale_color_manual(values = cbbPalette) +
  scale_fill_manual(values = cbbPalette) + 
  ylab("DON (ppm)") +
  xlab("") +
  theme_classic()

myco.don.Q1

# e.) The plot should also be faceted by Cultivar

myco.don.Q1 <- ggplot(myco, aes(x = Treatment, y = DON, color = Cultivar, fill = Cultivar)) +
  geom_boxplot(outlier.shape = NA, color = "black") +
  geom_point(aes(fill=Cultivar), pch=21, color = "black", 
             position=position_jitterdodge(dodge.width=0.85), alpha = 0.6) + 
  scale_color_manual(values = cbbPalette) +
  scale_fill_manual(values = cbbPalette) + 
  ylab("DON (ppm)") +
  xlab("") +
  theme_classic() +
  facet_wrap(~Cultivar)

myco.don.Q1

##### Question 2 #####

# Change the factor order level.
# Treatment “NTC” is first, followed by “Fg”, “Fg + 37”, “Fg + 40”, and “Fg + 70"
# R Orders Based on Alphabet. To Reorder use Levels

myco$Treatment <- factor(myco$Treatment, levels = c("NTC", "Fg", "Fg + 37", "Fg + 40", "Fg + 70"))

myco.don.Q2 <- ggplot(myco, aes(x = Treatment, y = DON, color = Cultivar, fill = Cultivar)) +
  geom_boxplot(outlier.shape = NA, color = "black") +
  geom_point(aes(fill=Cultivar), pch=21, color = "black", 
             position=position_jitterdodge(dodge.width=0.85), alpha = 0.6) + 
  scale_color_manual(values = cbbPalette) +
  scale_fill_manual(values = cbbPalette) + 
  ylab("DON (ppm)") +
  xlab("") +
  theme_classic() +
  facet_wrap(~Cultivar)

myco.don.Q2

#### Question 3 ####
# Change the y-variable to plot X15ADON
# The y-axis label should now be “15ADON”

myco.don.Q3.1 <- ggplot(myco, aes(x = Treatment, y = X15ADON, color = Cultivar, fill = Cultivar)) +
  geom_boxplot(outlier.shape = NA, color = "black") +
  geom_point(aes(fill=Cultivar), pch=21, color = "black", 
             position=position_jitterdodge(dodge.width=0.85), alpha = 0.6) + 
  scale_color_manual(values = cbbPalette) +
  scale_fill_manual(values = cbbPalette) + 
  ylab("15ADON (ppm)") +
  xlab("") +
  theme_classic() +
  facet_wrap(~Cultivar)

myco.don.Q3.1

# Change the y-variable to plot MassperSeed_mg
# The y-axis label should now be “Seed Mass (mg)”

myco.don.Q3.2 <- ggplot(myco, aes(x = Treatment, y = MassperSeed_mg, color = Cultivar, fill = Cultivar)) +
  geom_boxplot(outlier.shape = NA, color = "black") +
  geom_point(aes(fill=Cultivar), pch=21, color = "black", 
             position=position_jitterdodge(dodge.width=0.85), alpha = 0.6) + 
  scale_color_manual(values = cbbPalette) +
  scale_fill_manual(values = cbbPalette) + 
  ylab("Seed Mass (mg)") +
  xlab("") +
  theme_classic() +
  facet_wrap(~Cultivar)

myco.don.Q3.2

##### Question 4 #####
# Use ggarrange function to combine all three figures into one with three columns and one row
# Set the labels for the subplots as A, B and C

# Rerun Question 1 so that the order is the same between all three plots
# NOT REQUIRED BUT IT WAS STRESSING ME OUT

myco.don.Q1 <- ggplot(myco, aes(x = Treatment, y = DON, color = Cultivar, fill = Cultivar)) +
  geom_boxplot(outlier.shape = NA, color = "black") +
  geom_point(aes(fill=Cultivar), pch=21, color = "black", 
             position=position_jitterdodge(dodge.width=0.85), alpha = 0.6) + 
  scale_color_manual(values = cbbPalette) +
  scale_fill_manual(values = cbbPalette) + 
  ylab("DON (ppm)") +
  xlab("") +
  theme_classic() +
  facet_wrap(~Cultivar)

myco.don.Q1

# Arrange multiple ggplot objects into a single figure
myco.don.FinalFigure <- ggarrange(
  myco.don.Q1,  # First plot: Q1
  myco.don.Q3.1,  # Second plot: Q3.1
  myco.don.Q3.2,  # Third plot: Q3.2
  labels = "AUTO",  # Automatically label the plots (A, B, C, etc.)
  nrow = 1,  # Arrange the plots in 3 rows
  ncol = 3,  # Arrange the plots in 1 column
  legend = FALSE  # Do not include a legend in the combined figure
)

myco.don.FinalFigure

##### Question 5 #####
# Use geom_pwc() to add t.test pairwise comparisons to the three plots made above
# Save each plot as a new R object
# Combine them again with ggarange as you did in question 4

# Question 1 + Ttest
myco.don.Q1.Ttest <- myco.don.Q1 + 
  geom_pwc(aes(group = Treatment), method = "t_test", label = "{p.adj.signif}")

myco.don.Q1.Ttest

# Question 3 - 15ADON + Ttest
myco.don.Q3.1.Ttest <- myco.don.Q3.1 + 
  geom_pwc(aes(group = Treatment), method = "t_test", label = "{p.adj.signif}")

myco.don.Q3.1.Ttest

# Question 3 - MassperSeed_mg + Ttest

myco.don.Q3.2.Ttest <- myco.don.Q3.2 + 
  geom_pwc(aes(group = Treatment), method = "t_test", label = "{p.adj.signif}")

myco.don.Q3.2.Ttest

# Arrange multiple ggplot objects into a single figure
myco.don.Ttest <- ggarrange(
  myco.don.Q1.Ttest,  # First plot: Q1 Ttest
  myco.don.Q3.1.Ttest,  # Second plot: Q3.1 Ttest
  myco.don.Q3.2.Ttest,  # Third plot: Q3.2 Ttest
  labels = "AUTO",  # Automatically label the plots (A, B, C, etc.)
  nrow = 1,  # Arrange the plots in 3 rows
  ncol = 3,  # Arrange the plots in 1 column
  legend = FALSE  # Do not include a legend in the combined figure
)

myco.don.Ttest
