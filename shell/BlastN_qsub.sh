
#!/bin/sh

## name of Job
#PBS -N BlastN

## Redirect output stream to this file.
#PBS -o /media/inter/mkapun/projects/MinION_barcoding/BlastN_log.txt

## Stream Standard Output AND Standard Error to outputfile (see above)
#PBS -j oe

## Select a maximum of 20 cores and 200gb of RAM
#PBS -l select=1:ncpus=20:mem=200gb

######## load dependencies #######

module load Alignment/ncbi-BLAST-2.12.0

######## run analyses #######

mkdir /media/inter/mkapun/projects/MinION_barcoding/results/blast

blastn \
  -num_threads 20 \
  -evalue 1e-100 \
  -max_target_seqs 10 \
  -outfmt "6 qseqid sseqid sscinames scomnames slen qlen pident length mismatch gapopen qstart qend sstart send evalue bitscore" \
  -db /media/scratch/NCBI_nt_DB_210714/nt \
  -query /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_medaka.fa \
  > /media/inter/mkapun/projects/MinION_barcoding/results/blast/blastn_medaka.txt

blastn \
  -num_threads 20 \
  -evalue 1e-100 \
  -max_target_seqs 10 \
  -outfmt "6 qseqid sseqid sscinames scomnames slen qlen pident length mismatch gapopen qstart qend sstart send evalue bitscore" \
  -db /media/scratch/NCBI_nt_DB_210714/nt \
  -query /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_racon.fa \
  > /media/inter/mkapun/projects/MinION_barcoding/results/blast/blastn_racon.txt

blastn \
  -num_threads 20 \
  -evalue 1e-100 \
  -max_target_seqs 10 \
  -outfmt "6 qseqid sseqid sscinames scomnames slen qlen pident length mismatch gapopen qstart qend sstart send evalue bitscore" \
  -db /media/scratch/NCBI_nt_DB_210714/nt \
  -query /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_mixed.fa \
  > /media/inter/mkapun/projects/MinION_barcoding/results/blast/blastn_mixed.txt


