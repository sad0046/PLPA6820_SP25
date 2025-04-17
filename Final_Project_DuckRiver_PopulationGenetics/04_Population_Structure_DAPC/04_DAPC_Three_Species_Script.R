library(adegenet)
library(ape)
library(poppr)
library(na.tools)
library(paletteer)

setwd("~/PLPA_6820_SP2025/Final_Project_DuckRiver_PopulationGenetics/04_Population_Structure_DAPC")

Lithasia.Lithasia.data <- read.genepop(file="Lithasia_R80_Min_Max_NBA_NoOut.populations.snps.gen")

Lithasia.Lithasia.data$pop
grp <- find.clusters(Lithasia.Lithasia.data, max.n.clust=30)

#500,8


dapc2 <- dapc(Lithasia.Lithasia.data,grp$grp)
#7,7

pdf("Elim_5pops2_DAPC.pdf")

cbbPalette <- c("#E69F00", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7","#56B4E9", "lightgreen","blue", "purple", "green", "pink", "grey","black" )

Ohiosubset <- read.csv("OhioRiver_Wabash_Names_TrueOld.csv")

Ohio <- Lithasia.Lithasia.data[i=c(Ohiosubset$Name)]

grp3 <- find.clusters(Ohio, max.n.clust = 30)

dap4 <- dapc(Ohio,grp3$grp)

gent <- read.csv("gentNames.csv")

gentsubset <- Lithasia.Lithasia.data[i=c(gent$Names)]

grp4 <- find.clusters(gentsubset, max.n.clust = 10)

dapc5 <- dapc(gentsubset,grp4$grp)

# Dots

scatter(dapc2, scree.da=FALSE, bg="white", pch=20, cell=0, 
        cstar=0, col=cbbPalette, solid=.4, cex=3,clab=0, leg=TRUE)

scatter.dapc(dapc2, ratio.pca=0.3,solid=0.4,cex=3,clab=0,cell=0,posi.da="topleft",
             bg="white",pch=20, cstar=0, col=cbbPalette, scree.pca=TRUE, 
             posi.pca="topright", legend = TRUE, posi.leg = "top",
             label.inds = list(air = 0.4, pch = 20))

scatter.dapc(dapc2, ratio.pca=0.3,solid=0.4,cex=3,clab=0,cell=0,posi.da="topleft",
             bg="white",pch=20, cstar=0, col=cbbPalette, scree.pca=TRUE, 
             posi.pca="topright", legend = FALSE, posi.leg = "top",
             label.inds = list(air = 0.4, pch = 20))

scatter.dapc(dap4, ratio.pca=0.3,solid=0.4,cex=3,clab=0,cell=0,posi.da="bottomleft",
             bg="white",pch=20, cstar=0, col=cbbPalette, scree.pca=TRUE, 
             posi.pca="bottomright",
             label.inds = list(air = 0.4, pch = 20))

scatter.dapc(dap4, ratio.pca=0.3,solid=0.4,cex=3,clab=0,cell=0,posi.da="bottomleft",
             bg="white",pch=20, cstar=0, col=cbbPalette, scree.pca=TRUE, 
             posi.pca="bottomright")

# Dots w Group Label

scatter(dapc2, ratio.pca=0.3,solid=0.4,cex=3,posi.da="centerright",
        bg="white",pch=20, cstar=0, col=cbbPalette, scree.pca=TRUE, posi.pca="bottomright",
        label.inds = TRUE)

scatter(dapc2, ratio.pca=0.3,solid=0.4,cex=3, scree.da=FALSE,
        bg="white",pch=20, cstar=0, col=cbbPalette,
        label.inds = TRUE)


# Admix Plot Subset

compoplot(dapc2, col=cbbPalette, show.lab = TRUE, posi="top",
          cex.names=0.8)

# Admix Plot Small Font All Samples

compoplot(dapc2, col=cbbPalette, show.lab = TRUE, posi="top",
          cex.names=0.5)

# Admix Plot No Individual Names

compoplot(dapc2, col=cbbPalette, show.lab = TRUE)

compoplot(dapc2, col=cbbPalette)

# Mountain Plot Thing

scatter(dapc2,1,1, col=cbbPalette, bg="white", scree.da=FALSE, legend=TRUE, solid=.4)

# Cluster ID Using Subsets

assignplot(dapc2)

assignplot(dapc2, subset = 201:250)

write.csv(grp[["grp"]], "DuckRiver_DAPC_k8.2.csv")

dev.off()




#Rename any .genepop to .gen to make packages happy
genepops<-list.files(pattern="*.genepop")
gens<-gsub(".genepop$",".gen", genepops)
file.rename(genepops,gens)


Lithasia.data <- read.genepop(file="Lithasia_Duck_R80_NBA_Multi_NoOut.snps.gen")

#Determine number of clusters
grp <- find.clusters(Lithasia.data, max.n.clust=5, n.pca = 250, n.clust = 2)

dapc <- dapc(Lithasia.data, grp$grp)
pdf("DAPC_clustered-by-population.pdf", width = 5, height = 5)
scatter.dapc(dapc,
             scree.da = TRUE,
             scree.pca = TRUE,
             posi.pca = "bottomright", 
             posi.da = "top", 
             cstar = 0,
             clab = 0,
             cell =0,
             col=c("#000000","#E69F00","#56B4E9","#009E73","#F0E442","#0072B2","#D55E00","#CC79A7","grey","darkblue","green"), 
             grp=Lithasia.data$pop,
             posi.leg="topright",
             leg=TRUE,
             
)
dev.off()

pdf("DAPC_plotted-by-cluster.pdf")
scatter.dapc(dapc,
             scree.da = TRUE,
             scree.pca = TRUE,
             posi.pca = "topright", 
             posi.da = "top", 
             cstar = 0,
             clab = 0,
             cell =0,
             col=c("#000000","#E69F00","#56B4E9","#009E73","#F0E442","#0072B2","#D55E00","#CC79A7","grey","darkblue","green"), 
             grp=grp$grp,
             posi.leg="bottomright",
             leg=TRUE,
             
)
dev.off()
