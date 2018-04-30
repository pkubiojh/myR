# RNA seq analysis. sorting and gene expression analysis of bin2-D and Col, RD26OX and Col comparision. 
# starting from the analyzed data-SummerizedExperiment objects of bin2-1 vs col and RDOX vs Col. 

#library(NMF)
#library(dplyr)              # Data manipulation & magrittr pipe
#library(ggplot2)            # General plotting
#library(NMF)                # aheatmap()
#library(gplots)             # heatmap.2()
#library(RColorBrewer)       # Brewer palettes

# read data from csv file
## bin2RNAseq <- read.csv("bin2-1_rnaSeq.csv", header = TRUE, sep = ",", quote = "\"", dec = ".", fill = TRUE, comment.char = "")
# filter the rows with value equal to 0
## bin2RNAseq <- dplyr::filter(bin2RNAseq, Col > 0 & bin2 > 0)
# start thinking about how to use the data. what's the cutoff of foldChange? how to compute the overlaps (bin2 and RD)
# https://www.bioconductor.org/help/workflows/rnaseqGene/

# decide to use easier way. Because we have the organized data from bin2-1 and RDOX 
# (1.5 fold change and p value Q value < 0.05). so just calculate the intersect directly.
# read 4 different dataset separately. bin2UP and Down, RDOXUP and Down
bin2UP <- c( as.character( read.csv("up_in_bin2-1.txt", header=F)$V1 ) )
length(bin2UP)
bin2DOWN <- c( as.character( read.csv("down_in_bin2-1.txt", header=F)$V1 ) )
length(bin2DOWN)
# RDoxUP <- c( as.character( read.csv("up_in_RD26OX.txt", header=F)$V1 ) )
RDoxUP <- c( as.character( read.csv("RDOXUPOneAndHalfFC.txt", header=F)$V1 ) )
length(RDoxUP)
# RDoxDOWN <- c( as.character( read.csv("down_in_RD26OX.txt", header=F)$V1 ) )
RDoxDOWN <- c( as.character( read.csv("RDOXDownOneAndHalfFC.txt", header=F)$V1 ) )
length(RDoxDOWN)

# count the overlap gene numbers 
length(intersect(bin2UP, RDoxUP))
length(intersect(bin2UP, RDoxDOWN))
length(intersect(bin2DOWN, RDoxUP))
length(intersect(bin2DOWN, RDoxDOWN))

# optional, print out the gene names to a new file, draw the heatmap, calculate the gene expression. Identify a few candidate genes for test.
# firstly, we need to get the RD26 gene expression dataset. retrieve the RDox DEG expression values. Got it.


