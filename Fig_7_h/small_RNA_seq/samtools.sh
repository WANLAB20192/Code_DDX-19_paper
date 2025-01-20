#!/bin/bash

input_dir="/public/home/lxr/ddx-19/bowtie/sam"    
output_dir="/public/home/lxr/ddx-19/bowtie/bam"   


for sam_file in "$input_dir"/*.sam
do
    filename=$(basename "$sam_file" .sam)
    
    bam_file="$output_dir/${filename}.bam"
    
    samtools view -bS "$sam_file" > "$bam_file"
    
    echo "done: $sam_file -> $bam_file"
done
