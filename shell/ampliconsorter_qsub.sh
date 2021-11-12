
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


