#!/bin/bash


bam_dir="/public/home/lxr/ddx-19/bowtie/bam"
output_file="/public/home/lxr/ddx-19/featurecount/bowtieddx-19.txt"

featureCounts -T 4 -s 2 \
-a /public/home/lxr/ddx-19/featurecount/C.elegans.gtf \
-o $output_file \
$bam_dir/*.bam

