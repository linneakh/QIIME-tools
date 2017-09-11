#!/bin/bash

source activate qiime2-2017.8

FILEPATH=$1

mkdir $FILEPATH/alpha-group-significance

qiime diversity alpha-group-significance \
  --i-alpha-diversity $FILEPATH/faith_pd_vector.qza \
  --m-metadata-file sample-metadata.txt \
  --o-visualization $FILEPATH/alpha-group-significance/faith-pd-group-significance.qzvA

qiime diversity alpha-group-significance \
  --i-alpha-diversity $FILEPATH/evenness_vector.qza \
  --m-metadata-file sample-metadata.txt \
  --o-visualization $FILEPATH/alpha-group-significance/evenness-group-significance.qzv

qiime diversity alpha-group-significance \
  --i-alpha-diversity $FILEPATH/observed_otus_vector.qza \
  --m-metadata-file sample-metadata.txt \
  --o-visualization $FILEPATH/alpha-group-significance/observed-otus-group-significance.qzv

qiime diversity alpha-group-significance \
  --i-alpha-diversity $FILEPATH/shannon_vector.qza \
  --m-metadata-file sample-metadata.txt \
  --o-visualization $FILEPATH/alpha-group-significance/shannon-group-significance.qzv


