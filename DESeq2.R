# read raw counts from featureCounts
# note: in R "/" is used as file path
cts <- as.matrix(read.csv(file = "C:/Users/User/Google Drive/Data/Big Data/cop1-4 RNA seq/counts/countsTable.txt",header = TRUE, sep="\t", row.names="Gene_ID"))
coldata <- read.csv(file = "C:/Users/User/Google Drive/Data/Big Data/cop1-4 RNA seq/counts/annotation.txt", header = TRUE, sep = "\t", row.names = 1)
coldata <- coldata[,c("condition", "type")]

rownames(coldata) <- sub("fb", "", rownames(coldata))
#all(rownames(coldata)) %in% colnames(cts)

cts <- cts[, rownames(coldata)]
all(rownames(coldata) == colnames(cts))

library("DESeq2")
dds <- DESeqDataSetFromMatrix(countData = cts,
                              colData = coldata,
                              design = ~ condition)
#mcol(dds)
dds<-DESeq(dds)

#res <- results(dds)
res <- results(dds, contrast = c("condition", "treated", "untreated"))
## contrast = c('factorName','numeratorLevel','denominatorLevel')
## comeback latter here to check which vs which, how to change it? ###############still wrong

#shrinkage for visualization and ranking
#resultsNames(dds)
#resLFC <- lfcShrink(dds, coef="condition_untreated_vs_treated", type="apeglm")
## after fix error, change this

#plotMA(res, ylim=c(-2,2))
#plotMA(resLFC, ylim=c(-2,2))

results <- as.data.frame(res)

sig.up.results <- results[which(results$padj < 0.05 & results$log2FoldChange > 0),]
sig.down.results <- results[which(results$padj < 0.05 & results$log2FoldChange < 0),]

sig.results <- results[which(results$padj < 0.05), ]
sig.results <- sig.results[order(sig.results$log2FoldChange, decreasing = TRUE),]

plotMA(dds, pvalCutoff = 0.05)

write.table(sig.results, file = "cop1-4_DESeq2_Sigresults.txt", sep = "\t", row.names = TRUE, col.names = TRUE)
write.table(results, file = "cop1-4_DESeq2_Allresults.txt", sep = "\t", col.names = TRUE)
