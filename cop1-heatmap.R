## modified from Trevor Nolan. 
##Make heatmap for cop1 vs BR DEG genes
#Make sure NMF package is already installed
library(dplyr)              # Data manipulation & magrittr pipe
library(ggplot2)            # General plotting
library(NMF)                # aheatmap()
library(gplots)             # heatmap.2()
library(RColorBrewer)       # Brewer palettes


## read data
logFC_BR <- read.delim("logFC_BR.txt")
logFC_cop1 <- read.delim("logFC_cop1.txt")

# read a subset of genes
BR.up.cop1.dn_ID <- read.table("BR.up.cop1.dn.txt", header=TRUE, quote="\"")
BR.dn.cop1.up_ID <- read.table("BR.dn.cop1.up.txt", header=TRUE, quote="\"")

## or you can select specific rows first
up_logFC_fromBR <- merge(BR.up.cop1.dn_ID, logFC_BR, by.x = "GeneID", by.y = "GeneID", all = F)
dn_logFC_fromBR <- merge(BR.dn.cop1.up_ID, logFC_BR, by.x = "GeneID", by.y = "GeneID", all = F)
up_logFC_fromCop <- merge(BR.up.cop1.dn_ID, logFC_cop1, by.x = "GeneID", by.y = "GeneID", all = F)
dn_logFC_fromCop <- merge(BR.dn.cop1.up_ID, logFC_cop1, by.x = "GeneID", by.y = "GeneID", all = F)


write.csv(up_logFC_fromBR, "up_logFC_fromBR.txt")
write.csv(dn_logFC_fromBR, "dn_logFC_fromBR.txt")
write.csv(up_logFC_fromCop, "up_logFC_fromCop.txt")
write.csv(dn_logFC_fromCop, "dn_logFC_fromCop.txt")

# select columns (wt with water or dehydration)
#candi_RPM_WT_de <- candi_RPM %>%
#  select(GeneID, starts_with("wt_d"), starts_with("wt_w"))

#select colums with values only
#candi_RPM_values_WT_de <- candi_RPM_WT_de[,c(1:4, 7:9)]

# change GeneID colum to rowname, change dataframe to matrix
# read common name
#common_name_inorder <- read.table("~/Documents/Rdata/common_name_inorder.txt", header=TRUE, quote="\"")
#rownames(candi_RPM_values_WT_de) <- common_name_inorder[,1]
#candi_RPM_values_WT_de[,1] <- NULL

#log2 transform data
#candi_RPM_WT_de.log2 <- log(candi_RPM_values_WT_de + 0.00001, 2)

logFC_BR.up.cop1.dn <- read.delim("BR.up.cop1.dn.logFC.txt")
logFC_BR.dn.cop1.up <- read.delim("BR.dn.cop1.up.logFC.txt")

# draw heatmap
aheatmap(logFC_BR.up.cop1.dn, cellwidth = 5, cellheight = 2, Rowv = FALSE, Colv = FALSE)

aheatmap(candi_RPM_WT_de.log2, cellwidth = 5, cellheight = 2, Rowv = FALSE, Colv = FALSE)
# write the expression data RPM to a file
# add the row name as the common name
rownames(candi_RPM_WT_de) <- common_name_inorder[,1]
write.csv(candi_RPM_WT_de, "~/Desktop/GeneExpress.SnRK.PP2C.NAC.csv")

## select columns with water or dehydration
# RPM_WT_de <- RPMall %>%
#   select(GeneID, starts_with("wt_d"), starts_with("wt_w"))

## alternatively, use the column number to pick up data. casue select can only use name as parameter
#RPM_WT_de2 <- RPMall [, c(1, 34,35, 36, 39,40,41)]

## choose rows with candidate genes, use a subset gene list allID
#candi_RPM_WT_de <- merge(all_ID, RPM_WT_de, by.x = "GeneID", by.y = "GeneID", all=F)

## alternatively, use a easy way, but hard to understand
#candi_RPM_WT_de2 <- RPM_WT_de[RPM_WT_de$GeneID %in% all_ID$V1]

## tidy data for heatmap
