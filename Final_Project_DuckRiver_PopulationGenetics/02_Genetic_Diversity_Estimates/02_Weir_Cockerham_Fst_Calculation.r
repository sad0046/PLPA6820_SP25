library(vegan)
library(hierfstat)
library(ggplot2)
library(ecodist)
library(adegenet)
rm(list=ls())
setwd("~/students/Donohoo/3RAD_lab-work/")


##Generate Pairwise Fst

#Note: this was done with the multiple SNP per dataset haps file, which I think is the most robust way to calculate Fst.
genepops<-list.files(pattern="*.genepop")
gens<-gsub(".genepop$",".gen", genepops)
file.rename(genepops,gens)

####Uncomment if you want to calculate Weir and Cockerham Fst and use that.
dat<-read.genepop("Elimia_R80_maf025_Multi.haps.gen")##Read in Genepop
data2<-genind2hierfstat(dat)
data2$pop #Sanity check to make sure populations are accurately defined.
WC<-pairwise.WCfst(data2,diploid = TRUE)
WC[is.na(WC)]<-0
write.table(WC,file="WC_FST.csv",row.names=TRUE, col.names = NA, sep = ",")
WC<-as.dist(WC)
WC