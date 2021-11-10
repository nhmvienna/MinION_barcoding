### subset to first 1000 reads

head -4000 /media/inter/mkapun/projects/MinION_barcoding/data/test/Supplementary_File1_reads.fastq  \
  > /media/inter/mkapun/projects/MinION_barcoding/data/subset.fastq

### investigate with nanoplot

source /opt/anaconda3/etc/profile.d/conda.sh
conda activate nanoplot_1.32.1

mkdir /media/inter/mkapun/projects/MinION_barcoding/results

## check out quality of

NanoPlot \
  --fastq subset.fastq \
  -o /media/inter/mkapun/projects/MinION_barcoding/results/subset \
  -p subset

### load NGSspeciesID

conda activate NGSpeciesID

NGSpeciesID  \
  --ont \
  --consensus \
  --sample_size 300 \
  --m 800 \
  --s 100 \
  --t 5 \
  --medaka \
  --primer_file /media/inter/mkapun/projects/MinION_barcoding/data/test/Supplementary_File3_primer.txt \
  --fastq /media/inter/mkapun/projects/MinION_barcoding/data/subset.fastq \
  --outfolder /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus

mkdir /media/inter/mkapun/projects/MinION_barcoding/results/blast

module load Alignment/ncbi-BLAST-2.12.0

blastn \
  -num_threads 100 \
  -evalue 1e-100 \
  -outfmt "6 qseqid sseqid sscinames slen qlen pident length mismatch gapopen qstart qend sstart send evalue bitscore" \
  -db /media/scratch/NCBI_nt_DB_210714/nt \
  -query /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus/consensus_reference_4.fasta \
  > /media/inter/mkapun/projects/MinION_barcoding/results/blast/blastn.txt
