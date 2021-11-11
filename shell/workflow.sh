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
  --fastq Supplementary_File1_reads.fastq \
  -o /media/inter/mkapun/projects/MinION_barcoding/results/nanoplot \
  -p subset

''' > /media/inter/mkapun/projects/MinION_barcoding/shell/NanoPlot_qsub.sh

qsub /media/inter/mkapun/projects/MinION_barcoding/shell/NanoPlot_qsub.sh


## Demultiplex samples
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

source /opt/venv/minibar/bin/activate
module load Tools/minibar

######## run analyses #######

minibar.py \
  Supplementary_File3_primer.txt \
  Supplementary_File1_reads.fastq \
  -T \
  -F \
  -e 3 \
  -E 11 \

  ''' > /media/inter/mkapun/projects/MinION_barcoding/shell/minibar_qsub.sh

qsub /media/inter/mkapun/projects/MinION_barcoding/shell/minibar_qsub.sh

## Expected results:

### load NGSspeciesID

echo '''
#!/bin/sh

## name of Job
#PBS -N NGSspeciesID

## Redirect output stream to this file.
#PBS -o /media/inter/mkapun/projects/MinION_barcoding/NGSspeciesID_log.txt

## Stream Standard Output AND Standard Error to outputfile (see above)
#PBS -j oe

## Select a maximum of 20 cores and 200gb of RAM
#PBS -l select=1:ncpus=20:mem=200gb

######## load dependencies #######

conda activate NGSpeciesID

######## run analyses - single sample and Medaka #######

NGSpeciesID  \
  --ont \
  --consensus \
  --sample_size 1000 \
  --m 800 \
  --s 100 \
  --t 20 \
  --medaka \
  --primer_file /media/inter/mkapun/projects/MinION_barcoding/data/test/Supplementary_File3_primer.txt \
  --fastq /media/inter/mkapun/projects/MinION_barcoding/data/subset.fastq \
  --outfolder /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_medaka

''' > /media/inter/mkapun/projects/MinION_barcoding/shell/NGSspeciesID_qsub.sh

qsub /media/inter/mkapun/projects/MinION_barcoding/shell/NGSspeciesID_qsub.sh

echo '''

#!/bin/sh

## name of Job
#PBS -N NGSspeciesID

## Redirect output stream to this file.
#PBS -o /media/inter/mkapun/projects/MinION_barcoding/NGSspeciesID_log.txt

## Stream Standard Output AND Standard Error to outputfile (see above)
#PBS -j oe

## Select a maximum of 20 cores and 200gb of RAM
#PBS -l select=1:ncpus=20:mem=200gb

######## load dependencies #######

conda activate NGSpeciesID

######## run analyses - single sample and Racon #######

NGSpeciesID  \
  --ont \
  --consensus \
  --sample_size 1000 \
  --m 800 \
  --s 100 \
  --t 20 \
  --racon \
  --primer_file /media/inter/mkapun/projects/MinION_barcoding/data/test/Supplementary_File3_primer.txt \
  --fastq /media/inter/mkapun/projects/MinION_barcoding/data/subset.fastq \
  --outfolder /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_racon

''' > /media/inter/mkapun/projects/MinION_barcoding/shell/NGSspeciesID_qsub.sh

qsub /media/inter/mkapun/projects/MinION_barcoding/shell/NGSspeciesID_qsub.sh

echo '''

#!/bin/sh

## name of Job
#PBS -N NGSspeciesID

## Redirect output stream to this file.
#PBS -o /media/inter/mkapun/projects/MinION_barcoding/NGSspeciesID_log.txt

## Stream Standard Output AND Standard Error to outputfile (see above)
#PBS -j oe

## Select a maximum of 20 cores and 200gb of RAM
#PBS -l select=1:ncpus=20:mem=200gb

######## load dependencies #######

conda activate NGSpeciesID

######## run analyses - mixed sample and Medaka #######

NGSpeciesID  \
  --ont \
  --consensus \
  --sample_size 1000 \
  --m 800 \
  --s 100 \
  --t 20 \
  --medaka \
  --primer_file /media/inter/mkapun/projects/MinION_barcoding/data/test/Supplementary_File3_primer.txt \
  --fastq /media/inter/mkapun/projects/MinION_barcoding/data/subset.fastq \
  --outfolder /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_mixed

''' > /media/inter/mkapun/projects/MinION_barcoding/shell/NGSspeciesID_qsub.sh

qsub /media/inter/mkapun/projects/MinION_barcoding/shell/NGSspeciesID_qsub.sh

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
  -outfmt "6 qseqid sseqid sscinames slen qlen pident length mismatch gapopen qstart qend sstart send evalue bitscore" \
  -db /media/scratch/NCBI_nt_DB_210714/nt \
  -query /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus/consensus_reference_4.fasta \
  > /media/inter/mkapun/projects/MinION_barcoding/results/blast/blastn.txt

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

module load Tools/amplicon_sorter

######## run analyses - single sample  #######

python3.6 amplicon_sorter.py \
  -i /media/inter/mkapun/projects/MinION_barcoding/data/subset.fastq \
  -o /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_ampS \
  -np 4 \
  -min 600 \
  -max 1000 \
  -maxr 1000

''' > /media/inter/mkapun/projects/MinION_barcoding/shell/ampliconsorter_qsub.sh

qsub /media/inter/mkapun/projects/MinION_barcoding/shell/ampliconsorter_qsub.sh



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

module load Tools/amplicon_sorter

######## run analyses - mixed sample  #######

python3.6 amplicon_sorter.py \
  -i /media/inter/mkapun/projects/MinION_barcoding/data/subset.fastq \
  -o /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_ampS \
  -np 4 \
  -min 600 \
  -max 1000 \
  -maxr 1000 \
  -sc 93 \
  -ssg 85

######## run analyses #######

blastn \
  -num_threads 20 \
  -evalue 1e-100 \
  -outfmt "6 qseqid sseqid sscinames slen qlen pident length mismatch gapopen qstart qend sstart send evalue bitscore" \
  -db /media/scratch/NCBI_nt_DB_210714/nt \
  -query /media/inter/mkapun/projects/MinION_barcoding/results/subset_consensus_ampS \
  > /media/inter/mkapun/projects/MinION_barcoding/results/blast/blastn.txt

''' > /media/inter/mkapun/projects/MinION_barcoding/shell/BlastN_qsub.sh

qsub /media/inter/mkapun/projects/MinION_barcoding/shellBlastN_qsub.sh
