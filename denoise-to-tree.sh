#!/bin/bash

#PBS -N denoise
#PBS -m bea
#PBS -M linneah@email.arizona.edu
#PBS -W group_list=donata
#PBS -q standard
#PBS -l select=1:ncpus=28:mem=168gb:pcmem=6gb
#PBS -l walltime=200:00:00
#PBS -l cput=5600:00:00

FILEPATH=Practice
TRIMLF=10
TRIMLR=10
TRUNCF=150
TRUNCR=150

module load unsupported
module load donata/miniconda/3/3
source activate qiime2-2017.7
cd /extra/linneah/QIIME2/$FILEPATH

echo "my job_id is: ${PBS_JOBID}"

qiime dada2 denoise-paired --i-demultiplexed-seqs demux.qza --o-table table.qza --o-representative-sequences rep-seqs.qza --p-trim-left-f $TRIMLF --p-trim-left-r $TRIMLR --p-trunc-len-f $TRUNCF --p-trunc-len-r $TRUNCR --verbose --p-n-threads 28
qiime feature-table summarize --i-table table.qza --o-visualization table.qzv --m-sample-metadata-file sample-metadata.txt
qiime feature-table tabulate-seqs --i-data rep-seqs.qza --o-visualization rep-seqs.qzv
qiime alignment mafft --i-sequences rep-seqs.qza --o-alignment aligned-rep-seqs.qza
qiime alignment mask --i-alignment aligned-rep-seqs.qza --o-masked-alignment masked-aligned-rep-seqs.qza
qiime phylogeny fasttree --i-alignment masked-aligned-rep-seqs.qza --o-tree unrooted-tree.qza
qiime phylogeny midpoint-root --i-tree unrooted-tree.qza --o-rooted-tree rooted-tree.qza
