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
  -o /media/inter/mkapun/projects/MinION_barcoding/.results/amplicon_sorter_c1a \
  -np 200 \
  -min 600 \
  -max 1000 \
  -maxr 300

python /opt/bioinformatics/amplicon_sorter/amplicon_sorter.py \
  -i /media/inter/mkapun/projects/MinION_barcoding/data/test/Supplementary_File1_reads.fastq \
  -o /media/inter/mkapun/projects/MinION_barcoding/.results/amplicon_sorter_mixed \
  -np 20 \
  -min 600 \
  -max 1000 \
  -maxr 900 \
  -sc 93 \
  -ssg 85

''' > /media/inter/mkapun/projects/MinION_barcoding/shell/ampliconsorter_qsub.sh

qsub /media/inter/mkapun/projects/MinION_barcoding/shell/ampliconsorter_qsub.sh

### decona


### test decona

mkdir /media/inter/mkapun/projects/MinION_barcoding/results/decona

cp /media/inter/mkapun/projects/MinION_barcoding/data/test/sample_c1.fastq /media/inter/mkapun/projects/MinION_barcoding/results/decona

cd /media/inter/mkapun/projects/MinION_barcoding/results/decona

conda activate decona

/opt/bioinformatics/decona/decona/bin/decona \
  -d \
  -l 600 \
  -m 1000 \
  -q 7 \
  -c 0.80 \
  -n 100 \
  -M \
  -T 20


### compress output folder
tar -czvf /media/inter/mkapun/projects/MinION_barcoding/results.tar.gz /media/inter/mkapun/projects/MinION_barcoding/results

tar -czvf /media/inter/mkapun/projects/MinION_barcoding/data.tar.gz /media/inter/mkapun/projects/MinION_barcoding/data
