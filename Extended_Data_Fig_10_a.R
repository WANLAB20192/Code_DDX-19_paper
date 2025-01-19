library("ggplot2")
library("ggprism")
library("dplyr")
library("tidyr")
library("DESeq2")
library("reshape")
#
setwd("C:/Users/69432/Desktop/ddx-19/distribution")
#
length<-read.table("cut_npp-14_rep2_R1_001_length_distribution.txt",sep = "\t",header = F)
colnames(length)<-c("length","counts")
length<-length[order(length$length),]
base<-read.table("cut_npp-14_rep2_R1_001_base_proportions.txt",sep = "\t",header = T)
base<-base[order(base$Length),]
data<-merge(length,base,by.x = "length",by.y = "Length")
data<-data[17:26,]
data_long <- gather(data, key="Base", value="Proportion", A:T)
total_counts <- data_long %>% 
  mutate(total_counts = counts * Proportion)
#
p =  ggplot(total_counts, aes(x=as.factor(length), y=total_counts/1000000, fill=Base)) +
  geom_bar(stat="identity", position="stack") +
  theme_prism()+
  labs(x="Length", y="No. of reads (million)", title="npp-14 replicate 1") +
  scale_fill_manual(values=c("A"="blue", "G"="purple", "C"="green", "T"="red"))
ggsave("WAN602dis.tiff",width = 50,height = 8,dpi=300)
