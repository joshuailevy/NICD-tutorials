#now loop through multiple files, and call consensus
for baseName in "test1" "test2"
do
	r1="fastqs/${baseName}_R1_001.fastq.gz"
	r2="fastqs/${baseName}_R2_001.fastq.gz"
	# perform alignment
	minimap2 -ax sr NC_045512_Hu-1.fasta $r1 $r2 | samtools view -bS - > "${baseName}.bam"

	# sort the aligned reads

	samtools sort -o "${baseName}.sorted.bam" "${baseName}.bam"

	# index the aligned reads

	samtools index "${baseName}.sorted.bam"

	# skip the usual trim step for purposes of tutorial, then call consensus 

	samtools mpileup -aa -A -d 0 -Q 0 "${baseName}.sorted.bam" | ivar consensus -p "${baseName}"
done
##