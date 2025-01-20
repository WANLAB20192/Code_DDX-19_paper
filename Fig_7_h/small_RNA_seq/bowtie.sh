#!/bin/bash
INDEX_PATH="/public/home/lxr/ddx-19/bowtie/index"
INPUT_DIR="/public/home/lxr/ddx-19/rawdata"
OUTPUT_DIR="/public/home/lxr/ddx-19/bowtie/sam"

for FILE in ${INPUT_DIR}/*.fasta; do
    BASE_NAME=$(basename ${FILE} .fasta)
    
    OUTPUT_FILE="${OUTPUT_DIR}/${BASE_NAME}.sam"
    
    bowtie -f -n 0 -p 4 -x /public/home/lxr/ddx-19/bowtie/index/celegans ${FILE} -S ${OUTPUT_FILE}
    
    echo "done：${BASE_NAME}"
done
