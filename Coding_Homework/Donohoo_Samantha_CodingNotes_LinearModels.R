### Sam Donohoo
### Date: 4/2/2025
### Notes for Coding Homework Linear Models - PLPA 6820

# Load Packages
library(tidyverse)
library(lme4)
#install.packages("emmeans")
library(emmeans)
library(multcomp)
#install.packages("multcompView")
library(multcompView)

##### Basic Linear Equations #####

# Linear Equation is y = mx + b
## m is the slope, x is the other variable, and b is the intercept
### As slope goes up, p-value goes down (good thing)

##### Continuous X and Y ######

# Load Data
data("mtcars")

# Visualize Data
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_smooth(method = lm, se = FALSE, color = "grey") +
  geom_point(aes(color = wt)) +
  xlab("Weight") + 
  ylab("Miles per gallon") +
  scale_colour_gradient(low = "forestgreen", high = "black") +
  theme_classic()
## Graph assumes a relationship, but confirm with stats.

# Easiest Linear Model
lm(mpg~wt, data = mtcars)
## Gives Slope Value

# Check p-value
summary(lm(mpg~wt, data = mtcars))
## R-squared is the variation in y explained by x.

# ANOVA
anova(lm(mpg~wt, data = mtcars))

# Correlation Test
cor.test(mtcars$wt, mtcars$mpg)

##### Assumptions #####

# 1.) y is continuous
# 2.) error is normally distributed 
# 3.) relationship is linear 
# 4.) homoskedasticity 
# 5.) sigma is consistent 
# 6.) independent samples

# Check for assumptions using residuals
model <- lm(mpg~wt, data = mtcars)

# Visualize
ggplot(model, aes(y = .resid, x = .fitted)) +
  geom_point() +
  geom_hline(yintercept = 0)

##### Categorical Variables #####

# Categorial x variable and a continuous y variable we would perform a t-test.

# Read Data
bull.rich <- read.csv("../Raw_Data_for_Class_Exercises/Bull_richness.csv")

# Filter our dataset to include one treatment and growth stage for demonstration of a t-test.
bull.rich %>%
  filter(GrowthStage == "V8" & Treatment == "Conv.") %>%
  ggplot(aes(x = Fungicide, y = richness)) + 
  geom_boxplot()

# T-test
bull.rich.sub <- bull.rich %>%
  filter(GrowthStage == "V8" & Treatment == "Conv.")

# T-test is similar to ANOVA or Regression
t.test(richness~Fungicide, data = bull.rich.sub)
t.test(richness~Fungicide, data = bull.rich.sub, var.equal = TRUE)
summary(lm(richness~Fungicide, data = bull.rich.sub))
anova(lm(richness~Fungicide, data = bull.rich.sub))

##### ANOVAs #####

# ANOVAs would have continuous y and multinomial categorical x. 
## In other words, more than two groups.

# Filter dataset for richness in different crop growth stages.
bull.rich.sub2 <- bull.rich %>%
  filter(Fungicide == "C" & Treatment == "Conv." & Crop == "Corn")

# Visualize
bull.rich.sub2$GrowthStage <- factor(bull.rich.sub2$GrowthStage, levels = c("V6", "V8", "V15"))
ggplot(bull.rich.sub2, aes(x = GrowthStage, y = richness)) +
  geom_boxplot()

# Run Linear Model
lm.growth <- lm(richness ~ GrowthStage, data = bull.rich.sub2)
summary(lm.growth)

# Run ANOVA
anova(lm.growth)

# Summary
summary(aov(richness ~ GrowthStage, data = bull.rich.sub2))

# Using Post-Hoc Tests
lsmeans <- emmeans(lm.growth, ~GrowthStage) # estimate lsmeans of variety within siteXyear
Results_lsmeans <- cld(lsmeans, alpha = 0.05, reversed = TRUE, details = TRUE) # contrast with Tukey ajustment by default. 
Results_lsmeans

##### Interaction Terms ######

# In our example, maybe we care about if the effect of fungicide depends on time.
# We can do this within a linear model as well using the * between factors.
# Lets filter our dataset to include fungicide term.

bull.rich.sub3 <- bull.rich %>%
  filter(Treatment == "Conv." & Crop == "Corn")

bull.rich.sub3$GrowthStage <- factor(bull.rich.sub3$GrowthStage, levels = c("V6", "V8", "V15"))

#Now lets set up our linear model with fungicide interaction factor

# Write it like this
lm.inter <- lm(richness ~ GrowthStage + Fungicide + GrowthStage:Fungicide, data = bull.rich.sub3)

# Alternatively like this
lm(richness ~ GrowthStage*Fungicide, data = bull.rich.sub3)

# Check for significant terms
summary(lm.inter) # significant terms

# Run an ANOVA
anova(lm.inter) # The interaction term is signifant. 
## Effect of fungicide is dependant on growth stage.

# Visualize
bull.rich.sub3 %>%
  ggplot(aes(x = GrowthStage, y = richness, fill = Fungicide)) +
  geom_boxplot()

# Run Post-Hoc
lsmeans <- emmeans(lm.inter, ~Fungicide|GrowthStage) # estimate lsmeans of variety within siteXyear
Results_lsmeans <- cld(lsmeans, alpha = 0.05, reversed = TRUE, details = TRUE) # contrast with Tukey ajustment
Results_lsmeans

##### Mixed Effect Models #####

# Mixed-effects models have fixed and random effects terms.
# The random effects term is something that affects the variation in y. 
# A fixed effect is something that affects the mean of y.
# Common fixed effects: Treatment, Species, Gene
# Common random effects (blocking factor): Year, Replicate, Trial, Individuals, Fields

# Prior Interaction Model
lme0 <- lm(richness ~ GrowthStage*Fungicide, data = bull.rich.sub3)

# Include Random Effect using lme4
lme1 <- lmer(richness ~ GrowthStage*Fungicide + (1|Rep), data = bull.rich.sub3)
summary(lme1)

# Compare with and without random effect
summary(lme0)
summary(lme1)