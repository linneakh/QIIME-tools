#!/bin/bash

source activate qiime2-2017.8

set -u

if [[ $# -lt 2 ]]; then
        printf "Usage: %s filepath category\n" $0
        exit 1
fi


FILEPATH=$1
GROUP=$2

mkdir $FILEPATH/bd-group-significance/

qiime diversity beta-group-significance --i-distance-matrix $FILEPATH/unweighted_unifrac_distance_matrix.qza --m-metadata-file sample-metadata.txt --m-metadata-category $GROUP --o-visualization $FILEPATH/bd-group-significance/unweighted-unifrac-$GROUP-significance.qzv --p-pairwise
qiime diversity beta-group-significance --i-distance-matrix $FILEPATH/weighted_unifrac_distance_matrix.qza --m-metadata-file sample-metadata.txt --m-metadata-category $GROUP --o-visualization $FILEPATH/bd-group-significance/weighted-unifrac-$GROUP-significance.qzv --p-pairwise
qiime diversity beta-group-significance --i-distance-matrix $FILEPATH/jaccard_distance_matrix.qza --m-metadata-file sample-metadata.txt --m-metadata-category $GROUP --o-visualization $FILEPATH/bd-group-significance/jaccard-$GROUP-significance.qzv --p-pairwise
qiime diversity beta-group-significance --i-distance-matrix $FILEPATH/bray_curtis_distance_matrix.qza --m-metadata-file sample-metadata.txt --m-metadata-category $GROUP --o-visualization $FILEPATH/bd-group-significance/bray-curtis-distance-$GROUP-significance --p-pairwise

echo done


