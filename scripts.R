## read the RNA seq data
## where is the data
##    /Users/jianghao/Documents/Rdata/RD26.quasiSeq.DE.txt

rna_seq <- read.csv('/Users/jianghao/Documents/Rdata/RD26.quasiSeq.DE.txt', header = TRUE, sep = "\t")
## this works, if use \t to seperate them.
## use import dataset in the upright corner

RD26.quasiSeq.DE <- read.delim("~/Documents/Rdata/RD26.quasiSeq.DE.txt")

## try to pick up specific rows

## RPM (reads assigned per million mapped reads) normalization is available for RNA-Seq, ChIP-Seq, and miRNA experiments. When RPM is selected the signal values for each experiment will be divided by the total number of mapped reads divided by one million.

## use dplyr select function to select columns with colNT_rep1.RPM and colNT_rep2.RPM

rna_seq_colNT.RPM <- rna_seq%>%
  + select(GeneID, colNT_rep1.RPM, colNT_rep2.RPM)

## add one row, with average
rna_seq_colNT.RPM <- rna_seq_colNT.RPM %>%
  mutate(RPM_ave = (colNT_rep1.RPM + colNT_rep2.RPM)/2)

## choose specific geneID from the whole gene dataset
all = normalizedData ##like the rna_seq datasets
subset = candidateGenes   ## one column table only candidate geneID
all[all$geneID %in% subset$V1, ]
## geneID is the name of column in rna_seq, 

## in this case
all <- rna_seq_colNT.RPM
subset <- all_ID
candi_gene_RKM <- all[all$GeneID %in% subset$V1, ]

## Finally make it. ********important, make sure that all capital!!

## normalize to Actin8, next time, remember to calculate Act8 early

## Add one column, normalized column.
candi_gene_RKM <- candi_gene_RKM %>%
  mutate(nor_RPM = RPM_ave/241.77)

##### add a column
my.dataframe$new.col <- a.vector
### delete a column
my.dataframe$old.col <- NULL

## use aheatmap to do a heatmap. find which package is it.