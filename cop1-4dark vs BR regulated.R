# RNA seq analysis. sorting and gene expression analysis of bin2-D and Col, RD26OX and Col comparision. 
# starting from the analyzed data-SummerizedExperiment objects of bin2-1 vs col and RDOX vs Col. 

#library(NMF)
#library(dplyr)              # Data manipulation & magrittr pipe
#library(ggplot2)            # General plotting
#library(NMF)                # aheatmap()
#library(gplots)             # heatmap.2()
#library(RColorBrewer)       # Brewer palettes

# decide to use easier way. Because we have the organized data from bin2-1 and RDOX 
# (1.5 fold change and p value Q value < 0.05). so just calculate the intersect directly.
# read 4 different dataset separately. bin2UP and Down, RDOXUP and Down
cop1UP <- c( as.character( read.csv("cop1_UP.txt", header=F)$V1 ) )
length(cop1UP)
cop1DN <- c( as.character( read.csv("cop1_DN.txt", header=F)$V1 ) )
length(cop1DN)

BRUP <- c( as.character( read.csv("BR_UP.txt", header=F)$V1 ) )
length(BRUP)
BRDN <- c( as.character( read.csv("BR_DN.txt", header=F)$V1 ) )
length(BRDN)

#bes1DUP <- c( as.character( read.csv("bes1D_UP.txt", header=F)$V1 ) )
#length(bes1DUP)
#bes1DDN <- c( as.character( read.csv("bes1D_DN.txt", header=F)$V1 ) )
#length(bes1DDN)

#cop1UP_early <- c( as.character( read.csv("cop1-4_UP_early.txt", header=F)$V1 ) )
#length(cop1UP_early)
#cop1DN_early <- c( as.character( read.csv("cop1-4_DN_early.txt", header=F)$V1 ) )
#length(cop1DN_early)
# count the overlap gene numbers 
length(intersect(BRUP, cop1UP))
length(intersect(BRUP, cop1DN))
length(intersect(BRDN, cop1UP))
length(intersect(BRDN, cop1DN))

BR.up.cop1.dn <- intersect(BRUP, cop1DN)
BR.dn.cop1.up <- intersect(BRDN, cop1UP)

write(BR.up.cop1.dn, "BR.up.cop1.dn.txt")
write(BR.dn.cop1.up, "BR.dn.cop1.up.txt")
# optional, print out the gene names to a new file, draw the heatmap, calculate the gene expression. Identify a few candidate genes for test.
# firstly, we need to get the RD26 gene expression dataset. retrieve the RDox DEG expression values. Got it.


