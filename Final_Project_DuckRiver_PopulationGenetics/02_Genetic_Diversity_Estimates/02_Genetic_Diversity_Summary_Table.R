library(adegenet)
library(hierfstat)
library(PopGenReport)
library(plotrix)
library(poppr)
library(tidyr)

####INTRODUCTION####
####This script is for making tables and figures from the STACKS 2.66 sumstats file. It includes
####what I think are the most relevant summary statistics output by stacks. The output table
####is pretty much ready to go for a publication...it's easier than copying and pasting from 
####the sumstats_summary file. If STACKS ever changes the number or order of columns in the sumstats
####file, this code will break. After calcualting what can be calculated directly from the sumstats files,
####the script calculates rarefied allelic richness from a genepop file. 

##The code also plots Fis values for data visualization and writes PDFs in the working directory


rm (list=ls())
setwd("~/Fish/AL-River_migratory-fish/white-crappie/white_crappie_m3M1n1_p4r7_mac3_multi/")

####Sumary Stats from Sumstats####
#Read in sumstats table
sumstats<-read.table("populations.sumstats.tsv", header=FALSE)
sumstats<-sumstats[!grepl("#",sumstats),] #Gets rid of the needless rows added by STACKS

#Split by population and keep in order of original popmap and what the populations output files are
sumstats$V5<-factor(sumstats$V5, levels=unique(sumstats$V5))
sumstats_list<-split(sumstats,sumstats$V5)

#calculate averages for each population
stats_table=data.frame()
for (i in sumstats_list){
  pop_data<-as.data.frame(i)
  pop<-pop_data[1,5]
  Ho<-round(mean(pop_data[,10]),digits=4)
  Ho_SE<-round(std.error(pop_data[,10]),digits=4)
  He<-round(mean(pop_data[,12]),digits=4)
  He_SE<-round(std.error(pop_data[,12]),digits=4)
  Pi<-round(mean(pop_data[,14]),digits=4)
  Pi_SE<-round(std.error(pop_data[,14]),digits=4)
  Fis<-round(mean(pop_data[,17]),digits=4)
  Fis_SE<-round(std.error(pop_data[,17]),digits=4)
  
  ##plot FIS values and write as pdf
  name_plot<-paste(pop,".FIS-plot.pdf",sep="")
  pdf(name_plot)
  plot(pop_data[,17], main = pop, xlab = "locus", ylab = "Fis")
  abline(h=Fis, col="red")
  dev.off()
  
  stats_table<-rbind(stats_table,list(pop,Ho,Ho_SE,He,He_SE,Pi,Pi_SE,Fis,Fis_SE))
}

#Assign Names to make things nice looking
names(stats_table)<-c("Population","Ho","Ho_SE","He","He_SE","Pi","Pi_SE","Fis","Fis_SE")
stats_table


####Allelic Richness calculations#####
##Rename genepop files output by STAKCS to have the .gen extension wanted by adegenet.
genepops<-list.files(pattern="*.genepop")
gens<-gsub(".genepop$",".gen", genepops)
file.rename(genepops,gens)
data<-read.genepop("populations.haps.gen")
Populations<-levels(data$pop)
##Sites Names will be based on first individual from that population in genepop file unless specified by assigning names to Ho_by_site

###Only run if you want AR rarefied by population
#AR_by_pop = data.frame()
#for (i in Populations) {
#  Subpop <- popsub(data, sublist = i)
#  richness<-allel.rich(Subpop, min.alleles=NULL)
#  ARnum <- round(mean(richness$all.richness),digits=3)
###Do NOT USE: SE doesn't make sense for rarefied calculations:  SEnum <- round(std.error(richness$all.richness),digits=4)
#  AR_by_pop <- rbind(AR_by_pop, list(i,ARnum,SEnum))
#}
#AR_by_pop

##Calculate rarefied allelic richnes. Rareify across dataset, not just population.
allelic_richness<-allel.rich(data,min.alleles=NULL)
allelic_richness$all.richness
AR<-round((allelic_richness$mean.richness),digits = 3)

#combine everything into nice table
Summary_stats_table<-cbind(stats_table,AR)

#Uncomment if you want rarefactin only by population or site (whatever factor is in your genepop)
#names(AR_by_pop)<-(c("pop", "AR_by_pop"))
#Summary_stats_table<-cbind(stats_table,AR[,2])

rownames(Summary_stats_table)<-NULL
Summary_stats_table
##You may want to change file name.
write.table(Summary_stats_table, file="white-crappie_summary-stats.txt", sep = "\t", row.names=FALSE)


library(diveRsity)

setwd("/path/to/your/files")

##READ in GENEPOP FILE. I used from Stacks
test_results<-divBasic(infile="Lcom_m5M3n2_r75p3_randomSNP.genepop",gp=2)
##Split out Allelic Richness, make into table.  NOTE: Could modify here (and later with variable name) to split out other statistics
test_results$Allelic_richness
alleicRichenes<-test_results$Allelic_richness
allelicRichness<-as.table(alleicRichenes)

##Data check. Note overall values.
allelicRichness
allelicRichness["overall",]

##seperate by population and remove loci that were not genotyped for that population (i.e., Allelic Richness of 0)
pop1_allelicR<-allelicRichness[,1]
pop1_allelicR<-as.data.frame(pop1_allelicR)
pop1_allelicR_zeroesRemoved<-pop1_allelicR[apply(pop1_allelicR!=0,1,all),]

pop2_allelicR<-allelicRichness[,2]
pop2_allelicR<-as.data.frame(pop2_allelicR)
pop2_allelicR_zeroesRemoved<-pop2_allelicR[apply(pop2_allelicR!=0,1,all),]

pop3_allelicR<-allelicRichness[,3]
pop3_allelicR<-as.data.frame(pop3_allelicR)
pop3_allelicR_zeroesRemoved<-pop3_allelicR[apply(pop3_allelicR!=0,1,all),]

pop4_allelicR<-allelicRichness[,4]
pop4_allelicR<-as.data.frame(pop4_allelicR)
pop4_allelicR_zeroesRemoved<-pop4_allelicR[apply(pop4_allelicR!=0,1,all),]

#Calculate Mean
pop1mean<-mean(pop1_allelicR_zeroesRemoved)
pop2mean<-mean(pop2_allelicR_zeroesRemoved)
pop3mean<-mean(pop3_allelicR_zeroesRemoved)
pop4mean<-mean(pop4_allelicR_zeroesRemoved)


##Calculate Sstandard Deviation
pop1sd<-sd(pop1_allelicR_zeroesRemoved)
pop2sd<-sd(pop2_allelicR_zeroesRemoved)
pop3sd<-sd(pop3_allelicR_zeroesRemoved)
pop4sd<-sd(pop4_allelicR_zeroesRemoved)



library(adegenet)
library(hierfstat)
library(ggplot2)

myData <- read.genepop("~/Snails/Lithasia_hubrichti/L_hubrichti_m5M3n3_R80_maf025_single/L_hubrichti_m5M3n3_R80_maf025_single.snps.gen")
myData$pop
pop_list<-factor(myData$pop)
pop_list[1]
##In this case there is only one population. If more than one population, calculate again and change number in brackets after pop_list
stats<-basic.stats(myData[myData$pop == pop_list[1]])
stats

##Again, this is only one population. Would need to plot for each population.

#uncomment pdf if you want to save plot

#pdf(myPlot.pdf)
plot(stats$perloc$Fis, main = "Lithasia hubrichti", xlab = "locus", ylab = "Fis")
abline(h=stats$overall[9], col="red")
#dev.off()
stats$overall[9]
##Looking at how all the Fis = 1 skew things.
stats2<-stats$perloc[-(which(stats$Fis == 1.0000)),]
Fis_mean(stats2[,9])
plot(stats2$Fis, main = "Lithasia hubrichti without Fis = 1", xlab = "locus", ylab = "Fis")
abline(h=Fis_mean, col="red")

