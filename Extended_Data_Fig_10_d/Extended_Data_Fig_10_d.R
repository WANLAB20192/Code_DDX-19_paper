#
setwd("C:/Users/69432/Desktop/ddx-19/bowtieddx-19/piRNA_target")
piRNA_target<-read.table("predicted_piRNA_target_sites_relaxed_clash.txt",header = T,sep = "\t")
#
setwd("C:/Users/69432/Desktop/ddx-19/bowtieddx-19")
gle1_up<-read.csv("gle1_up_gene.csv",header = T,row.names = 1)
ddx19_up<-read.csv("WAN602_up_gene.csv",header = T,row.names = 1)
npp14_up<-read.csv("npp14_up_gene.csv",header = T,row.names = 1)
over_up<-read.table("up_gene_intersection.txt",header = F)

#intersection
gle1_up_piRNA<-piRNA_target[piRNA_target$Gene %in% rownames(gle1_up),]
ddx19_up_piRNA<-piRNA_target[piRNA_target$Gene %in% rownames(ddx19_up),]
npp14_up_piRNA<-piRNA_target[piRNA_target$Gene %in% rownames(npp14_up),]
over_up_piRNA<-piRNA_target[piRNA_target$Gene %in% over_up$V1,]
#
gle1_up_piRNA$group<-"gle1_up"
ddx19_up_piRNA$group<-"ddx19_up"
npp14_up_piRNA$group<-"npp14_up"
over_up_piRNA$group<-"over_up"
piRNA_target$group<-"all"
piRNA_all<-rbind(gle1_up_piRNA,ddx19_up_piRNA,npp14_up_piRNA,piRNA_target,over_up_piRNA)
piRNA_all$of.CLASH.identified.piRNA.target.site <- as.numeric(piRNA_all$of.CLASH.identified.piRNA.target.site)


# add comparisons list
comparisons <- list(
  c("all", "ddx19_up"),
  c("all", "gle1_up"),
  c("all", "npp14_up"),
  c("all", "over_up")
)
ggplot(piRNA_all, aes(x = group, y = log10(of.CLASH.identified.piRNA.target.site+1),fill = group)) +
  geom_boxplot(outlier.shape = NA) +
  theme_prism() +
  labs(
    x = "group",
    y = "log 10 (piRNA_target+1)"
  ) +
  stat_compare_means(comparisons = comparisons, )
ggsave("piRNA_all_up_target.pdf",width = 8,height = 8,dpi=300)



