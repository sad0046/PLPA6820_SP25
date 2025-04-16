library(poppr)

setwd("C:/Users/pred9/Desktop/AU_PhD/Auburn Stuff/2DRad-Ebell-Ecoc/2024_Jan_Redos/bellacrenata")

rm(list=ls())

bella.geneid.nout = read.genepop("Ebella_2.80.025.50_Multi.haps.gen")

bella.genclone.nout<-as.genclone(bella.geneid.nout)

bella.genclone.nout$strata

strata(bella.genclone.nout)<-(as.data.frame(bella.geneid.nout$pop))

#help(read.genepop)

##AMOVA

bella.genclone.nout
bella.genclone.nout$strata
bella.site.amova.pop = poppr.amova(bella.genclone.nout, ~bella.geneid.nout.pop, cutoff = 0.5, method = "ade4")
#help("poppr.amova")

####Print Results

bella.site.amova.pop

##Randomization Test
bella.site.amova.pop.rtest<-randtest(bella.site.amova.pop,nrepet = 999)
bella.site.amova.pop.rtest
plot(bella.site.amova.pop.rtest)

