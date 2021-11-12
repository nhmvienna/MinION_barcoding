### investigate with nanoplot

mkdir /media/inter/mkapun/projects/MinION_barcoding/results

echo '''
#!/bin/sh

## name of Job
#PBS -N Nanoplot

## Redirect output stream to this file.
#PBS -o /media/inter/mkapun/projects/MinION_barcoding/NanoPlot_log.txt

## Stream Standard Output AND Standard Error to outputfile (see above)
#PBS -j oe

## Select a maximum of 20 cores and 200gb of RAM
#PBS -l select=1:ncpus=20:mem=200gb

######## load dependencies #######

# first load NanoPlot into your environemt
source /opt/anaconda3/etc/profile.d/conda.sh
conda activate nanoplot_1.32.1

######## run analyses #######

## check out quality of FASTQ

NanoPlot \
  --fastq /media/inter/mkapun/projects/MinION_barcoding/data/test/Supplementary_File1_reads.fastq \
  -o /media/inter/mkapun/projects/MinION_barcoding/results/nanoplot \
  -p alldata

''' > /media/inter/mkapun/projects/MinION_barcoding/shell/NanoPlot_qsub.sh

qsub /media/inter/mkapun/projects/MinION_barcoding/shell/NanoPlot_qsub.sh


## Demultiplex samples
echo '''
#!/bin/sh

## name of Job
#PBS -N minibar

## Redirect output stream to this file.
#PBS -o /media/inter/mkapun/projects/MinION_barcoding/minibar_log.txt

## Stream Standard Output AND Standard Error to outputfile (see above)
#PBS -j oe

## Select a maximum of 20 cores and 200gb of RAM
#PBS -l select=1:ncpus=20:mem=200gb

######## load dependencies #######

source /opt/venv/minibar/bin/activate
module load Tools/minibar

######## run analyses #######

cd /media/inter/mkapun/projects/MinION_barcoding/data/test

minibar.py \
  /media/inter/mkapun/projects/MinION_barcoding/data/test/Supplementary_File2_minibar.txt \
  /media/inter/mkapun/projects/MinION_barcoding/data/test/Supplementary_File1_reads.fastq \
  -T \
  -F \
  -e 3 \
  -E 11 \

  ''' > /media/inter/mkapun/projects/MinION_barcoding/shell/minibar_qsub.sh

qsub /media/inter/mkapun/projects/MinION_barcoding/shell/minibar_qsub.sh


## Expected results:

#### 4 new files according to three barcodes + failed demultiplexing

## check # of reads in new datasets

grep -cP "^@" /media/inter/mkapun/projects/MinION_barcoding/data/test/sample_h1.fastq

### load NGSspeciesID with medaka

echo '''
#!/bin/sh

## name of Job
#PBS -N NGSspeciesID_medaka

## Redirect output stream to this file.
#PBS -o /media/inter/mkapun/projects/MinION_barcoding/NGSspeciesID_medaka_log.txt

## Stream Standard Output AND Standard Error to outputfile (see above)
#PBS -j oe

## Select a maximum of 20 cores and 200gb of RAM
#PBS -l select=1:ncpus=20:mem=200gb

######## load dependencies #######

source /opt/anaconda3/etc/profile.d/conda.sh
conda activate NGSpeciesID

######## run analyses - single sample and Medaka #######

NGSpeciesID  \
  --ont \
  --consensus \
  --sample_size 300 \
  --m 800 \
  --s 200 \
  --t 20 \
  --medaka \
  --primer_file /media/inter/mkapun/projects/MinION_barcoding/data/test/Supplementary_File3_primer.txt \
  --fastq /media/inter/mkapun/projects/MinION_barcoding/data/test/sample_c1.fastq \
  --outfolder /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_medaka_c1

NGSpeciesID  \
  --ont \
  --consensus \
  --sample_size 300 \
  --m 800 \
  --s 200 \
  --t 20 \
  --medaka \
  --primer_file /media/inter/mkapun/projects/MinION_barcoding/data/test/Supplementary_File3_primer.txt \
  --fastq /media/inter/mkapun/projects/MinION_barcoding/data/test/sample_w1.fastq \
  --outfolder /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_medaka_w1

NGSpeciesID  \
  --ont \
  --consensus \
  --sample_size 300 \
  --m 800 \
  --s 200 \
  --t 20 \
  --medaka \
  --primer_file /media/inter/mkapun/projects/MinION_barcoding/data/test/Supplementary_File3_primer.txt \
  --fastq /media/inter/mkapun/projects/MinION_barcoding/data/test/sample_h1.fastq \
  --outfolder /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_medaka_h1

''' > /media/inter/mkapun/projects/MinION_barcoding/shell/NGSspeciesID_medaka_qsub.sh

qsub /media/inter/mkapun/projects/MinION_barcoding/shell/NGSspeciesID_medaka_qsub.sh

cat /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_medaka_*/consensus_reference_*.fasta \
  > /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_medaka.fa

##

echo '''

#!/bin/sh

## name of Job
#PBS -N NGSspeciesID_racon

## Redirect output stream to this file.
#PBS -o /media/inter/mkapun/projects/MinION_barcoding/NGSspeciesID_racon_log.txt

## Stream Standard Output AND Standard Error to outputfile (see above)
#PBS -j oe

## Select a maximum of 20 cores and 200gb of RAM
#PBS -l select=1:ncpus=20:mem=200gb

######## load dependencies #######

source /opt/anaconda3/etc/profile.d/conda.sh
conda activate NGSpeciesID

######## run analyses - single sample and Racon #######

NGSpeciesID  \
  --ont \
  --consensus \
  --sample_size 300 \
  --m 800 \
  --s 200 \
  --t 20 \
  --racon \
  --primer_file /media/inter/mkapun/projects/MinION_barcoding/data/test/Supplementary_File3_primer.txt \
  --fastq /media/inter/mkapun/projects/MinION_barcoding/data/test/sample_w1.fastq \
  --outfolder /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_racon_w1

NGSpeciesID  \
  --ont \
  --consensus \
  --sample_size 300 \
  --m 800 \
  --s 200 \
  --t 20 \
  --racon \
  --primer_file /media/inter/mkapun/projects/MinION_barcoding/data/test/Supplementary_File3_primer.txt \
  --fastq /media/inter/mkapun/projects/MinION_barcoding/data/test/sample_h1.fastq \
  --outfolder /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_racon_h1

NGSpeciesID  \
  --ont \
  --consensus \
  --sample_size 300 \
  --m 800 \
  --s 200 \
  --t 20 \
  --racon \
  --primer_file /media/inter/mkapun/projects/MinION_barcoding/data/test/Supplementary_File3_primer.txt \
  --fastq /media/inter/mkapun/projects/MinION_barcoding/data/test/sample_c1.fastq \
  --outfolder /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_racon_c1

''' > /media/inter/mkapun/projects/MinION_barcoding/shell/NGSspeciesID_racon_qsub.sh

qsub /media/inter/mkapun/projects/MinION_barcoding/shell/NGSspeciesID_racon_qsub.sh

cat /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_racon_*/consensus_reference_*.fasta \
  > /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_racon.fa


echo '''

#!/bin/sh

## name of Job
#PBS -N NGSspeciesID_mixed

## Redirect output stream to this file.
#PBS -o /media/inter/mkapun/projects/MinION_barcoding/NGSspeciesID_mixed_log.txt

## Stream Standard Output AND Standard Error to outputfile (see above)
#PBS -j oe

## Select a maximum of 20 cores and 200gb of RAM
#PBS -l select=1:ncpus=20:mem=200gb

######## load dependencies #######

source /opt/anaconda3/etc/profile.d/conda.sh
conda activate NGSpeciesID

######## run analyses - mixed sample and Medaka #######

NGSpeciesID  \
  --ont \
  --consensus \
  --sample_size 900 \
  --m 800 \
  --s 200 \
  --t 20 \
  --medaka \
  --primer_file /media/inter/mkapun/projects/MinION_barcoding/data/test/Supplementary_File3_primer.txt \
  --fastq /media/inter/mkapun/projects/MinION_barcoding/data/test/Supplementary_File1_reads.fastq \
  --outfolder /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_mixed

''' > /media/inter/mkapun/projects/MinION_barcoding/shell/NGSspeciesID_mixed_qsub.sh

qsub /media/inter/mkapun/projects/MinION_barcoding/shell/NGSspeciesID_mixed_qsub.sh

cat /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_mixed/consensus_reference_*.fasta \
  > /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_mixed.fa

### BLAST

echo '''
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

''' > /media/inter/mkapun/projects/MinION_barcoding/shell/BlastN_qsub.sh

qsub /media/inter/mkapun/projects/MinION_barcoding/shell/BlastN_qsub.sh

######## amplicon_sorter #######

echo '''
#!/bin/sh

## name of Job
#PBS -N ampliconsorter

## Redirect output stream to this file.
#PBS -o /media/inter/mkapun/projects/MinION_barcoding/ampliconsorter_log.txt

## Stream Standard Output AND Standard Error to outputfile (see above)
#PBS -j oe

## Select a maximum of 20 cores and 200gb of RAM
#PBS -l select=1:ncpus=20:mem=200gb

######## load dependencies #######

source /opt/venv/amplicon_sorter/bin/activate
#module load Tools/amplicon_sorter

######## run analyses - single sample  #######

python /opt/bioinformatics/amplicon_sorter/amplicon_sorter.py \
  -i /media/inter/mkapun/projects/MinION_barcoding/data/test/sample_c1.fastq \
  -o /media/inter/mkapun/projects/MinION_barcoding/results/amplicon_sorter_c1 \
  -np 20 \
  -min 600 \
  -max 1000 \
  -maxr 300

python /opt/bioinformatics/amplicon_sorter/amplicon_sorter.py \
  -i /media/inter/mkapun/projects/MinION_barcoding/data/test/Supplementary_File1_reads.fastq \
  -o /media/inter/mkapun/projects/MinION_barcoding/results/amplicon_sorter_mixed \
  -np 20 \
  -min 600 \
  -max 1000 \
  -maxr 900 \
  -sc 93 \
  -ssg 85

''' > /media/inter/mkapun/projects/MinION_barcoding/shell/ampliconsorter_qsub.sh

qsub /media/inter/mkapun/projects/MinION_barcoding/shell/ampliconsorter_qsub.sh


echo '''
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

blastn \
  -num_threads 20 \
  -evalue 1e-100 \
  -outfmt "6 qseqid sseqid sscinames scomnames slen qlen pident length mismatch gapopen qstart qend sstart send evalue bitscore" \
  -db /media/scratch/NCBI_nt_DB_210714/nt \
  -query /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_ampS \
  > /media/inter/mkapun/projects/MinION_barcoding/results/blast/blastn.txt

blastn \
  -num_threads 20 \
  -evalue 1e-100 \
  -outfmt "6 qseqid sseqid sscinames scomnames slen qlen pident length mismatch gapopen qstart qend sstart send evalue bitscore" \
  -db /media/scratch/NCBI_nt_DB_210714/nt \
  -query /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_ampS \
  > /media/inter/mkapun/projects/MinION_barcoding/results/blast/blastn.txt

''' > /media/inter/mkapun/projects/MinION_barcoding/shell/BlastN_qsub.sh

qsub /media/inter/mkapun/projects/MinION_barcoding/shellBlastN_qsub.sh


tar -czvf /media/inter/mkapun/projects/MinION_barcoding/results.tar.gz /media/inter/mkapun/projects/MinION_barcoding/results

tar -czvf /media/inter/mkapun/projects/MinION_barcoding/data.tar.gz /media/inter/mkapun/projects/MinION_barcoding/data
