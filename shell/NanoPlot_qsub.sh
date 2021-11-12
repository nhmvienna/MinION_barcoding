
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


