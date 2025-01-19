#
type<-read.table("biotype.txt",header = T,sep = "\t")

pie<-type
pie <- pie %>%
  group_by(Biotype) %>%
  summarise(Count = n()) %>%
  mutate(Freq = Count / sum(Count)) %>%
  arrange(desc(Freq)) %>%
  mutate(Biotype = factor(Biotype, levels = unique(Biotype))) 
#
deep_colors <- c(
  "protein_coding_gene" = "#fbdb93", 
  "piRNA_gene" = "#c4d8f0", 
  "pseudogene" = "#dea6cd", 
  "ncRNA_gene" =  "#b1d78a", 
  "miRNA_gene" = "#9BE1CE", 
  "lincRNA_gene" = "#C7E1EC", 
  "snoRNA_gene" =  "#86a369", 
  "antisense_lncRNA_gene" =  "#ab8cc3", 
  "tRNA_gene" =  "#fffffe",
  "other" =  "#98c5e2" ,
  "snRNA_gene"="gray"
)

ggplot(pie, aes(x = "", y = Freq, fill = Biotype)) +
  geom_bar(stat = "identity", width = 2) +
  coord_polar(theta = "y") +
  theme_void() +
  theme(legend.position = "right", legend.key.width = unit(5, "pt")) +
  scale_fill_manual(values = deep_colors) +
  theme(axis.ticks = element_blank())+
  ggtitle("gene biotype")
