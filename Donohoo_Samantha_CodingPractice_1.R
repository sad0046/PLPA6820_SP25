### Sam Donohoo
### Date: 2/6/2025
#### Coding Challenge #1 ####

# Create a vector named 'z' with the values 1 to 200

z <- 1:200

# Print the mean and standard deviation of z on the console

mean(z)
sd(z)

# Create a logical vector named zlog that is 'TRUE' for z values greater than 30 and 'FALSE' otherwise.

zlog <- (z > 30) > (z < 30)

# Make a dataframe with z and zlog as columns. Name the dataframe zdf

zdf <- data.frame(z, zlog)

# Change the column names in your new dataframe to equal “zvec” and “zlogic”

colnames(zdf) <- c("zvec", "zlogic")

# Make a new column in your dataframe equal to zvec squared (i.e., z2). Call the new column zsquare. 

zdf$zsquare <- (zdf$zvec)^2

# Subset the dataframe with and without the subset() function to 
# only include values of zsquare greater than 10 and less than 100

zdf_nosubsetcommand <- zdf[zdf$zsquare > 10 & zdf$zsquare < 100,]

zdf_subset <- subset(zdf, (zdf$zsquare > 10) & (zdf$zsquare < 100))

# Subset the zdf dataframe to only include the values on row 26

zdf_Row26 <- zdf[26,]

# Subset the zdf dataframe to only include the values in the column zsquare in the 180th row.

zdf_Row180_zsquare <- zdf[180,3]

# Annotate your code, commit the changes and push it to your GitHub

# Read in the data into R so that the missing values are properly coded.

Tips_Data <- read.csv("TipsR.csv", header = TRUE, sep = ",", na.strings = ".")
