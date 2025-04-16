# Load Packages
library(LEA)
library(BiocManager)
library(ggplot2)
library(tidyverse)
library(ggpubr)
library(ggrepel)

# Load data from Single SNP VCF produced by Stacks
Dutt.input.file <- "Final_Project_PopulationGenetics/05_Population_Structure_Admixture/Duttoniana_min_max_NBA_Single.snps.vcf"
Gent.input.file <- "Final_Project_PopulationGenetics/05_Population_Structure_Admixture/Geniculata_min_max_NBA_Single.snps.vcf"
Ful.input.file <- "Final_Project_PopulationGenetics/05_Population_Structure_Admixture/Fuliginosa_min_max_NBA_Single.snps.vcf"

# Load in metadata for each Species
Dutt.Metadata <- read.csv("Final_Project_DuckRiver_PopulationGenetics/05_Population_Structure_Admixture/Duttoniana_Metadata.csv", header = TRUE, na.strings = "NA")
Gent.Metadata <- read.csv("Final_Project_DuckRiver_PopulationGenetics/05_Population_Structure_Admixture/Geniculata_Metadata.csv", header = TRUE, na.strings = "NA")
Ful.Metadata <- read.csv("Final_Project_DuckRiver_PopulationGenetics/05_Population_Structure_Admixture/Fuliginosa_Metadata.csv", header = TRUE, na.strings = "NA")
  
# Create a function that finds the best fit K-value for LEA Admixture Analysis.
Admixture.Lea.K.Find <- function(Input.File){
  Geno <- vcf2geno(Input.File, force = TRUE)
  obj.snmf_100 = snmf(Geno, K = 1:10, project = "new", alpha = 100, 
                      tolerance = 0.0000000001, repetitions = 10, 
                      entropy=TRUE, ploidy = 2)
  plot(obj.snmf_100, cex = 1.2, col = "blue", pch = 19)
}

# Create a function that generates the corresponding best-fit K-value qmatrix for graphing.
Admixture.Lea.K.qmatrix <- function(Input.File, Kvalue){
  Geno <- vcf2geno(Input.File, force = TRUE)
  obj.snmf_100 = snmf(Geno, K = Kvalue, project = "new", alpha = 100, 
                      tolerance = 0.0000000001, repetitions = 10, 
                      entropy=TRUE, ploidy = 2)
  ce <- cross.entropy(obj.snmf_100, K = Kvalue)
  best <- which.min(ce)
  qmatrix <- Q(obj.snmf_100, K = Kvalue, run = best)
}

##### LEA ADMIXTURE FOR LITHASIA DUTTONIANA #####

# Run LEA Admixture for Lithasia duttoniana in the Duck River, TN.
Dutt.find.Kvalue <- Admixture.Lea.K.Find(Dutt.input.file)

# Best fit K-value is 2.
Dutt.qmatrix.K2 <- Admixture.Lea.K.qmatrix(Dutt.input.file, 2)

# Convert Vector into DataFrame and Append to Metadata DataFrame
Dutt.qmatrix.K2 <- data.frame(Dutt.qmatrix.K2)
Dutt.Metadata$A <- Dutt.qmatrix.K2$V1
Dutt.Metadata$B <- Dutt.qmatrix.K2$V2

# Convert from Wide to Long Format
Dutt.Metadata.Long <- Dutt.Metadata %>% 
  pivot_longer(
    cols = `A`:`B`, 
    names_to = "Admixure",
    values_to = "Amount"
  )

# Convert the Column Site into a Factor to Allow for Faceting
Dutt.Metadata.Long$Site <- as.factor(Dutt.Metadata.Long$Site)

# Using Levels, Reorder Sites so They Run Downstream to UpStream
Dutt.Metadata.Long$Site <- factor(Dutt.Metadata.Long$Site, levels = c("Dyer",
                                                    "NV",
                                                    "CV",
                                                    "KM",
                                                    "B",
                                                    "IP",
                                                    "HWY412",
                                                    "R",
                                                    "IB",
                                                    "SP",
                                                    "FW",
                                                    "SM",
                                                    "CB",
                                                    "HM",
                                                    "HWY31",
                                                    "WB"
))

# Create a Color-Blind Friendly Palette
cbbPalette <- c("#56B4E9","#E69F00", "#0072B2", "#009E73", "#F0E442", "#D55E00", "#CC79A7")

# Graph the Admixture Results. Use Facet to Split into Sections by Site
Dutt.admixture <- ggplot(Dutt.Metadata.Long, aes(x = factor(Specimen), y = Amount, fill = Admixure)) +
  geom_col(width = 1) +
  # Facet over the groups
  facet_grid(~ Site, switch = "x", scales = "free", space = "free") +
  # Use these expand arguments to get rid of padding around the axes
  scale_x_discrete(expand = c(0,0), name = "Site") +
  scale_y_continuous(expand = c(0,0), name = "Admixture Coefficients") +
  scale_fill_manual(values = (cbbPalette), name = "") +
  # We're hiding most of the x-axis and the spacing between panels
  theme(panel.spacing.x = grid::unit(0.05, "cm"),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        strip.background = element_blank(),
        panel.border = element_rect(fill = NA, colour = "black"),
        legend.position="")

# View Admixture Graph
Dutt.admixture

##### LEA ADMIXTURE FOR LITHASIA GENICULATA #####

# Run LEA Admixture for Lithasia geniculata in the Duck River, TN.
Gent.find.Kvalue <- Admixture.Lea.K.Find(Gent.input.file)
Gent.find.Kvalue

# Best fit K-value is 5.
Gent.qmatrix.K5 <- Admixture.Lea.K.qmatrix(Gent.input.file, 5)

# Convert Vector into DataFrame and Append to Metadata DataFrame
Gent.qmatrix.K5 <- data.frame(Gent.qmatrix.K5)
Gent.Metadata$A <- Gent.qmatrix.K5$V1
Gent.Metadata$B <- Gent.qmatrix.K5$V2
Gent.Metadata$C <- Gent.qmatrix.K5$V3
Gent.Metadata$D <- Gent.qmatrix.K5$V4
Gent.Metadata$E <- Gent.qmatrix.K5$V5

# Convert from Wide to Long Format
Gent.Metadata.Long <- Gent.Metadata %>% 
  pivot_longer(
    cols = `A`:`E`, 
    names_to = "Admixure",
    values_to = "Amount"
  )

# Convert the Column Site into a Factor to Allow for Faceting
Gent.Metadata.Long$Site <- as.factor(Gent.Metadata.Long$Site)

# Using Levels, Reorder Sites so They Run Downstream to UpStream
Gent.Metadata.Long$Site <- factor(Gent.Metadata.Long$Site, levels = c("Dyer",
                                                                      "NV",
                                                                      "CV",
                                                                      "TB",
                                                                      "LL",
                                                                      "BL",
                                                                      "KM",
                                                                      "FM",
                                                                      "B",
                                                                      "CS",
                                                                      "IP",
                                                                      "R"
))

# Create a Color-Blind Friendly Palette
cbbPalette <- c("#56B4E9","#E69F00", "#009E73", "#F0E442", "#CC79A7", "#0072B2","#D55E00")

# Graph the Admixture Results. Use Facet to Split into Sections by Site
Gent.admixture <- ggplot(Gent.Metadata.Long, aes(x = factor(Specimen), y = Amount, fill = Admixure)) +
  geom_col(width = 1) +
  # Facet over the groups
  facet_grid(~ Site, switch = "x", scales = "free", space = "free") +
  # Use these expand arguments to get rid of padding around the axes
  scale_x_discrete(expand = c(0,0), name = "Site") +
  scale_y_continuous(expand = c(0,0), name = "Admixture Coefficients") +
  scale_fill_manual(values = (cbbPalette), name = "") +
  # We're hiding most of the x-axis and the spacing between panels
  theme(panel.spacing.x = grid::unit(0.05, "cm"),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        strip.background = element_blank(),
        panel.border = element_rect(fill = NA, colour = "black"))

# View Admixture Graph
Gent.admixture

##### LEA ADMIXTURE FOR LITHASIA FULIGINOSA #####

# Run LEA Admixture for Lithasia fuliginosa in the Duck River, TN.
Ful.find.Kvalue <- Admixture.Lea.K.Find(Ful.input.file)

# Best fit K-value is 6.
Ful.qmatrix.K6 <- Admixture.Lea.K.qmatrix(Ful.input.file, 6)

# Convert Vector into DataFrame and Append to Metadata DataFrame
Ful.qmatrix.K6 <- data.frame(Ful.qmatrix.K6)
Ful.Metadata$A <- Ful.qmatrix.K6$V1
Ful.Metadata$B <- Ful.qmatrix.K6$V2
Ful.Metadata$C <- Ful.qmatrix.K6$V3
Ful.Metadata$D <- Ful.qmatrix.K6$V4
Ful.Metadata$E <- Ful.qmatrix.K6$V5
Ful.Metadata$F <- Ful.qmatrix.K6$V6

# Convert from Wide to Long Format
Ful.Metadata.Long <- Ful.Metadata %>% 
  pivot_longer(
    cols = `A`:`F`, 
    names_to = "Admixure",
    values_to = "Amount"
  )

# Convert the Column Site into a Factor to Allow for Faceting
Ful.Metadata.Long$Site <- as.factor(Ful.Metadata.Long$Site)

# Using Levels, Reorder Sites so They Run Downstream to UpStream
Ful.Metadata.Long$Site <- factor(Ful.Metadata.Long$Site, levels = c("Dyer",
                                                                      "LL",
                                                                      "F",
                                                                      "SP",
                                                                      "FW",
                                                                      "SM",
                                                                      "CB",
                                                                      "HDM",
                                                                      "LM",
                                                                      "HWY31",
                                                                      "HM",
                                                                      "WB",
                                                                      "SR",
                                                                      "HWY231",
                                                                      "HWY41A",
                                                                      "TF",
                                                                    "HWY269",
                                                                    "PB"
))

# Create a Color-Blind Friendly Palette
cbbPalette <- c("#56B4E9","#E69F00", "#0072B2", "#009E73", "#F0E442", "#D55E00", "#CC79A7")

# Graph the Admixture Results. Use Facet to Split into Sections by Site
Ful.admixture <- ggplot(Ful.Metadata.Long, aes(x = factor(Specimen), y = Amount, fill = Admixure)) +
  geom_col(width = 1) +
  # Facet over the groups
  facet_grid(~ Site, switch = "x", scales = "free", space = "free") +
  # Use these expand arguments to get rid of padding around the axes
  scale_x_discrete(expand = c(0,0), name = "Site") +
  scale_y_continuous(expand = c(0,0), name = "Admixture Coefficients") +
  scale_fill_manual(values = (cbbPalette), name = "") +
  # We're hiding most of the x-axis and the spacing between panels
  theme(panel.spacing.x = grid::unit(0.05, "cm"),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        strip.background = element_blank(),
        panel.border = element_rect(fill = NA, colour = "black"),
        legend.position="")

# View Admixture Graph
Ful.admixture

##### Figures #####
# Cross-Entropy Graphs to Establish Best Fit K-Value
Figure1 <- ggarrange(
  Dutt.admixture,  # First plot: water.imbibed
  Gent.admixture,  # Second plot: bac.even
  Ful.admixture,  # Third plot: water.imbibed.cor
  labels = "auto",  # Automatically label the plots (A, B, C, etc.)
  nrow = 3,  # Arrange the plots in 3 rows
  ncol = 1,  # Arrange the plots in 1 column
  legend = FALSE  # Do not include a legend in the combined figure
)

# View
Figure1
