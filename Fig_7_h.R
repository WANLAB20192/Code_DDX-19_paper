#
setwd("C:/Users/69432/Desktop/ddx-19/bowtieddx-19")
data <- read.table("bowtieddx-19.txt",sep = "\t",row.names = 1,header = T)
data <- data[,-(1:5)]
colnames(data)<-c("ddx-19_R1","ddx-19_R2","gle-1_R1","gle-1_R2","N2_R1","N2_R2","npp-14_R1","npp-14_R2")

#
A<-c("npp-14_R1","npp-14_R2","N2_R1","N2_R2")
data<-data[,colnames(data) %in% A]
countdata <- data[rowMeans(data)>1,]
condition <- factor(c(rep("control",2),rep("treat",2)))
colData <- data.frame(row.names=colnames(countdata), condition)
#deseq2
dds <- DESeqDataSetFromMatrix(countData = countdata, colData = colData, design= ~condition)
dds1 <- DESeq(dds)
res <- results(dds1, contrast = c('condition', 'treat', 'control'))
res <- data.frame(res)
res[which(res$log2FoldChange >= 1& res$padj < 0.05 ),'sig'] <- 'up'
res[which(res$log2FoldChange <= -1& res$padj < 0.05 ),'sig'] <- 'down'
res [which(abs(res$log2FoldChange) <= 1 | res$padj >= 0.05),'sig'] <- 'none'
#
diff_gene_deseq2 <- subset(res, sig %in% c('up', 'down'))
#
res_up <- subset(res, sig == 'up')
res_down <- subset(res, sig == 'down')
write.csv(res_up, "npp14_up_gene.csv")
write.csv(res_down, "npp14_down_gene.csv")
#valcano
res <- res[res$padj != 0,]
ggplot(res, aes(log2FoldChange, -log10(padj), col = sig)) +
  geom_point() +
  theme_prism() +
  labs(x="log2 Fold change(npp-14 / WT)",y="-log10 (padj)") +
  geom_hline(yintercept = -log10(0.05), lty=4,col="grey",lwd=1) +
  geom_vline(xintercept = c(-1, 1), lty=4,col="grey",lwd=1) +
  theme(legend.position = "none",
        panel.grid=element_blank(),
        axis.title = element_text(size = 18),
        axis.text = element_text(size = 14)) +
  scale_color_manual(values = c("gray", "red", "blue"),limits = c('none', 'up', 'down'))
