## modified from Trevor Nolan. 
##Make heatmap for dehydration genes
#Make sure NMF package is already installed
library(NMF)
library(dplyr)              # Data manipulation & magrittr pipe
library(ggplot2)            # General plotting
library(NMF)                # aheatmap()
library(gplots)             # heatmap.2()
library(RColorBrewer)       # Brewer palettes

#read in complete gene list with expression values
RPMall <- read.delim("~/Box Sync/proj01/RPMall.txt")

#read in subset you want to extract from list
WT_de_.15 <- read.csv("~/Box Sync/proj01/Mut de v WT de/DeANDBIP5vDE.csv", sep="")

# use merge to get values for only that subset
WT_de_.15values <- merge(WT_de_.15, RPMall, by.x="GeneID", by.y="GeneID", all=F)
#use only columns needed for heatmap
WT_de.15valuesonly <- WT_de_.15values[,c(42,43,44,45)]

#plot heatmap after log2
#add small value to avoid taking log of 0
WT_de.15valuesonly.00001 <- WT_de.15valuesonly + .00001

#log2 transform data
WT_delog2 <- log(WT_de.15valuesonly.00001, 2)

#draw heatmap with row normalization, reorder rows (genes), but keep columns fixed
## Rowv = FALSE, meaning dendrogram is not shown
aheatmap(WT_delog2, Colv = NA, color = bluered(256), scale = "row", Rowv = FALSE, distfun = "pearson")

#optional to write table with these values for outside use
write.table(WT_de.15valuesonly, "~/Box Sync/proj01/wtDR_wtCK/WT_de_.15valuesonly.txt",sep = "\t", row.names=F, quote = F)

#get row names
WT_de.15GeneIDs <- WT_de_.15values[,1]
write.table(WT_de.15GeneIDs, "~/Box Sync/proj01/wtDR_wtCK/WT_de_.15GeneIDs.txt",sep = "\t", row.names=F, quote = F)


######################ABOVE from Trevor##############################

## read data
RPMall <- read.delim("~/Documents/Rdata/RPMall.txt")

# read a subset of genes
all_ID <- read.table("~/Documents/Rdata/all_ID.txt", header=TRUE, quote="\"")


## or you can select specific rows first
candi_RPM <- merge(all_ID, RPMall, by.x = "GeneID", by.y = "GeneID", all = F)

# select columns (wt with water or dehydration)
candi_RPM_WT_de <- candi_RPM %>%
  select(GeneID, starts_with("wt_d"), starts_with("wt_w"))

#select colums with values only
candi_RPM_values_WT_de <- candi_RPM_WT_de[,c(1:4, 7:9)]

# change GeneID colum to rowname, change dataframe to matrix
# read common name
common_name_inorder <- read.table("~/Documents/Rdata/common_name_inorder.txt", header=TRUE, quote="\"")
rownames(candi_RPM_values_WT_de) <- common_name_inorder[,1]
candi_RPM_values_WT_de[,1] <- NULL

#log2 transform data
candi_RPM_WT_de.log2 <- log(candi_RPM_values_WT_de + 0.00001, 2)

# draw heatmap
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
