#!/bin/bash

#PBS -N demultiplex
#PBS -m bea
#PBS -M linneah@email.arizona.edu
#PBS -W group_list=donata
#PBS -q standard
#PBS -l select=1:ncpus=1:mem=5gb
#PBS -l place=pack:shared
#PBS -l walltime=10:00:00
#PBS -l cput=10:00:00

module load unsupported
module load donata/miniconda/3/3
source activate qiime2-2017.7

#Fill in file path
cd /rsgrp/donata/AMISH-HUTT-PROJECT/160217_Vercelli_Theriault_16S_fastqs

qiime tools import \
	--type EMPPairedEndSequences \
	--input-path emp-paired-end-sequences
	--output-path emp-paired-end-sequences.qza
qiime demux emp-paired \
	--m-barcodes-file mapping_file.txt \
	--m-barcodes-category BarcodeSequence \
	--i-seqs emp-paired-end-sequences.qza \
	--o-per-sample-sequences demux.qza \
	--verbose
qiime demux summarize \
	--i-data demux.qza \
	--o-visualization demux.qzv \
	--verbose
qiime dada2 plot-qualities \
	--i-demultiplexed-seqs \
	--p-n 10 \
	--o-visualization demux-qual-plots.qzv
 
