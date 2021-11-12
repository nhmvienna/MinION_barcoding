
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


