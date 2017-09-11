#!/bin/bash

source activate qiime2-2017.8

set -u

if [[ $# -lt 1 ]]; then
	printf "Usage: %s DEPTH\n" $0
	exit 1
fi

DEPTH=$1

qiime diversity core-metrics --i-phylogeny rooted-tree.qza --i-table table.qza --p-sampling-depth $DEPTH --output-dir cm$DEPTH
qiime emperor plot --i-pcoa cm$DEPTH/unweighted_unifrac_pcoa_results.qza --m-metadata-file sample-metadata.txt --o-visualization cm$DEPTH/unweighted-unifrac-emperor.qzv
qiime emperor plot --i-pcoa cm$DEPTH/weighted_unifrac_pcoa_results.qza --m-metadata-file sample-metadata.txt --o-visualization cm$DEPTH/weighted-unifrac-emperor.qzv
qiime emperor plot --i-pcoa cm$DEPTH/jaccard_pcoa_results.qza --m-metadata-file sample-metadata.txt --o-visualization cm$DEPTH/jaccard-emperor.qzv
qiime emperor plot --i-pcoa cm$DEPTH/bray_curtis_pcoa_results.qza --m-metadata-file sample-metadata.txt --o-visualization cm$DEPTH/bray_curtis-emperor.qzv

echo done
