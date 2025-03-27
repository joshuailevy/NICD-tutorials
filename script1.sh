baseName="test1"
r1="fastqs/${baseName}_R1_001.fastq.gz"
r2="fastqs/${baseName}_R2_001.fastq.gz"
# perform alignment
minimap2 -ax sr NC_045512_Hu-1.fasta $r1 $r2 | samtools view -bS - > "${baseName}.bam"

# sort the aligned reads

samtools sort -o "${baseName}.sorted.bam" "${baseName}.bam"

# index the aligned reads

samtools index "${baseName}.sorted.bam"