### subset to first 1000 reads

head -4000 ~/github/MinION_barcoding/data/test/Supplementary_File1_reads.fastq  \
  > ~/github/MinION_barcoding/data/subset.fastq

### investigate with nanoplot

mkdir ~/github/MinION_barcoding/results

echo '''
#!/bin/sh

## name of Job
#PBS -N Nanoplot

## Redirect output stream to this file.
#PBS -o ~/github/MinION_barcoding/NanoPlot_log.txt

## Stream Standard Output AND Standard Error to outputfile (see above)
#PBS -j oe

## Select a maximum of 20 cores and 200gb of RAM
#PBS -l select=1:ncpus=20:mem=200gb

######## load dependencies #######

# first NanoPlot  into your environemt
source /opt/anaconda3/etc/profile.d/conda.sh
conda activate nanoplot_1.32.1

######## run analyses #######

## check out quality of FASTQ

NanoPlot \
  --fastq subset.fastq \
  -o ~/github/MinION_barcoding/results/subset \
  -p subset

''' > ~/github/MinION_barcoding/shell/NanoPlot_qsub.sh

qsub ~/github/MinION_barcoding/shell/NanoPlot_qsub.sh

### load NGSspeciesID

echo '''
#!/bin/sh

## name of Job
#PBS -N NGSspeciesID

## Redirect output stream to this file.
#PBS -o ~/github/MinION_barcoding/NGSspeciesID_log.txt

## Stream Standard Output AND Standard Error to outputfile (see above)
#PBS -j oe

## Select a maximum of 20 cores and 200gb of RAM
#PBS -l select=1:ncpus=20:mem=200gb

######## load dependencies #######

conda activate NGSpeciesID

######## run analyses #######

NGSpeciesID  \
  --ont \
  --consensus \
  --sample_size 300 \
  --m 800 \
  --s 100 \
  --t 20 \
  --medaka \
  --primer_file ~/github/MinION_barcoding/data/test/Supplementary_File3_primer.txt \
  --fastq ~/github/MinION_barcoding/data/subset.fastq \
  --outfolder ~/github/MinION_barcoding/results/subset_consensus

''' > ~/github/MinION_barcoding/shell/NGSspeciesID_qsub.sh

qsub ~/github/MinION_barcoding/shell/NGSspeciesID_qsub.sh

echo '''
#!/bin/sh

## name of Job
#PBS -N BlastN

## Redirect output stream to this file.
#PBS -o ~/github/MinION_barcoding/BlastN_log.txt

## Stream Standard Output AND Standard Error to outputfile (see above)
#PBS -j oe

## Select a maximum of 20 cores and 200gb of RAM
#PBS -l select=1:ncpus=20:mem=200gb

######## load dependencies #######

module load Alignment/ncbi-BLAST-2.12.0

######## run analyses #######

mkdir ~/github/MinION_barcoding/results/blast

blastn \
-num_threads 20 \
-evalue 1e-100 \
-outfmt "6 qseqid sseqid sscinames slen qlen pident length mismatch gapopen qstart qend sstart send evalue bitscore" \
-db /media/inter/scratch_backup/NCBI_nt_DB_210714/nt \
-query ~/github/MinION_barcoding/results/subset_consensus/consensus_reference_4.fasta \
> ~/github/MinION_barcoding/results/blast/blastn.txt

''' > ~/github/MinION_barcoding/shell/BlastN_qsub.sh

qsub ~/github/MinION_barcoding/shellBlastN_qsub.sh

## run analyses amplicon_sorter ##

