
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

  
